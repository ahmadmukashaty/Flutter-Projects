import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:oneaddress/Classes/Cart/CartProductList.dart';
import 'package:oneaddress/Components/Cart/CartPageComponent.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Screens/OrderPersonalDetailsScreen.dart';
import 'package:oneaddress/Screens/SignInScreen.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Services/WebServices/CartListService.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:easy_localization/easy_localization.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ScrollController _scrollController;
  CartProductList cartProducts;
  bool loading = true;
  int totalPrice;
  String cartCurrency;
  bool cartEmpty = false;
  bool authorized = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    cartEmpty = false;
    super.initState();
    getCartProductData();
  }

  void getCartProductData() async {
    var cartData = await CartListService().getCartInfo();
    cartProducts = CartProductList(cart: cartData);
    totalPrice = cartProducts.getTotalPrice();
    cartCurrency = cartProducts.getCartCurrency();

    setState(() {
      if (cartProducts.cart.length == 0) cartEmpty = true;
      (Authentication.notAuth()) ? authorized = false : authorized = true;
      loading = false;
    });
  }

  deleteCartProduct(CartProduct product) {
    setState(() {
      cartProducts.cart.removeWhere((item) => item.id == product.id);
      totalPrice = cartProducts.getTotalPrice();
      cartCurrency = cartProducts.getCartCurrency();
      if (cartProducts.cart.length == 0) cartEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    User userInfo = Authentication.userData();
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
                            userInfo.firstName +
                            " "
                                "" +
                            userInfo.lastName +
                            ") ")
                        : ""),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
              child: CartPageComponent(
                controller: _scrollController,
                products: cartProducts,
                updateCartCallback: deleteCartProduct,
                emptyCart: cartEmpty,
              ),
            ),
            bottomNavigationBar: Container(
              color: Colors.white,
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "total".tr() +
                          " " +
                          (totalPrice.round()).toString() +
                          " " +
                          cartCurrency.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        onPressed: (cartEmpty)
                            ? null
                            : () {
                                (Authentication.isAuth())
                                    ? Navigator.push(
                                        context,
                                        ProductRouteAnimation(
                                          widget: OrderPersonalDetailsScreen(
                                            products: cartProducts,
                                            userInfo: Authentication.userData(),
                                          ),
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        ProductRouteAnimation(
                                          widget: SignInScreen(
                                            updateCart: true,
                                          ),
                                        ),
                                      );
                              },
                        disabledColor: Color.fromRGBO(0, 0, 0, 1),
                        disabledTextColor: Color.fromRGBO(255, 255, 255, 0.7),
                        child: Text(
                          "buy",
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
