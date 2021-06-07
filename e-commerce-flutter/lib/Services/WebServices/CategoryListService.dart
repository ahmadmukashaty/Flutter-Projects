import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Slider/Category.dart';
import 'package:oneaddress/Services/Management/ImageManagement.dart';
import 'package:oneaddress/Utilities/Constants.dart';
import '../Network_Cache_Management/CustomCacheManager.dart';
import '../Network_Cache_Management/Networking.dart';

class CategoryListService {
  static List<Category> _categories;

  static Future<void> getCategoryInfo(int countryId) async {
    String url = kCategoryUrl + "?countryId=" + countryId.toString();
    NetworkHelper networkHelper = NetworkHelper(url);

    var categoryData = await networkHelper.getDataWithKey(kCategoryKey);
    final List parsedList = JSONUtils().get(categoryData, 'result', null);
    if (parsedList == null) return [];
    _categories = parsedList.map((val) => Category.fromJson(val)).toList();

    for (var i = 0; i < _categories.length; i++) {
      if (_categories[i].file == null) {
        File catFile;
        try {
          FileInfo fileInfo = await CustomCacheManager()
              .getFileFromCache(kImgCategoryBaseUrl + _categories[i].imageName);
          if (fileInfo == null) {
            fileInfo = await CustomCacheManager().downloadFile(
              kImgCategoryBaseUrl + _categories[i].imageName,
            );
          }
          catFile = fileInfo.file;
        } on Exception catch (_) {
          catFile = ImageManagement.imageData();
        }
        _categories[i].file = catFile;
      }
      Category category = _categories[i];
      if (category.children != null && category.children.length > 0) {
        for (var j = 0; j < category.children.length; j++) {
          if (category.children[j].file == null) {
            File subCatFile;
            try {
              FileInfo fileInfo = await CustomCacheManager().getFileFromCache(
                  kImgCategoryBaseUrl + category.children[j].imageName);
              if (fileInfo == null) {
                fileInfo = await CustomCacheManager().downloadFile(
                  kImgCategoryBaseUrl + category.children[j].imageName,
                );
              }
              subCatFile = fileInfo.file;
            } on Exception catch (_) {
              subCatFile = ImageManagement.imageData();
            }

            category.children[j].file = subCatFile;
          }
        }
      }
    }
    return _categories;
  }

  static List<Category> getCategories() {
    return _categories;
  }
}
