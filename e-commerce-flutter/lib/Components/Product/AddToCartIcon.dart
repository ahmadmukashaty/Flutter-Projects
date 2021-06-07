import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Screens/CartScreen.dart';
import 'package:oneaddress/Services/WebServices/CartListService.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';

class AddToCartIcon extends StatefulWidget {
  final Product product;
  final String size;
  AddToCartIcon({
    @required this.product,
    @required this.size,
  });

  @override
  _AddToCartIconState createState() => _AddToCartIconState();
}

class _AddToCartIconState extends State<AddToCartIcon> {
  final int flexNumber = 1;
  CartListService cartListService;

  @override
  void initState() {
    super.initState();
    cartListService = CartListService();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.flexNumber,
      child: IconButton(
        icon: Icon(
          Icons.add_shopping_cart,
          color: Colors.black,
        ),
        onPressed: () async {
          await cartListService.addProductToCart(widget.product, widget.size);
          final snackBar = SnackBar(
            content: Text(
              widget.product.nameEn + " is added successfully",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.black,
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.blue,
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    ProductRouteAnimation(
                      widget: CartScreen(),
                    ),
                  );
                });
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
