import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Services/WebServices/ProfileService.dart';
import 'package:easy_localization/easy_localization.dart';

import 'ChangeLanguageScreen.dart';

class ForgetPassScreen extends StatefulWidget {
  static const routeName = '/forgetPass';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<ForgetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailAddressController = TextEditingController();

  void initState() {
    emailAddressController.text = "";
    super.initState();
  }

  sendNewPasswordInMessage(BuildContext context, String username) async {
    showLoadingDialog();
    String textMessage = "";
    bool success = await ProfileService().sendNewPasswordSMS(username);
    if (!success) {
      textMessage = "failed to send SMS message!".tr();
    } else {
      //display success
      textMessage = "new password SMS has been sent successfully".tr();
    }
    hideLoadingDialog();
    final snackBar = SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          textMessage,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black,
    );
    Scaffold.of(context).showSnackBar(snackBar);
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
            'forget password',
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
                      padding: const EdgeInsets.only(top: 50.0),
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
                              return 'oops! you need to type your email address here'
                                  .tr();
                            }
                            return null;
                          },
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
                                String username = emailAddressController.text;
                                await sendNewPasswordInMessage(
                                    context, username);
                              }
                            },
                            child: Text(
                              "send new password via SMS",
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
