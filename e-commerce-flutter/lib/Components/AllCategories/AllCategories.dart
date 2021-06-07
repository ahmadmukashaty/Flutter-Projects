import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/Category.dart';
import 'package:oneaddress/Components/AllCategories/CategoryItem.dart';

class AllCategories extends StatelessWidget {
  final ScrollController controller;
  final List<Category> categories;
  AllCategories({
    @required this.controller,
    @required this.categories,
  });

  List<Widget> generateAllCategories() {
    if (categories.length == 0) return null;

    List<Widget> list = List<Widget>();

    for (var i = 0; i < categories.length; i++) {
      CategoryItem categoryItem = CategoryItem(
        category: this.categories[i],
      );

      list.add(categoryItem);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: generateAllCategories(),
      ),
    );
  }
}
