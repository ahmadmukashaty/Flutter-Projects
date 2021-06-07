import 'dart:convert';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Services/Network_Cache_Management/Networking.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class CountryListService {
  Future<dynamic> getCountryInfo() async {
    NetworkHelper networkHelper = NetworkHelper(kCountriesUrl);

    var countriesData = await networkHelper.getDataWithKey(kCountriesKey);
    final List parsedList = JSONUtils().get(countriesData, 'result', null);
    if (parsedList == null) return [];
    List<Country> countries =
        parsedList.map((val) => Country.fromJson(val)).toList();

    return countries;
  }

  Future<dynamic> saveCountryInfoInCache(Country country) async {
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(kCountriesKey, jsonEncode(country));
    return true;
  }
}
