import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageManagement {
  static File _bkImage;

  static getImageFileFromAssets() async {
    String path = 'blackBackground.jpg';
    final byteData = await rootBundle.load('images/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    _bkImage = file;
  }

  static File imageData() {
    return _bkImage;
  }
}
