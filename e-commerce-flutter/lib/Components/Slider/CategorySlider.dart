import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/Category.dart';
import 'package:oneaddress/Utilities/CustomPageViewIndecator.dart';

import 'CategoryPageView.dart';

class CategorySlider extends StatefulWidget {
  final List<Category> categories;

  CategorySlider({
    @required this.categories,
  });

  @override
  _CategorySliderState createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  PageController controller;
  List<Widget> _categorySliders;
  int _length = 0;
  final pageIndexNotifier = ValueNotifier<int>(0);

  List<Widget> generateCategorySlides() {
    if (widget.categories.length == 0) return null;

    List<Widget> list = List<Widget>();

    for (var i = 0; i < widget.categories.length; i++) {
      CategoryPageView categorySlide =
          CategoryPageView(subcategories: widget.categories[i].children);

      list.add(categorySlide);
    }

    return list;
  }

  Widget _categoryIndicator() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomPageViewIndecator(
            pageIndexNotifier: pageIndexNotifier,
            length: _length,
            normalBuilder: (animationController, index) => GestureDetector(
              onTap: () {
                setState(() {
                  controller.jumpToPage(index);
                });
              },
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.categories[index].getName().toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            highlightedBuilder: (animationController, index) => ScaleTransition(
              alignment: Alignment.bottomLeft,
              scale: CurvedAnimation(
                parent: animationController,
                curve: Curves.decelerate,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 35.0),
                width: 80.0,
                height: 20.0,
                child: Divider(
                  thickness: 3.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    controller = PageController(initialPage: 0, keepPage: false);
    _categorySliders = generateCategorySlides();
    _length = (_categorySliders != null) ? _categorySliders.length : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.topCenter,
      children: <Widget>[
        PageView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) => pageIndexNotifier.value = index,
          itemCount: _length,
          itemBuilder: (context, index) {
            return _categorySliders[index];
          },
        ),
        _categoryIndicator(),
      ],
    );
  }
}
