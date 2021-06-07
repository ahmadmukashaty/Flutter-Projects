import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/Authentication/LogInInfo.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Screens/EditProfileScreen.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Screens/SignUpScreen.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/WebServices/CartListService.dart';
import 'package:oneaddress/Services/Management/CountryManagement.dart';
import 'package:oneaddress/Services/WebServices/LogInService.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:oneaddress/Utilities/JsonResponse.dart';
import 'package:easy_localization/easy_localization.dart';
import 'ChangeLanguageScreen.dart';
import 'ChangePasswordScreen.dart';
import 'ForgetPassScreen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/logIn';

  final Widget assignedScreen;
  final bool updateCart;
  SignInScreen({
    this.assignedScreen,
    this.updateCart = false,
  });

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool authorized = false;
  String errorMessage = "";
  bool isSyria = false;

  @override
  void initState() {
    isSyria = CountryManagement.isSyria();
    authorized = Authentication.isAuth();
    super.initState();
  }

  loginProcess(BuildContext context, LogInInfo logInInfo) async {
    showLoadingDialog();
    String textMessage = "";
    Color textColor;
    JsonResponse response =
        await LogInService(logInInfo: logInInfo).getUserInfo();
    await Authentication.checkAuth();
    if (widget.updateCart) {
      await CartListService().updateCart();
    }
    hideLoadingDialog();
    if (response.status != 200) {
      setState(() {
        errorMessage = "username or password is incorrect";
      });
    } else {
      User user = Authentication.userData();
      setState(() {
        authorized = true;
      });
      String welcome = "welcome".tr();
      textMessage = welcome + " " + user.firstName + " " + user.lastName + "!";
      textColor = Colors.green;
      final snackBar = SnackBar(
        content: Text(
          textMessage,
          style: TextStyle(
            color: textColor,
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
      );
      Scaffold.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  logoutProcess() async {
    showLoadingDialog();
    await Authentication.removeAuth();
    setState(() {
      authorized = false;
    });
    hideLoadingDialog();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    User userInfo = Authentication.userData();
    return (loading)
        ? LoadingScreen()
        : (authorized)
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    title: Text(
                      userInfo.firstName + " " + userInfo.lastName,
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
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                          ),
                          child: Container(
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 50.0),
                                        child: _sizedContainerSignIn(
                                          Image(
                                            image:
                                                AssetImage('images/OneAddress'
                                                    '.jpg'),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await logoutProcess();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    "logout",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      letterSpacing: 2.0,
                                                      decoration: TextDecoration
                                                          .underline,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "first name".tr() +
                                                      " : " +
                                                      userInfo.firstName,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "last name".tr() +
                                                      " : " +
                                                      userInfo.lastName,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "country".tr() +
                                                      " : " +
                                                      userInfo.countryName,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width / 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "password".tr() + " : *****",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width / 2 - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    ChangePasswordScreen
                                                        .routeName,
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 15.0,
                                                    bottom: 15.0,
                                                    right: 15.0,
                                                    left: 15.0,
                                                  ),
                                                  child: Text(
                                                    "change Password",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      letterSpacing: 2.0,
                                                      decoration: TextDecoration
                                                          .underline,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "email".tr() +
                                                      " : " +
                                                      userInfo.emailAddress,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "phone".tr() +
                                                      " : " +
                                                      userInfo.phone,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "language".tr() +
                                                      " : " +
                                                      LanguageManagement
                                                              .getLang()
                                                          .getValue(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width - 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    EditProfileScreen.routeName,
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 25.0,
                                                    bottom: 25.0,
                                                  ),
                                                  child: Text(
                                                    "edit profile",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      letterSpacing: 2.0,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ).tr(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
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
                body: Builder(
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
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
                                "sign in with email address",
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 20.0,
                                    ),
                                    child: (LanguageManagement.isEnglish())
                                        ? TextFormField(
                                            controller: usernameController,
                                            decoration: const InputDecoration(
                                              hintText: 'USERNAME',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 1.5,
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            ),
                                            cursorColor:
                                                Color.fromRGBO(66, 103, 178, 1),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Username is required';
                                              }
                                              return null;
                                            },
                                          )
                                        : TextFormField(
                                            controller: usernameController,
                                            decoration: const InputDecoration(
                                              hintText: 'اسم المستخدم',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 1.5,
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            ),
                                            cursorColor:
                                                Color.fromRGBO(66, 103, 178, 1),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'لا يمكنك ترك اسم '
                                                    'المستخدم فارغا';
                                              }
                                              return null;
                                            },
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 0.0,
                                    ),
                                    child: (LanguageManagement.isEnglish())
                                        ? TextFormField(
                                            controller: passwordController,
                                            decoration: const InputDecoration(
                                              hintText: 'PASSWORD',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 1.5,
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            ),
                                            obscureText: true,
                                            cursorColor:
                                                Color.fromRGBO(66, 103, 178, 1),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Password is required';
                                              }
                                              return null;
                                            },
                                          )
                                        : TextFormField(
                                            controller: passwordController,
                                            decoration: const InputDecoration(
                                              hintText: 'كلمة المرور',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 1.5,
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      66, 103, 178, 1),
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            ),
                                            obscureText: true,
                                            cursorColor:
                                                Color.fromRGBO(66, 103, 178, 1),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'لا يمكنك ترك كلمة '
                                                    'المرور فارغة';
                                              }
                                              return null;
                                            },
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
                                          if (_formKey.currentState
                                              .validate()) {
                                            LogInInfo logInInfo = LogInInfo(
                                              username: usernameController.text,
                                              password: passwordController.text,
                                            );
                                            await loginProcess(
                                                context, logInInfo);
                                          }
                                        },
                                        child: Text(
                                          "sign in",
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
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 5.0,
                                bottom: 15.0,
                              ),
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ),
                            (isSyria)
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        ForgetPassScreen.routeName,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 0.0,
                                      ),
                                      child: Text(
                                        "forgotten password?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).tr(),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 0.0,
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
                                left: 10.0,
                                right: 10.0,
                                top: 20.0,
                              ),
                              child: Text(
                                "do not have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  ProductRouteAnimation(
                                    widget: SignUpScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0,
                                ),
                                child: Text(
                                  "sign up today",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).tr(),
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
