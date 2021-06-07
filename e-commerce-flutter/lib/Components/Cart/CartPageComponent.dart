import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:oneaddress/Classes/Cart/CartProductList.dart';
import 'package:oneaddress/Components/Cart/CartItemComponent.dart';
import 'package:easy_localization/easy_localization.dart';

class CartPageComponent extends StatefulWidget {
  final ScrollController controller;
  final CartProductList products;
  final UpdateCartCallback updateCartCallback;
  final bool emptyCart;

  @override
  CartPageComponent({
    @required this.controller,
    @required this.products,
    @required this.updateCartCallback,
    @required this.emptyCart,
  });
  _CartPageComponentState createState() => _CartPageComponentState();
}

class _CartPageComponentState extends State<CartPageComponent> {
  @override
  void initState() {
    super.initState();
  }

  deleteCartProduct(CartProduct product) {
    setState(() {
      widget.updateCartCallback(product);
    });
  }

  getProductNum() {
    int productsNum = widget.products.getCartProducts().length;
    return productsNum.toString();
  }

  List<Widget> generateAllCartProducts() {
    List<CartProduct> cartProducts = widget.products.getCartProducts();
    if (cartProducts.length == 0) {
      return null;
    }
    List<Widget> list = List<Widget>();

    for (var i = 0; i < cartProducts.length; i++) {
      CartItemComponent productItem = CartItemComponent(
        product: cartProducts[i],
        deleteCallback: deleteCartProduct,
      );

      list.add(productItem);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 90.0,
            ),
            child: (widget.emptyCart)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "your cart is empty",
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
                : SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: constraints.copyWith(
                        minHeight: constraints.maxHeight,
                        maxHeight: double.infinity,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: generateAllCartProducts(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 30.0,
                              right: 15.0,
                            ),
                            child: Text(
                              "shopping cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              top: 0.0,
                              right: 18.0,
                              bottom: 20.0,
                            ),
                            child: Text(
                              getProductNum() + " " + "products".tr(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ), // Your footer widget
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

typedef UpdateCartCallback = void Function(CartProduct product);
