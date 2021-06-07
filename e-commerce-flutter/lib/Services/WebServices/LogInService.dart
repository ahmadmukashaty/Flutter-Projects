import 'dart:convert';
import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Authentication/LogInInfo.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Services/Network_Cache_Management/Networking.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Services/Management/CountryManagement.dart';
import 'package:oneaddress/Utilities/Constants.dart';
import 'package:oneaddress/Utilities/JsonResponse.dart';

import 'CountryService.dart';

class LogInService {
  LogInInfo logInInfo;
  LogInService({this.logInInfo});

  Future<JsonResponse> getUserInfo() async {
    NetworkHelper networkHelper = NetworkHelper(kLogInUrl);

    var userData = await networkHelper.postData(this.logInInfo.toJson());
    if (userData == null) {
      return JsonResponse(
        status: 400,
        msg: "Failed to login",
        result: null,
      );
    }

    final int responseStatus = JSONUtils().get(
      userData,
      'status',
      400,
    );
    String errorMessage = JSONUtils().get(userData, 'msg', "Failed to login");
    if (responseStatus != 200) {
      if (errorMessage.length == 0) {
        errorMessage = "Failed to login";
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
        msg: "Failed to login",
        result: null,
      );
    }

    SharedPref sharedPref = SharedPref();
    await sharedPref.save(kUserKey, jsonEncode(userData));

    User user = User.fromJson(parsedUser);
    Country country = Country(
      id: user.countryId,
      name: user.countryName,
    );
    await sharedPref.saveCountryInfo(country);
    CountryManagement.updateCountry(country);

    return JsonResponse(
      status: 200,
      msg: "",
      result: user,
    );
  }
}
