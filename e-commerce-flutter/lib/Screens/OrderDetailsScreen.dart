import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:oneaddress/Classes/Cart/CartProductList.dart';
import 'package:oneaddress/Classes/Order/RequesterInfo.dart';
import 'package:intl/intl.dart';
import 'package:oneaddress/Components/Order/OrderProduct.dart';
import 'package:oneaddress/Screens/ViewOrdersScreen.dart';
import 'package:oneaddress/Services/WebServices/OrderService.dart';
import 'package:oneaddress/Utilities/CustomAppBar.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDetailsScreen extends StatefulWidget {
  final CartProductList products;
  final RequesterInfo requesterInfo;

  OrderDetailsScreen({
    this.requesterInfo,
    this.products,
  });

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final ScrollController controller = ScrollController();
  final OrderService orderService = OrderService();
  int couponValue = 0;
  String couponCode;

  @override
  void initState() {
    couponCode = null;
    super.initState();
  }

  getNowDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    return formatted;
  }

  Future<String> couponAlertDialog(BuildContext context) {
    TextEditingController couponController = TextEditingController();
    String errorText = "";
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                "your coupon ?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ).tr(),
              content: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                  vertical: 0.0,
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: couponController,
                        decoration: InputDecoration(
                          labelText: "enter your coupon".tr(),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          errorText,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5.0,
                    child: Text(
                      "activate",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ).tr(),
                    onPressed: () async {
                      if (couponController.text == null ||
                          couponController.text.length == 0) {
                        setState(() {
                          couponCode = null;
                          errorText = "coupon field is empty!".tr();
                        });
                      } else {
                        int result = await orderService.checkCoupon(
                            widget.requesterInfo.userId, couponController.text);
                        setState(() {
                          couponValue = calculateCouponValue(result);
                          if (result > 0) {
                            couponCode = couponController.text;
                            Navigator.of(context)
                                .pop(couponController.text.toString());
                          } else {
                            errorText = "invalid coupon!".tr();
                            couponCode = null;
                          }
                        });
                      }
                    }),
              ],
            );
          });
        });
  }

  int calculateCouponValue(int value) {
    int newValue = (widget.products.getTotalPrice() * value) ~/ 100;
    return newValue;
  }

  List<Widget> generateCartProductsList() {
    if (widget.products.cart.length == 0) return null;

    List<Widget> list = List<Widget>();

    for (var i = 0; i < widget.products.cart.length; i++) {
      OrderProduct orderProduct = OrderProduct(
        product: widget.products.cart[i],
      );

      list.add(orderProduct);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffecebeb),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 15.0,
                  right: 5.0,
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0.0,
                          bottom: 0.0,
                        ),
                        child: Text(
                          "order info",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ).tr(),
                      ),
                    ],
                  ),
                ),
              ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "buyer".tr() +
                                            " : " +
                                            widget.requesterInfo.firstName +
                                            " " +
                                            widget.requesterInfo.lastName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "date".tr() + " : " + getNowDate(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "first name".tr() +
                                            " : " +
                                            widget.requesterInfo.firstName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "last name".tr() +
                                            " : " +
                                            widget.requesterInfo.lastName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width - 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "email".tr() +
                                            " : " +
                                            widget.requesterInfo.email,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width - 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "country".tr() +
                                            " : " +
                                            widget.requesterInfo.countryName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width - 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "phone no".tr() +
                                            " : " +
                                            widget.requesterInfo.phoneNumber,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width - 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "extra phone no".tr() +
                                            " : " +
                                            widget.requesterInfo
                                                .additionalPhoneNumber,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width - 25,
                                height: 1.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "subtotal".tr() +
                                            " : " +
                                            (widget.products
                                                    .getTotalPrice()
                                                    .round())
                                                .toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "taxes".tr() + " : 0 SYP",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "coupon".tr() +
                                            " : " +
                                            (-1 * couponValue).toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "total".tr() +
                                            " : " +
                                            ((widget.products.getTotalPrice() -
                                                        couponValue)
                                                    .round())
                                                .toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        " ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        " ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        couponAlertDialog(context)
                                            .then((onValue) {
                                          print(onValue);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          right: 8.0,
                                          left: 8.0,
                                        ),
                                        child: Text(
                                          "use coupon",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14.0,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 2.0,
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
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0.0,
                          bottom: 0.0,
                        ),
                        child: Text(
                          "products",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ).tr(),
                      ),
                    ],
                  ),
                ),
              ),
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
                      children: generateCartProductsList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Builder(builder: (BuildContext context) {
        return Container(
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
                    onPressed: () async {
                      _showSnackBar(context);
                    },
                    disabledColor: Color.fromRGBO(0, 0, 0, 1),
                    disabledTextColor: Color.fromRGBO(255, 255, 255, 0.7),
                    child: Text(
                      "confirm order",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ).tr(),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void _showSnackBar(BuildContext context) async {
    showLoadingDialog();
    bool res = await orderService.submitOrder(widget.requesterInfo, couponCode);
    final snackBar = SnackBar(
      content: Text(
        (res)
            ? "order has been submitted successfully".tr()
            : "failed to register your order".tr(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black,
      action: (res)
          ? SnackBarAction(
              label: 'view order'.tr(),
              textColor: Colors.blue,
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    ProductRouteAnimation(
                      widget: ViewOrdersScreen(),
                    ),
                  );
                });
              },
            )
          : null,
    );
    hideLoadingDialog();
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
