import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/ProductList/ProductGroup.dart';
import 'package:oneaddress/Services/Network_Cache_Management/Networking.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class ProductListService {
  Future<List<ProductGroup>> getProductList(
    String subCategoryId,
    String countryId,
  ) async {
    NetworkHelper networkHelper = NetworkHelper(
        kProductsUrl + "/" + subCategoryId + "?countryId=" + countryId);
    var productsData =
        await networkHelper.getDataWithKey(kProductsKey + subCategoryId);
    final List parsedList = JSONUtils().get(productsData, 'result', null);
    if (parsedList == null) return [];
    List<ProductGroup> products =
        parsedList.map((val) => ProductGroup.fromJson(val)).toList();

    return products;
  }
}
