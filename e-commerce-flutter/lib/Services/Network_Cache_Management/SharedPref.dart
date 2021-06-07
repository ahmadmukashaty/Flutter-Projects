import 'dart:convert';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Authentication/Language.dart';
import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:oneaddress/Classes/Cart/CartProductList.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Classes/Order/UserOrders.dart';
import 'package:oneaddress/Components/BottomNavBar/ButtonCartIconNavBarComponent.dart';
import 'package:oneaddress/Utilities/Constants.dart';
import 'package:oneaddress/Utilities/JsonResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) return prefs.getString(key);
    return null;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) prefs.remove(key);
  }

  clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs
        .getKeys()
        .where((String key) =>
            key != kCountryKey &&
            key != kUserKey &&
            key != kLangKey &&
            key != kCartKey)
        .toList();
    if (keys != null) {
      for (int i = 0; i < keys.length; i++) {
        prefs.remove(keys[i]);
      }
    }
  }

  removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kUserKey)) prefs.remove(kUserKey);
  }

  Future<User> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kUserKey)) {
      String data = prefs.getString(kUserKey);
      dynamic parsedUser = jsonDecode(data);
      dynamic userInfo = JSONUtils().get(parsedUser, 'result', null);
      User user = User.fromJson(userInfo);
      return user;
    }
    return null;
  }

  Future<Language> getAppLang() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kLangKey)) {
      String langData = prefs.getString(kLangKey);
      dynamic parsedLanguage = jsonDecode(langData);
      Language lang = Language.fromJson(parsedLanguage);

      return lang;
    }

    return Language.getDefault();
  }

  Future<Country> getCountryInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kCountryKey)) {
      String data = prefs.getString(kCountryKey);
      dynamic parsedCountry = jsonDecode(data);
      Country country = Country.fromJson(parsedCountry);
      return country;
    }
    return null;
  }

  Future<dynamic> saveCountryInfo(Country country) async {
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(kCountryKey, jsonEncode(country));
    return true;
  }

  Future<List<CartProduct>> getCartInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kCartKey)) {
      String data = prefs.getString(kCartKey);
      dynamic parsedCart = jsonDecode(data);
      final List parsedList = JSONUtils().get(parsedCart, 'result.cart', null);
      if (parsedList == null) return [];
      List<CartProduct> products =
          parsedList.map((val) => CartProduct.fromJson(val)).toList();
      return products;
    }
    return [];
  }

  Future<List<UserOrder>> getAllOrders() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kOrdersKey)) {
      String data = prefs.getString(kOrdersKey);
      dynamic parsedOrders = jsonDecode(data);
      final List parsedList = JSONUtils().get(parsedOrders, 'result', null);
      if (parsedList == null) return [];
      List<UserOrder> orders =
          parsedList.map((val) => UserOrder.fromJson(val)).toList();
      return orders;
    }
    return [];
  }

  Future<dynamic> updateCartInfo(List<CartProduct> cartProducts) async {
    final prefs = await SharedPreferences.getInstance();
    CartProductList cartProductList = CartProductList(cart: cartProducts);
    JsonResponse response = JsonResponse(
      status: 200,
      msg: "",
      result: cartProductList,
    );
    prefs.setString(
      kCartKey,
      jsonEncode(response),
    );
  }
}
