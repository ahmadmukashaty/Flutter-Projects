import 'package:json_utilities/json_utilities.dart';

class AddToCartModelView {
  int userId;
  int productId;
  String productSize;

  AddToCartModelView({
    this.userId,
    this.productId,
    this.productSize,
  });

  AddToCartModelView.fromJson(Map<String, dynamic> json)
      : userId = JSONUtils().get(json, 'userId', 0),
        productId = JSONUtils().get(json, 'productId', 0),
        productSize = JSONUtils().get(json, 'productSize', '');

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'productSize': productSize,
    };
  }
}
