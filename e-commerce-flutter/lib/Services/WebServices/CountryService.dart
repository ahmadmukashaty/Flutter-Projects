import 'dart:convert';

import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class CountryService {
  Future<dynamic> saveCountryInfoInCache(Country country) async {
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(kCountryKey, jsonEncode(country));
    return true;
  }

  Future<dynamic> getCountryInfoFromCache() async {
    SharedPref sharedPref = SharedPref();
    String countryData = await sharedPref.read(kCountryKey);
    return jsonDecode(countryData);
  }
}
