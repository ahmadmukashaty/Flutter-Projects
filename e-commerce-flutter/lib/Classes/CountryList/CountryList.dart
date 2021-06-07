import 'package:oneaddress/Classes/CountryList/Country.dart';

class CountryList {
  List<Country> countries;

  CountryList();

  CountryList.clone({this.countries});

  getCountryList() {
    return this.countries;
  }
}
