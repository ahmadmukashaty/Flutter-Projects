import 'dart:io';

import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Classes/ProductList/ProductGroup.dart';
import 'package:oneaddress/Services/Management/ImageManagement.dart';
import 'package:oneaddress/Utilities/Constants.dart';

import 'CustomCacheManager.dart';

class ImageCacheManagement {
  static Map<int, List<String>> categoryMap = Map<int, List<String>>();
  static Map<int, List<String>> productMap = Map<int, List<String>>();
  static int lastCategoryId;
  static int lastProductId;

  static Future<List> saveCategoryImagesInCache(
      {List<ProductGroup> products,
      int categoryId,
      bool isPrimary = true,
      startIndex = 0,
      perPage = 10}) async {
    if (categoryId != lastCategoryId) {
      await clearCategoryData(lastCategoryId);
      lastCategoryId = categoryId;
    }

    if (!categoryMap.containsKey(categoryId)) {
      categoryMap[categoryId] = List<String>();
    }

    int counter = startIndex;
    int endCounter = startIndex + perPage;
    int endIndex = startIndex;
    bool endOfImages = true;
    //await manageCache();
    for (var i = counter; i < products.length; i++) {
      endIndex = i;
      if (counter >= endCounter) {
        endOfImages = false;
        endIndex = endIndex - 1;
        break;
      }
      File productGroupFile;
      try {
        productGroupFile = await CustomCacheManager()
            .getSingleFile(kImgProductBaseUrl + products[i].imageName);

        if (!categoryMap[categoryId].contains(products[i].imageName)) {
          categoryMap[categoryId].add(products[i].imageName);
        }
        counter++;
      } on Exception catch (_) {
        productGroupFile = ImageManagement.imageData();
      }
      products[i].file = productGroupFile;
      ProductGroup productGroup = products[i];

      if (productGroup.products != null && productGroup.products.length > 0) {
        for (var j = 0; j < productGroup.products.length; j++) {
          File productFile;
          try {
            productFile = await CustomCacheManager().getSingleFile(
                kImgProductBaseUrl + productGroup.products[j].imageName);
            if (!categoryMap[categoryId]
                .contains(productGroup.products[j].imageName)) {
              categoryMap[categoryId].add(productGroup.products[j].imageName);
            }
            counter++;
          } on Exception catch (_) {
            productFile = ImageManagement.imageData();
          }
          productGroup.products[j].parentProduct = productGroup;
          productGroup.products[j].file = productFile;
        }
      }
    }

    return [endOfImages, startIndex, endIndex];
  }

  static Future<void> saveSingleProductImagesInCache({Product product}) async {
    List<File> files = List<File>();
    if (!productMap.containsKey(product.id)) {
      productMap[product.id] = List<String>();
    }
    File productImageFile;
    try {
      productImageFile = await CustomCacheManager()
          .getSingleFile(kImgProductBaseUrl + product.imageName);
      if (!productMap[product.id].contains(product.imageName)) {
        productMap[product.id].add(product.imageName);
      }
    } on Exception catch (_) {
      productImageFile = ImageManagement.imageData();
    }
    product.file = productImageFile;

    for (var i = 0; i < product.images.length; i++) {
      File productImageFile;
      try {
        productImageFile = await CustomCacheManager()
            .getSingleFile(kImgProductBaseUrl + product.images[i]);
        if (!productMap[product.id].contains(product.images[i])) {
          productMap[product.id].add(product.images[i]);
        }
      } on Exception catch (_) {
        productImageFile = ImageManagement.imageData();
      }
      files.add(productImageFile);
    }
    product.imageFiles = files;

    List<Product> related = product.relatedProducts;
    if (related != null && related.length > 0) {
      for (int i = 0; i < related.length; i++) {
        File productImage;
        try {
          productImage = await CustomCacheManager()
              .getSingleFile(kImgProductBaseUrl + related[i].imageName);
          if (!productMap[product.id].contains(related[i].imageName)) {
            productMap[product.id].add(related[i].imageName);
          }
        } on Exception catch (_) {
          productImage = ImageManagement.imageData();
        }
        related[i].file = productImage;
      }
    }
  }

  static clearCategoryData(int categoryId) async {
    if (categoryMap.containsKey(categoryId)) {
      for (int i = 0; i < categoryMap[categoryId].length; i++) {
        await CustomCacheManager()
            .removeFile(kImgProductBaseUrl + categoryMap[categoryId][i]);
      }
      categoryMap.remove(categoryId);
    }
  }

  static clearProductData(int productId) async {
    if (productMap.containsKey(productId)) {
      for (int i = 0; i < productMap[productId].length; i++) {
        if (i > 0) {
          await CustomCacheManager()
              .removeFile(kImgProductBaseUrl + productMap[productId][i]);
        }
      }
      productMap.remove(productId);
    }
  }
}
