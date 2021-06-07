import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Cart/CartProductList.dart';
import 'package:oneaddress/Classes/Order/RequesterInfo.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'OrderDetailsScreen.dart';

class OrderPersonalDetailsScreen extends StatefulWidget {
  final CartProductList products;
  final User userInfo;

  OrderPersonalDetailsScreen({
    this.products,
    this.userInfo,
  });

  @override
  _OrderPersonalDetailsScreenState createState() =>
      _OrderPersonalDetailsScreenState();
}

class _OrderPersonalDetailsScreenState
    extends State<OrderPersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final additionalPhoneNumberController = TextEditingController();
  final noteController = TextEditingController();

  bool loading = true;
  bool authorized = false;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  void getUserInfo() {
    loading = false;
    authorized = true;
    firstNameController.text = widget.userInfo.firstName;
    lastNameController.text = widget.userInfo.lastName;
    emailAddressController.text = widget.userInfo.emailAddress;
    phoneNumberController.text = widget.userInfo.phone;
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
                'back'.tr() +
                    ((authorized)
                        ? (" (" +
                            firstNameController.text +
                            " "
                                "" +
                            lastNameController.text +
                            ") ")
                        : ""),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 30.0,
                        top: 10.0,
                        bottom: 20.0,
                      ),
                      child: Text(
                        "order details",
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
                              readOnly: true,
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
                                  return 'oops! you need to type your first '
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
                              readOnly: true,
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
                              readOnly: true,
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
                                  return 'oops! you need to type your phone '
                                          'number '
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
                              controller: additionalPhoneNumberController,
                              decoration: InputDecoration(
                                labelText: "additional phone number".tr(),
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
                              controller: addressController,
                              decoration: InputDecoration(
                                labelText: "address".tr(),
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
                                  return 'oops! you need to type your address '
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
                              minLines: 1,
                              maxLines: 5,
                              controller: noteController,
                              decoration: InputDecoration(
                                labelText: "notes".tr(),
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
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: Colors.white,
              height: 80.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 20.0,
                      right: 15.0,
                    ),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            RequesterInfo requesterInfo = RequesterInfo(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              address: addressController.text,
                              email: emailAddressController.text,
                              phoneNumber: phoneNumberController.text,
                              additionalPhoneNumber:
                                  additionalPhoneNumberController.text,
                              countryName: widget.userInfo.countryName,
                              userId: widget.userInfo.id,
                              countryId: widget.userInfo.countryId,
                              notes: noteController.text,
                            );
                            Navigator.push(
                              context,
                              ProductRouteAnimation(
                                widget: OrderDetailsScreen(
                                  requesterInfo: requesterInfo,
                                  products: widget.products,
                                ),
                              ),
                            );
                          }
                        },
                        disabledColor: Color.fromRGBO(0, 0, 0, 1),
                        disabledTextColor: Color.fromRGBO(255, 255, 255, 0.7),
                        child: Text(
                          "next",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ).tr(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
