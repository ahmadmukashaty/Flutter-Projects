import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/ProductGroup.dart';
import 'package:oneaddress/Components/ListProducts/ProductGroupComponent.dart';

class ProductGroupList extends StatelessWidget {
  final List<ProductGroup> productsList;

  ProductGroupList({@required this.productsList});

  List<Widget> generateListOfGroupProducts() {
    if (this.productsList.length == 0) return null;

    List<Widget> products = List<Widget>();
    for (int i = 0; i < productsList.length; i++) {
      Widget productGroup = ProductGroupComponent(
        productGroup: productsList[i],
      );

      products.add(productGroup);
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: generateListOfGroupProducts(),
    );
  }
}
