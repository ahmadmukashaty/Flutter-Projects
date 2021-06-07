import 'dart:io';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

import 'ProductGroup.dart';
import 'Specification.dart';

class Product {
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
  List<Product> relatedProducts;
  ProductGroup parentProduct;
  File file;
  List<File> imageFiles;

  Product({
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
    this.parentProduct,
    this.relatedProducts,
  });

  Product.fromJson(Map<String, dynamic> json)
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

  List<Specification> specificationFormattingEn() {
    List<Specification> list = List<Specification>();
    if (this.specificationsEn != null && this.specificationsEn.length > 0) {
      for (int i = 0; i < this.specificationsEn.length; i++) {
        Specification spec = Specification();
        int index =
            list.indexWhere((item) => item.key == specificationsEn[i].key);
        if (index != -1) {
          list[index].value =
              list[index].value + " , " + specificationsEn[i].value;
        } else {
          spec.key = specificationsEn[i].key;
          spec.value = specificationsEn[i].value;
          list.add(spec);
        }
      }

      ProductGroup productGroup = this.parentProduct;
      if (productGroup != null) {
        Product product = productGroup.getAsProduct();
        Specification spec = Specification();
        spec.key = "Colors";
        spec.value = product.colorEn;
        if (productGroup.products != null) {
          for (int i = 0; i < productGroup.products.length; i++) {
            spec.value = spec.value + ", " + productGroup.products[i].colorEn;
          }
        }
        list.add(spec);
      }
    }
    return list;
  }

  List<Specification> specificationFormattingAr() {
    List<Specification> list = List<Specification>();
    if (this.specificationsAr != null && this.specificationsAr.length > 0) {
      for (int i = 0; i < this.specificationsAr.length; i++) {
        Specification spec = Specification();
        int index =
            list.indexWhere((item) => item.key == specificationsAr[i].key);
        if (index != -1) {
          list[index].value =
              list[index].value + " , " + specificationsAr[i].value;
        } else {
          spec.key = specificationsAr[i].key;
          spec.value = specificationsAr[i].value;
          list.add(spec);
        }
      }

      ProductGroup productGroup = this.parentProduct;
      if (productGroup != null) {
        Product product = productGroup.getAsProduct();
        Specification spec = Specification();
        spec.key = "الالوان";
        spec.value = product.colorAr;
        if (productGroup.products != null) {
          for (int i = 0; i < productGroup.products.length; i++) {
            spec.value = spec.value + ", " + productGroup.products[i].colorAr;
          }
        }
        list.add(spec);
      }
    }
    return list;
  }

  static List<Product> parsingProducts(data) {
    if (data == null) return null;
    final List parsedList = data;
    List<Product> list =
        parsedList.map((val) => Product.fromJson(val)).toList();
    return list;
  }

  List<String> getProductSizes() {
    List<String> sizes = List<String>();
    if (this.specificationsEn != null && this.specificationsEn.length > 0) {
      for (int i = 0; i < this.specificationsEn.length; i++) {
        Specification spec = this.specificationsEn[i];
        if (spec.key.toLowerCase() == "size") {
          sizes.add(spec.value);
        }
      }
    }
    return sizes;
  }

  String getName() {
    return (LanguageManagement.isEnglish()) ? this.nameEn : this.nameAr;
  }
}
