import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';

class CountryManagement {
  static Country _country;

  static checkCountry() async {
    SharedPref sharedPref = SharedPref();
    _country = await sharedPref.getCountryInfo();
  }

  static updateCountry(Country newCountry) async {
    _country = newCountry;
  }

  static Country countryData() {
    return _country;
  }

  static bool isSyria() {
    if (_country == null) return false;
    return (_country.name.toLowerCase() == "syria");
  }
}
