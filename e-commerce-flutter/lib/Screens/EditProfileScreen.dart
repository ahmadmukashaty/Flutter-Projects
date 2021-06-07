import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/Authentication/Language.dart';
import 'package:oneaddress/Classes/Authentication/UpdateUserInfo.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Components/AuthenticationComponents/LanguageDropDown.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/WebServices/UpdateProfileService.dart';
import 'package:oneaddress/Utilities/JsonResponse.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  User userInfo;
  Language selectedLanguage = LanguageManagement.getLang();

  void initState() {
    userInfo = Authentication.userData();
    getUserInfo();
    super.initState();
  }

  void getUserInfo() {
    firstNameController.text = userInfo.firstName;
    lastNameController.text = userInfo.lastName;
    emailAddressController.text = userInfo.email;
    phoneNumberController.text = userInfo.phone;
  }

  updateUser(BuildContext context, UpdateUserInfo userInfo) async {
    showLoadingDialog();
    String textMessage = "";
    Color textColor;
    JsonResponse response =
        await UpdateProfileService(userInfo: userInfo).updateUserInfo(
      lang: selectedLanguage,
    );
    if (response.status != 200) {
      textMessage = "failed to update profile".tr();
      textColor = Colors.red;
    } else {
      //display success
      await Authentication.checkAuth();
      textMessage = "your profile has been updated successfully".tr();
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
    }
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
          'edit profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ).tr(),
        backgroundColor: Colors.white,
      ),
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
                              return 'oops! you need to type your phone number '
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
                              return 'Oops! You need to type your first name '
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
                              return 'oops! you need to type your last name '
                                      'here'
                                  .tr();
                            }
                            return null;
                          },
                        ),
                      ),
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
                                UpdateUserInfo user = UpdateUserInfo(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  phone: phoneNumberController.text,
                                  email: emailAddressController.text,
                                  emailAddress: emailAddressController.text,
                                  id: userInfo.id,
                                  password: null,
                                );
                                await updateUser(context, user);
                              }
                            },
                            child: Text(
                              "update profile".tr(),
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
