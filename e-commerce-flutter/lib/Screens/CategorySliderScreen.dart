import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/CategoryTree.dart';
import 'package:oneaddress/Components/Slider/CategorySlider.dart';

class CategorySliderScreen extends StatefulWidget {
  final CategoryTree categoryTree;
  CategorySliderScreen({this.categoryTree});

  @override
  _CategorySliderScreenState createState() => _CategorySliderScreenState();
}

class _CategorySliderScreenState extends State<CategorySliderScreen> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 0,
    );
  }

  getCategoryTree() {
    return widget.categoryTree.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return CategorySlider(
      categories: getCategoryTree(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
