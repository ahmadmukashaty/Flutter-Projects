import 'package:oneaddress/Classes/Cart/CartProduct.dart';

class CartProductList {
  List<CartProduct> cart;
  CartProductList({
    this.cart,
  });

  Map toJson() => {
        'cart': cart,
      };

  List<CartProduct> getCartProducts() {
    return this.cart;
  }

  int getTotalPrice() {
    int total = 0;
    for (int i = 0; i < this.cart.length; i++)
      if (this.cart[i].discountActive == 1) {
        total += (this.cart[i].discountPrice.toInt());
      } else {
        total += (this.cart[i].price.toInt());
      }
    return total;
  }

  String getCartCurrency() {
    if (this.cart.length > 0) return this.cart[0].currency;
    return '';
  }
}
