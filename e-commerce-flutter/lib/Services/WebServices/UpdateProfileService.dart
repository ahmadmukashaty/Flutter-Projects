import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Authentication/Language.dart';
import 'package:oneaddress/Classes/Authentication/UpdateUserInfo.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Authentication/UserInfo.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/Network_Cache_Management/Networking.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Services/WebServices/CountryService.dart';
import 'package:oneaddress/Utilities/Constants.dart';
import 'package:oneaddress/Utilities/JsonResponse.dart';

class UpdateProfileService {
  UpdateUserInfo userInfo;
  UpdateProfileService({
    @required this.userInfo,
  });

  Future<JsonResponse> updateUserInfo({
    Language lang,
  }) async {
    await updateLanguage(lang);
    NetworkHelper networkHelper = NetworkHelper(kEditProfileUrl);

    var userData = await networkHelper.postData(this.userInfo.toJson());
    if (userData == null) {
      return JsonResponse(
        status: 400,
        msg: "Failed to register",
        result: null,
      );
    }

    final int responseStatus = JSONUtils().get(
      userData,
      'status',
      400,
    );
    String errorMessage =
        JSONUtils().get(userData, 'msg', "Failed to register");
    if (responseStatus != 200) {
      if (errorMessage.length == 0) {
        errorMessage = "Failed to register";
      }
      return JsonResponse(
        status: 400,
        msg: errorMessage,
        result: null,
      );
    }

    final dynamic parsedUser = JSONUtils().get(
      userData,
      'result',
      null,
    );

    if (parsedUser == null || parsedUser.toString().length == 0) {
      return JsonResponse(
        status: 400,
        msg: "Failed to register",
        result: null,
      );
    }

    SharedPref sharedPref = SharedPref();
    await sharedPref.save(kUserKey, jsonEncode(userData));
    await Authentication.checkAuth();

    return JsonResponse(
      status: 200,
      msg: "",
      result: null,
    );
  }

  Future<void> updateLanguage(Language lang) async {
    if (lang != null && !LanguageManagement.equalLang(lang)) {
      SharedPref sharedPref = SharedPref();
      await sharedPref.save(kLangKey, jsonEncode(lang));
      await LanguageManagement.checkLang();
    }
  }
}
