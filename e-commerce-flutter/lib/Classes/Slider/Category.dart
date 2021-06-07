import 'dart:core';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

import 'SubCategory.dart';

class Category {
  // field
  int id;
  String imageName;
  int parentId;
  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  File file;
  List<SubCategory> children;

  Category({
    this.id,
    this.imageName,
    this.parentId,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.children,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        imageName = JSONUtils().get(json, 'imageName', ''),
        parentId = JSONUtils().get(json, 'parentId', null),
        nameEn = JSONUtils().get(json, 'nameEn', ''),
        nameAr = JSONUtils().get(json, 'nameAr', ''),
        descriptionEn = JSONUtils().get(json, 'descriptionEn', ''),
        descriptionAr = JSONUtils().get(json, 'descriptionAr', ''),
        children = parsingSubCategory(json['children']);

  // method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageName': imageName,
      'parentId': parentId,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
    };
  }

  static List<SubCategory> parsingSubCategory(data) {
    final List parsedList = data;
    List<SubCategory> list =
        parsedList.map((val) => SubCategory.fromJson(val)).toList();
    return list;
  }

  String getName() {
    return (LanguageManagement.isEnglish()) ? this.nameEn : this.nameAr;
  }

  String getDescription() {
    return (LanguageManagement.isEnglish())
        ? this.descriptionEn
        : this.descriptionAr;
  }
}
