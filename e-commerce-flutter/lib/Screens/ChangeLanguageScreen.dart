import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/Authentication/Language.dart';
import 'package:oneaddress/Components/AuthenticationComponents/LanguageDropDown.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class ChangeLanguageScreen extends StatefulWidget {
  static const routeName = '/language';
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final _formKey = GlobalKey<FormState>();
  Language selectedLanguage = LanguageManagement.getLang();

  updateLanguage(BuildContext context) async {
    showLoadingDialog();

    await LanguageManagement.updateLanguage(selectedLanguage);
    setState(() {
      hideLoadingDialog();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            'back',
            style: TextStyle(
              color: Colors.black,
            ),
          ).tr(),
          backgroundColor: Colors.white),
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 25.0,
                          top: 15.0,
                          bottom: 10.0,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "language",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ).tr(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 25.0,
                          top: 5.0,
                          bottom: 30.0,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: LanguageDropDown(
                            languages: LanguageManagement.getAllLanguages(),
                            onLanguageChange: (Language lang) => setState(
                              () => selectedLanguage = lang,
                            ),
                          ),
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
                                await updateLanguage(context);
                              }
                            },
                            child: Text(
                              "change language".tr(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
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
