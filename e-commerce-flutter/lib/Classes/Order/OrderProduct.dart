import 'dart:io';
import 'package:intl/intl.dart';
import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class OrderProduct {
  int id;
  String creationDate;
  int orderId;
  int productId;
  double cost;
  String size;
  String status;
  String imageName;
  File imageFile;
  String nameAr;
  String nameEn;
  String description;
  String modelCode;
  String colorAr;
  String colorEn;

  OrderProduct.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        creationDate = parseDate(JSONUtils().get(json, 'creationDate', '')),
        orderId = JSONUtils().get(json, 'orderId', 0),
        productId = JSONUtils().get(json, 'productId', 0),
        cost = (JSONUtils().get(json, 'cost', 0.0)).toDouble(),
        size = JSONUtils().get(json, 'size', ''),
        status = JSONUtils().get(json, 'status', ''),
        imageName = JSONUtils().get(json, 'imageName', ''),
        nameAr = JSONUtils().get(json, 'nameAr', ''),
        nameEn = JSONUtils().get(json, 'nameEn', ''),
        description = JSONUtils().get(json, 'description', ''),
        modelCode = JSONUtils().get(json, 'modelCode', ''),
        colorAr = JSONUtils().get(json, 'colorAr', ''),
        colorEn = JSONUtils().get(json, 'colorEn', '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creationDate': creationDate,
      'orderId': orderId,
      'productId': productId,
      'cost': cost,
      'size': size,
      'status': status,
      'imageName': imageName,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'description': description,
      'modelCode': modelCode,
      'colorAr': colorAr,
      'colorEn': colorEn,
    };
  }

  static String parseDate(String date) {
    if (date == '') return date;
    DateTime myDatetime = DateTime.parse(date);
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(myDatetime);
    return formatted;
  }

  String getName() {
    return (LanguageManagement.isEnglish()) ? this.nameEn : this.nameAr;
  }

  String getColor() {
    return (LanguageManagement.isEnglish()) ? this.colorEn : this.colorAr;
  }
}
