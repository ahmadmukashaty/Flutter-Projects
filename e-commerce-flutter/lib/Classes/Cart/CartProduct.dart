import 'dart:io';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class CartProduct {
  int id;
  String size;
  String nameEn;
  String nameAr;
  int productId;
  String imageName;
  double price;
  String colorAr;
  String colorEn;
  String currency;
  int discountActive;
  double discountPrice;
  File file;

  CartProduct({
    this.id,
    this.size,
    this.nameEn,
    this.nameAr,
    this.productId,
    this.imageName,
    this.colorAr,
    this.colorEn,
    this.currency,
    this.price,
    this.discountActive,
    this.discountPrice,
  });

  CartProduct.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        size = JSONUtils().get(json, 'size', ''),
        nameEn = JSONUtils().get(json, 'nameEn', ''),
        nameAr = JSONUtils().get(json, 'nameAr', ''),
        productId = JSONUtils().get(json, 'productId', 0),
        imageName = JSONUtils().get(json, 'imageName', ''),
        colorAr = JSONUtils().get(json, 'colorAr', ''),
        colorEn = JSONUtils().get(json, 'colorEn', ''),
        currency = JSONUtils().get(json, 'currency', ''),
        price = (JSONUtils().get(json, 'price', 0.0)).toDouble(),
        discountActive = JSONUtils().get(json, 'discountActive', 0),
        discountPrice = ((JSONUtils().get(json, 'discountPrice', 0.0) == null)
                ? 0.0
                : JSONUtils().get(json, 'discountPrice', 0.0))
            .toDouble();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'productId': productId,
      'imageName': imageName,
      'colorAr': colorAr,
      'colorEn': colorEn,
      'currency': currency,
      'price': price,
      'discountActive': discountActive,
      'discountPrice': discountPrice,
    };
  }

  String getName() {
    return (LanguageManagement.isEnglish()) ? this.nameEn : this.nameAr;
  }

  String getColor() {
    return (LanguageManagement.isEnglish()) ? this.colorEn : this.colorAr;
  }
}
