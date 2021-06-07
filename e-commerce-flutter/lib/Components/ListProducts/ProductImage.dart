import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Screens/ListProductsScreen.dart';
import 'package:oneaddress/Screens/ProductScreen.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';

class ProductImage extends StatefulWidget {
  final Product product;
  final double width;
  final double height;

  ProductImage({
    this.product,
    this.width,
    this.height,
  });

  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*       ListProductsScreen.lastScrollPosition =
            ListProductsScreen.currentScrollPosition;
        ListProductsScreen.fromPush = true;*/
        Navigator.pushNamed(
          context,
          ProductScreen.routeName,
          arguments: widget.product,
        );
      },
      child: Center(
        child: Image.file(widget.product.file),
      ),
    );
  }
}
