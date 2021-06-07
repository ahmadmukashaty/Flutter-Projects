import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Components/Product/ImageSlider.dart';
import 'package:oneaddress/Screens/ImageFullScreen.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';

class ProductSlider extends StatefulWidget {
  final Product product;
  final PageController controller;
  ProductSlider({
    @required this.product,
    @required this.controller,
  });

  @override
  _ProductSliderState createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  List<Widget> _productSliders;
  int _length = 0;
  double _currentPosition = 0.0;

  final decorator = DotsDecorator(
    size: Size.square(5.0),
    color: Colors.transparent,
    activeColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.black),
    ),
    activeSize: Size.square(10.0),
    activeShape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.black),
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

  List<Widget> generateProductSlides() {
    List<Widget> list = new List<Widget>();

    GestureDetector imageSlider = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          ProductRouteAnimation(
            widget: ImageFullScreen(
              imageFile: widget.product.file,
            ),
          ),
        );
      },
      child: ImageSlider(
        imageFile: widget.product.file,
      ),
    );
    list.add(imageSlider);
    if (widget.product.imageFiles == null) {
      for (var i = 0; i < widget.product.imageFiles.length; i++) {
        GestureDetector imageSlider = GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              ProductRouteAnimation(
                widget: ImageFullScreen(
                  imageFile: widget.product.imageFiles[i],
                ),
              ),
            );
          },
          child: ImageSlider(
            imageFile: widget.product.imageFiles[i],
          ),
        );
        list.add(imageSlider);
      }
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
    _productSliders = generateProductSlides();
    _length = (_productSliders != null) ? _productSliders.length : 0;
    _currentPosition = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.centerRight,
      children: <Widget>[
        PageView.builder(
          controller: widget.controller,
          scrollDirection: Axis.vertical,
          onPageChanged: _onPageChanged,
          itemCount: _length,
          itemBuilder: (context, index) {
            return _productSliders[index];
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
