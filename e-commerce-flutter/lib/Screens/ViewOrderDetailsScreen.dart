import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Order/OrderProductList.dart';
import 'package:oneaddress/Classes/Order/UserOrders.dart';
import 'package:oneaddress/Components/Order/ViewOrderProduct.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/WebServices/OrderService.dart';
import 'package:oneaddress/Utilities/CustomAppBar.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewOrderDetailScreen extends StatefulWidget {
  final UserOrder order;
  final User user;

  ViewOrderDetailScreen({
    this.order,
    this.user,
  });

  @override
  _ViewOrderDetailScreenState createState() => _ViewOrderDetailScreenState();
}

class _ViewOrderDetailScreenState extends State<ViewOrderDetailScreen> {
  final ScrollController controller = ScrollController();
  OrderProductList orderProductList;
  bool loading = true;

  @override
  void initState() {
    getCartProductData();
    super.initState();
  }

  void getCartProductData() async {
    var orderProducts = await OrderService().getUserOrder(widget.order.id);
    orderProductList = OrderProductList(products: orderProducts);

    setState(() {
      loading = false;
    });
  }

  List<Widget> generateOrderProductsList() {
    if (orderProductList.products.length == 0) return [];

    List<Widget> list = List<Widget>();

    for (var i = 0; i < orderProductList.products.length; i++) {
      ViewOrderProduct orderProduct = ViewOrderProduct(
        orderProduct: orderProductList.products[i],
      );

      list.add(orderProduct);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (loading)
        ? LoadingScreen()
        : Scaffold(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "buyer".tr() +
                                                  " : " +
                                                  widget.user.firstName +
                                                  " " +
                                                  widget.user.lastName,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                              right: 8.0,
                                            ),
                                            child: Text(
                                              "date".tr() +
                                                  " : " +
                                                  widget.order.creationDate,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "first name".tr() +
                                                  " : " +
                                                  widget.user.firstName,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                              right: 8.0,
                                            ),
                                            child: Text(
                                              "last name".tr() +
                                                  " : " +
                                                  widget.user.lastName,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "email".tr() +
                                                  " : " +
                                                  widget.user.emailAddress,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "country".tr() +
                                                  " : " +
                                                  widget.user.countryName,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "phone no".tr() +
                                                  " : " +
                                                  widget.user.phone,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "address".tr() +
                                                  " : " +
                                                  widget.order.shippingAddress,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "subtotal".tr() +
                                                  " : " +
                                                  widget.order.cost
                                                      .round()
                                                      .toString() +
                                                  " SYP",
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
                                                  (widget.order.couponCost * -1)
                                                      .round()
                                                      .toString() +
                                                  " SYP",
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
                                                  widget.order.totalCost
                                                      .round()
                                                      .toString() +
                                                  " SYP",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                              right: 8.0,
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
                            children: generateOrderProductsList(),
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
          );
  }
}
