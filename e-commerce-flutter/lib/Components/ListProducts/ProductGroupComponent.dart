import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Classes/ProductList/ProductGroup.dart';
import 'package:oneaddress/Components/ListProducts/TwoProductsInRowComponent.dart';

import 'MainProductComponent.dart';
import 'OneProductInRowComponent.dart';

class ProductGroupComponent extends StatelessWidget {
  final ProductGroup productGroup;

  ProductGroupComponent({@required this.productGroup});

  List<Widget> generateGroupProducts() {
    if (this.productGroup == null) return null;

    List<Widget> groupProducts = List<Widget>();

    Product mainProduct = this.productGroup.getAsProduct();

    Widget mainProductWidget = MainProductComponent(
      product: mainProduct,
    );

    groupProducts.add(mainProductWidget);

    if (this.productGroup.products.length == 0) return groupProducts;

    if (this.productGroup.products.length == 1) {
      Widget oneProductWidget = OneProductInRowComponent(
        product: this.productGroup.products[0],
      );
      groupProducts.add(oneProductWidget);
      return groupProducts;
    }

    for (int i = 0; i < this.productGroup.products.length; i = i + 2) {
      if (this.productGroup.products.length - i > 1) {
        Widget twoProductsWidget = TwoProductsInRowComponent(
          product1: this.productGroup.products[i],
          product2: this.productGroup.products[i + 1],
        );
        groupProducts.add(twoProductsWidget);
      }
    }

    if (this.productGroup.products.length.isOdd) {
      Widget oneProductWidget = OneProductInRowComponent(
        product: this.productGroup.products.last,
      );
      groupProducts.add(oneProductWidget);
    }

    return groupProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: generateGroupProducts(),
      ),
    );
  }
}
