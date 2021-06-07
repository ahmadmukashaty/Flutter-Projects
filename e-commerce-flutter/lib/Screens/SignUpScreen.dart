import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Authentication/UserInfo.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Classes/CountryList/CountryList.dart';
import 'package:oneaddress/Components/AuthenticationComponents/CountryDropDown.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Services/WebServices/CountryListService.dart';
import 'package:oneaddress/Services/WebServices/RegisterService.dart';
import 'package:oneaddress/Utilities/JsonResponse.dart';
import 'package:easy_localization/easy_localization.dart';

import 'ChangeLanguageScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUp';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  Country selectedCountry = Country();

  CountryList countryList;
  bool loading = true;

  void initState() {
    countryList = CountryList();
    getListCountriesData();
    super.initState();
  }

  void getListCountriesData() async {
    List<Country> listCountriesData =
        await CountryListService().getCountryInfo();
    countryList = CountryList.clone(countries: listCountriesData);
    setState(() {
      loading = false;
    });
    for (int i = 0; i < countryList.countries.length; i++) {
      if (i == 0) {
        selectedCountry = countryList.countries[i];
      }
    }
  }

  registerUser(BuildContext context, UserInfo userInfo) async {
    showLoadingDialog();
    String textMessage = "";
    Color textColor;
    JsonResponse response =
        await RegisterService(userInfo: userInfo).getUserInfo();
    await Authentication.checkAuth();
    if (response.status != 200) {
      textMessage = "failed to register".tr();
      textColor = Colors.red;
    } else {
      //display success
      User user = Authentication.userData();
      textMessage =
          "welcome".tr() + " " + user.firstName + " " + user.lastName + "!";
      textColor = Colors.green;
    }
    hideLoadingDialog();
    final snackBar = SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          textMessage,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
    );
    Scaffold.of(context).showSnackBar(snackBar);
    if (response.status == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                title: Text(
                  'sign up',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ).tr(),
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
            body: Builder(builder: (BuildContext context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: _sizedContainerSignUp(
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
                          left: 30.0,
                          right: 30.0,
                          top: 10.0,
                          bottom: 20.0,
                        ),
                        child: Text(
                          "sign up using your email address",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            height: 2.0,
                            letterSpacing: 2.0,
                          ),
                        ).tr(),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 15.0,
                              ),
                              child: TextFormField(
                                controller: emailAddressController,
                                decoration: InputDecoration(
                                  labelText: "email address".tr(),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                cursorColor: Colors.blueAccent,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'oops! you need to type your email'
                                            ' address '
                                            'here'
                                        .tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 15.0,
                              ),
                              child: TextFormField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  labelText: "first name".tr(),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                cursorColor: Colors.blueAccent,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'oops! you need to type your first'
                                            ' name '
                                            'here'
                                        .tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 15.0,
                              ),
                              child: TextFormField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  labelText: "last name".tr(),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                cursorColor: Colors.blueAccent,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'oops! you need to type your last '
                                            'name '
                                            'here'
                                        .tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 15.0,
                              ),
                              child: TextFormField(
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                  labelText: "phone number".tr(),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                ],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                cursorColor: Colors.blueAccent,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'oops! you need to type your phone'
                                            ' number '
                                            'here'
                                        .tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 15.0,
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "password".tr(),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                cursorColor: Colors.blueAccent,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'oops! you need to type your password here'
                                        .tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 5.0,
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
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 16.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text.rich(
                                  TextSpan(
                                    text: 'by creating your account, you agree '
                                                'to our'
                                            .tr() +
                                        ' ',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      height: 1.5,
                                      letterSpacing: 1.2,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'terms and conditions'.tr(),
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' & ',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'privacy policy'.tr() + '.',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // can add more TextSpans here...
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 10.0,
                              ),
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 5.0,
                                bottom: 30.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(15.0),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      UserInfo userInfo = UserInfo(
                                        username: emailAddressController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        password: passwordController.text,
                                        email: emailAddressController.text,
                                        countryId: selectedCountry.id,
                                        phone: phoneNumberController.text,
                                      );
                                      await registerUser(context, userInfo);
                                    }
                                  },
                                  child: Text(
                                    "join one address",
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
            }),
          );
  }

  Widget _sizedContainerSignUp(Widget child) => SizedBox(
        width: MediaQuery.of(context).size.width,
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
