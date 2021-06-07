import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/Authentication/UpdateUserInfo.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Authentication/UserInfo.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/WebServices/RegisterService.dart';
import 'package:oneaddress/Services/WebServices/UpdateProfileService.dart';
import 'package:oneaddress/Utilities/JsonResponse.dart';
import 'package:easy_localization/easy_localization.dart';

import 'ChangeLanguageScreen.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/changePass';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  User userInfo;

  void initState() {
    userInfo = Authentication.userData();
    getUserInfo();
    super.initState();
  }

  void getUserInfo() {
    emailAddressController.text = userInfo.email;
    passwordController.text = "";
  }

  changePassword(BuildContext context, UpdateUserInfo userInfo) async {
    showLoadingDialog();
    String textMessage = "";
    Color textColor;
    JsonResponse response =
        await UpdateProfileService(userInfo: userInfo).updateUserInfo(
      lang: LanguageManagement.getLang(),
    );
    if (response.status != 200) {
      textMessage = "failed to update password".tr();
      textColor = Colors.white;
    } else {
      //display success
      await Authentication.checkAuth();
      textMessage = "your password has been updated successfully".tr();
      textColor = Colors.white;
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
            'change password',
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
                          readOnly: true,
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
                          vertical: 15.0,
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: "new password".tr(),
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
                              return 'oops! you need to type your new password '
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
                                User user = Authentication.userData();
                                UpdateUserInfo userInfo = UpdateUserInfo(
                                  id: user.id,
                                  phone: user.phone,
                                  password: passwordController.text,
                                  firstName: user.firstName,
                                  lastName: user.lastName,
                                  email: user.email,
                                  emailAddress: user.emailAddress,
                                );
                                await changePassword(context, userInfo);
                              }
                            },
                            child: Text(
                              "change passwordC".tr(),
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
