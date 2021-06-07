import 'dart:io';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final File imageFile;

  ImageSlider({
    this.imageFile,
  });

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    double imageHeight = (MediaQuery.of(context).size.height / 5) * 4;
    double imageWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(0.0),
        width: imageWidth,
        height: imageHeight,
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: FileImage(widget.imageFile),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}
