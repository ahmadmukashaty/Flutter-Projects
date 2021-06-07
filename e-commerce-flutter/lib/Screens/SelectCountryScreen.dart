import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Classes/CountryList/CountryList.dart';
import 'package:oneaddress/Components/AuthenticationComponents/CountryDropDown.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/WebServices/CountryListService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'ChangeLanguageScreen.dart';

class SelectCountryScreen extends StatefulWidget {
  final CountryCallback countryCallback;

  SelectCountryScreen({
    @required this.countryCallback,
  });

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  final _formKey = GlobalKey<FormState>();
  Country selectedCountry = Country();
  CountryList countryList;

  bool loading = true;

  @override
  void initState() {
    getListCountriesData();
    super.initState();
  }

  void getListCountriesData() async {
    List<Country> listCountriesData =
        await CountryListService().getCountryInfo();
    countryList = CountryList.clone(countries: listCountriesData);

    for (int i = 0; i < countryList.countries.length; i++) {
      if (i == 0) {
        selectedCountry = countryList.countries[i];
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.locale = LanguageManagement.getLocale();

    return (loading)
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                title: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  // action button
                  IconButton(
                    icon: Icon(Icons.language),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ChangeLanguageScreen.routeName,
                      );
                    },
                  ),
                  // action button
                ]),
            backgroundColor: Colors.white,
            body: Builder(
              builder: (BuildContext context) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: _sizedContainerSignIn(
                                Image(
                                  image: AssetImage('images/OneAddress'
                                      '.jpg'),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 30.0,
                          ),
                          child: Text(
                            "please select your country",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ).tr(),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25.0,
                                  right: 25.0,
                                  top: 25.0,
                                  bottom: 30.0,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: CountryDropDown(
                                    countries: countryList.countries,
                                    onCountryChange: (Country country) =>
                                        setState(
                                      () => selectedCountry = country,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25.0,
                                  right: 25.0,
                                  top: 15.0,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: FlatButton(
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    padding: EdgeInsets.all(15.0),
                                    onPressed: () async {
                                      widget.countryCallback(selectedCountry);
                                    },
                                    child: Text(
                                      "start shopping",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ).tr(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget _sizedContainerSignIn(Widget child) => SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        height: 100.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            right: 10.0,
            bottom: 10.0,
            left: 10.0,
          ),
          child: Center(child: child),
        ),
      );
}

typedef CountryCallback = void Function(Country country);
