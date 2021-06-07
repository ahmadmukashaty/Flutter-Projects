import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/SubCategory.dart';

import 'SubCategoryPageView.dart';

class CategoryPageView extends StatefulWidget {
  final List<SubCategory> subcategories;

  CategoryPageView({this.subcategories});

  @override
  _CategoryPageViewState createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {
  PageController controller;
  List<Widget> _subCategorySliders;
  int _length = 0;
  double _currentPosition = 0.0;
  final decorator = DotsDecorator(
    size: Size.square(5.0),
    color: Colors.transparent,
    activeColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.white),
    ),
    activeSize: Size.square(10.0),
    activeShape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.white),
    ),
  );
  final transDecorator = DotsDecorator(
    size: Size.square(5.0),
    color: Colors.transparent,
    activeColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.transparent),
    ),
    activeSize: Size.square(10.0),
    activeShape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.transparent),
    ),
  );

  List<Widget> generateSubCategoriesSlides() {
    if (widget.subcategories.length == 0) return null;

    List<Widget> list = new List<Widget>();
    for (var i = 0; i < widget.subcategories.length; i++) {
      SubCategoryPageView slideScreen = SubCategoryPageView(
        subCategory: widget.subcategories[i],
      );
      list.add(slideScreen);
    }
    return list;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  double _validPosition(double position) {
    if (position >= _length) return 0;
    if (position < 0) return _length - 1.0;
    return position;
  }

  _onPageChanged(int page) {
    _updatePosition(page.toDouble());
  }

  @override
  void initState() {
    controller = PageController();
    _subCategorySliders = generateSubCategoriesSlides();
    _length = (_subCategorySliders != null) ? _subCategorySliders.length : 0;
    _currentPosition = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.centerRight,
      children: <Widget>[
        PageView.builder(
          controller: controller,
          scrollDirection: Axis.vertical,
          reverse: false,
          onPageChanged: _onPageChanged,
          itemCount: _length,
          itemBuilder: (context, index) {
            return _subCategorySliders[index];
          },
        ),
        DotsIndicator(
          dotsCount: _length,
          position: _currentPosition,
          axis: Axis.vertical,
          decorator: (_length > 1) ? decorator : transDecorator,
        ),
      ],
    );
  }
}
