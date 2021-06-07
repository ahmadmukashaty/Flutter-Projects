import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageFullScreen extends StatefulWidget {
  final File imageFile;
  ImageFullScreen({
    this.imageFile,
  });

  @override
  _ImageFullScreenState createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
            child: PhotoView(
          imageProvider: FileImage(
            widget.imageFile,
          ),
        )),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
