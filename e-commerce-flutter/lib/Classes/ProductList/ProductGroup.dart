import 'dart:io';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/ProductList/Specification.dart';

import 'Product.dart';

class ProductGroup {
  int id;
  String nameEn;
  String nameAr;
  String modelCode;
  String imageName;
  String description;
  String colorEn;
  String colorAr;
  String colorTag;
  double price;
  String currency;
  int discountActive;
  double discountPrice;
  List<String> images;
  List<Specification> specificationsEn;
  List<Specification> specificationsAr;
  List<Product> products;
  List<Product> relatedProducts;
  File file;

  ProductGroup({
    this.id,
    this.nameEn,
    this.nameAr,
    this.modelCode,
    this.imageName,
    this.description,
    this.colorEn,
    this.colorAr,
    this.colorTag,
    this.price,
    this.currency,
    this.discountActive,
    this.discountPrice,
    this.images,
    this.specificationsEn,
    this.specificationsAr,
    this.products,
    this.relatedProducts,
  });

  ProductGroup.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        nameEn = JSONUtils().get(json, 'nameEn', ''),
        nameAr = JSONUtils().get(json, 'nameAr', ''),
        modelCode = JSONUtils().get(json, 'modelCode', ''),
        imageName = JSONUtils().get(json, 'imageName', ''),
        description = JSONUtils().get(json, 'description', ''),
        colorEn = JSONUtils().get(json, 'colorEn', ''),
        colorAr = JSONUtils().get(json, 'colorAr', ''),
        colorTag = JSONUtils().get(json, 'colorTag', ''),
        price = (JSONUtils().get(json, 'price', 0.0)).toDouble(),
        currency = JSONUtils().get(json, 'currency', ''),
        discountActive = JSONUtils().get(json, 'discountActive', 0),
        discountPrice = ((JSONUtils().get(json, 'discountPrice', 0.0) == null)
                ? 0.0
                : JSONUtils().get(json, 'discountPrice', 0.0))
            .toDouble(),
        images = parsingImages(JSONUtils().get(json, 'images', null)),
        specificationsEn = parsingSpecification(
            JSONUtils().get(json, 'specificationsEn', null)),
        specificationsAr = parsingSpecification(
            JSONUtils().get(json, 'specificationsAr', null)),
        products = parsingProducts(JSONUtils().get(json, 'products', [])),
        relatedProducts =
            parsingProducts(JSONUtils().get(json, 'relatedProducts', []));

  // method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'modelCode': modelCode,
      'imageName': imageName,
      'description': description,
      'colorEn': colorEn,
      'colorAr': colorAr,
      'colorTag': colorTag,
      'price': price,
      'currency': currency,
      'discountActive': discountActive,
      'discountPrice': discountPrice,
      'images': images,
      'specificationsEn': specificationsEn,
      'specificationsAr': specificationsAr,
      'products': products,
      'relatedProducts': relatedProducts,
    };
  }

  static List<Specification> parsingSpecification(data) {
    if (data == null) return null;
    final List parsedList = data;
    List<Specification> list =
        parsedList.map((val) => Specification.fromJson(val)).toList();
    return list;
  }

  static List<String> parsingImages(data) {
    if (data == null) return null;
    final List parsedList = data;
    List<String> list = parsedList.map((val) => val.toString()).toList();
    return list;
  }

  static List<Product> parsingProducts(data) {
    if (data == null) return null;
    final List parsedList = data;
    List<Product> list =
        parsedList.map((val) => Product.fromJson(val)).toList();
    return list;
  }

  Product getAsProduct() {
    Product product = Product(
      id: id,
      nameEn: nameEn,
      nameAr: nameAr,
      modelCode: modelCode,
      imageName: imageName,
      description: description,
      colorEn: colorEn,
      colorAr: colorAr,
      colorTag: colorTag,
      price: price,
      currency: currency,
      discountActive: discountActive,
      discountPrice: discountPrice,
      images: images,
      specificationsEn: specificationsEn,
      specificationsAr: specificationsAr,
      relatedProducts: relatedProducts,
    );
    product.file = file;
    product.parentProduct = this;
    return product;
  }
}
