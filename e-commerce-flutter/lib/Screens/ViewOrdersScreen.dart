import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Order/UserOrderList.dart';
import 'package:oneaddress/Components/Order/UserOrderCard.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Services/WebServices/OrderService.dart';
import 'package:oneaddress/Utilities/CustomAppBar.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:easy_localization/easy_localization.dart';

import 'SignInScreen.dart';

class ViewOrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _ViewOrdersScreenState createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  ScrollController controller;
  UserOrderList userOrderList;
  User userInfo;
  bool loading = true;
  bool authorized = false;
  bool emptyOrder = false;

  void initState() {
    controller = ScrollController();
    getUserOrders();
    super.initState();
  }

  List<Widget> generateUserOrderList() {
    if (userOrderList.orders.length == 0) return null;

    List<Widget> list = List<Widget>();

    for (var i = 0; i < userOrderList.orders.length; i++) {
      UserOrderCard orderCard = UserOrderCard(
        order: userOrderList.orders[i],
        user: userInfo,
      );

      list.add(orderCard);
    }
    return list;
  }

  getUserOrders() async {
    SharedPref sharedPref = SharedPref();
    userInfo = await sharedPref.getUserInfo();
    if (userInfo != null) {
      this.authorized = true;
      var orderData = await OrderService().getUserOrders(userInfo.id);
      userOrderList = UserOrderList(orders: orderData);
      setState(() {
        emptyOrder = (userOrderList.orders.length == 0) ? true : false;
        this.authorized = true;
        loading = false;
      });
    } else {
      this.authorized = false;
      Navigator.push(
        context,
        ProductRouteAnimation(
          widget: SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                "order history",
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
                      child: (emptyOrder)
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.only(bottom: 50.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Text(
                                        "no order is placed",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                        ),
                                      ).tr(),
                                    ),
                                    Icon(
                                      Icons.warning,
                                      color: Colors.grey,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              child: Column(
                                children: generateUserOrderList(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
