import 'package:json_utilities/json_utilities.dart';

class CartProductModelView {
  int productId;
  String productSize;
  CartProductModelView({
    this.productId,
    this.productSize,
  });

  CartProductModelView.fromJson(Map<String, dynamic> json)
      : productId = JSONUtils().get(json, 'productId', 0),
        productSize = JSONUtils().get(json, 'productSize', '');

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productSize': productSize,
    };
  }
}
