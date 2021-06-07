import 'dart:io';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Cart/AddToCartModelView.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:oneaddress/Classes/Cart/UpdateCartModelView.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Components/BottomNavBar/ButtonCartIconNavBarComponent.dart';
import 'package:oneaddress/Services/Network_Cache_Management/CustomCacheManager.dart';
import 'package:oneaddress/Services/Network_Cache_Management/Networking.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class CartListService {
  Future<dynamic> getCartInfo() async {
    SharedPref sharedPref = SharedPref();
    User userInfo = Authentication.userData();
    if (userInfo == null) {
      List<CartProduct> products = await sharedPref.getCartInfo();
      for (var i = 0; i < products.length; i++) {
        File productFile = await CustomCacheManager()
            .getSingleFile(kImgProductBaseUrl + products[i].imageName);
        products[i].file = productFile;
      }
      ButtonCartIconNavBarComponent.numberOfItems = products.length;
      return products;
    } else {
      int userId = userInfo.id;
      NetworkHelper networkHelper = NetworkHelper(
        kCartUrl + "/" + userId.toString(),
      );

      var cartData = await networkHelper.getDataWithKey(kCartKey,
          checkInMemory: false, saveInMemory: true);

      final List parsedList = JSONUtils().get(cartData, 'result.cart', null);
      if (parsedList == null) return [];
      List<CartProduct> products =
          parsedList.map((val) => CartProduct.fromJson(val)).toList();

      for (var i = 0; i < products.length; i++) {
        File productFile = await CustomCacheManager()
            .getSingleFile(kImgProductBaseUrl + products[i].imageName);
        products[i].file = productFile;
      }
      ButtonCartIconNavBarComponent.numberOfItems = products.length;
      return products;
    }
  }

  Future<void> updateCartProductsNum() async {
    SharedPref sharedPref = SharedPref();
    List<CartProduct> products = await sharedPref.getCartInfo();
    ButtonCartIconNavBarComponent.numberOfItems = products.length;
  }

  Future<dynamic> addProductToCart(Product product, String size) async {
    SharedPref sharedPref = SharedPref();
    User userInfo = Authentication.userData();
    List<CartProduct> products = await sharedPref.getCartInfo();

    //Authorized ?
    if (userInfo != null) {
      NetworkHelper networkHelper = NetworkHelper(
        kAddToCartUrl,
      );

      AddToCartModelView newProduct = AddToCartModelView(
        userId: userInfo.id,
        productId: product.id,
        productSize: size,
      );
      var cartData = await networkHelper.postData(newProduct.toJson());
      final List parsedList = JSONUtils().get(cartData, 'result.cart', null);
      if (parsedList != null) {
        products = parsedList.map((val) => CartProduct.fromJson(val)).toList();
      }
    } else //generate temp id
    {
      int id = 0;
      if (products.length > 0) {
        products.sort((a, b) => a.id.compareTo(b.id));
        id = products[products.length - 1].id + 1;
      }

      products.add(
        convertProductToCartProduct(product, size, id),
      );
    }
    ButtonCartIconNavBarComponent.numberOfItems = products.length;
    sharedPref.updateCartInfo(products);
  }

  Future<dynamic> removeProductFromCart(CartProduct product) async {
    SharedPref sharedPref = SharedPref();
    User userInfo = Authentication.userData();

    List<CartProduct> products = await sharedPref.getCartInfo();
    products.removeWhere((item) => item.id == product.id);
    ButtonCartIconNavBarComponent.numberOfItems = products.length;
    sharedPref.updateCartInfo(products);

    //Authorized ?
    if (userInfo != null) {
      NetworkHelper networkHelper = NetworkHelper(
        kRemoveFromCartUrl + "/" + product.id.toString(),
      );
      await networkHelper.getData();
    }
  }

  CartProduct convertProductToCartProduct(
      Product product, String size, int id) {
    CartProduct cartProduct = CartProduct();
    cartProduct.id = id;
    cartProduct.size = size;
    cartProduct.nameEn = product.nameEn;
    cartProduct.nameAr = product.nameAr;
    cartProduct.productId = product.id;
    cartProduct.imageName = product.imageName;
    cartProduct.colorAr = product.colorAr;
    cartProduct.colorEn = product.colorEn;
    cartProduct.currency = product.currency;
    cartProduct.price = product.price;
    cartProduct.discountActive = product.discountActive;
    cartProduct.discountPrice = product.discountPrice;

    return cartProduct;
  }

  Future<dynamic> updateCart() async {
    SharedPref sharedPref = SharedPref();
    List<CartProduct> productsInMemory = await sharedPref.getCartInfo();
    if (productsInMemory.length > 0 && Authentication.isAuth()) {
      UpdateCartModelView cartModelView =
          UpdateCartModelView(products: productsInMemory);

      NetworkHelper networkHelper = NetworkHelper(
        kUpdateCart,
      );

      await networkHelper.postDataWithKey(cartModelView.toJson(), kCartKey,
          checkInMemory: false, saveInMemory: true);
    }
  }
}
