import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Screens/ProductScreen.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';

class ProductRelated extends StatefulWidget {
  final Product product;

  ProductRelated({this.product});

  @override
  _ProductColorState createState() => _ProductColorState();
}

class _ProductColorState extends State<ProductRelated> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          ProductRouteAnimation(
            widget: ProductScreen(
              product: widget.product,
            ),
          ),
        );
      },
      child: Container(
        width: 250.0,
        child: Card(
          child: Wrap(
            children: <Widget>[
              Image.file(widget.product.file),
            ],
          ),
        ),
      ),
    );
  }
}
