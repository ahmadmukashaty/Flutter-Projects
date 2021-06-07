import 'dart:core';
import 'dart:io';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class SubCategory {
  // field
  int id;
  String imageName;
  int parentId;
  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  File file;

  SubCategory({
    this.id,
    this.imageName,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.parentId,
  });

  SubCategory.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        imageName = JSONUtils().get(json, 'imageName', ''),
        parentId = JSONUtils().get(json, 'parentId', null),
        nameEn = JSONUtils().get(json, 'nameEn', ''),
        nameAr = JSONUtils().get(json, 'nameAr', ''),
        descriptionEn = JSONUtils().get(json, 'descriptionEn', ''),
        descriptionAr = JSONUtils().get(json, 'descriptionAr', '');

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

  String getName() {
    return (LanguageManagement.isEnglish()) ? this.nameEn : this.nameAr;
  }

  String getDescription() {
    return (LanguageManagement.isEnglish())
        ? this.descriptionEn
        : this.descriptionAr;
  }
}
