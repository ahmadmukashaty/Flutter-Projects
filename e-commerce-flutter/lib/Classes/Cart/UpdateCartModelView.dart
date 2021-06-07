import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:oneaddress/Classes/Cart/CartProductModelView.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';

class UpdateCartModelView {
  int userId;
  List<CartProductModelView> collection;

  UpdateCartModelView({List<CartProduct> products}) {
    collection = List<CartProductModelView>();
    for (int i = 0; i < products.length; i++) {
      CartProductModelView cartProductModelView = CartProductModelView(
        productId: products[i].productId,
        productSize: products[i].size,
      );
      collection.add(cartProductModelView);
    }
    this.userId = Authentication.userData().id;
  }

  UpdateCartModelView.fromJson(Map<String, dynamic> json)
      : userId = JSONUtils().get(json, 'userId', 0),
        collection =
            parsingCollection(JSONUtils().get(json, 'collection', null));

  static List<CartProductModelView> parsingCollection(data) {
    if (data == null) return null;
    final List parsedList = data;
    List<CartProductModelView> list =
        parsedList.map((val) => CartProductModelView.fromJson(val)).toList();
    return list;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'collection': collection,
    };
  }
}
