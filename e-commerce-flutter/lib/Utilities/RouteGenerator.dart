import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneaddress/Screens/AboutScreen.dart';
import 'package:oneaddress/Screens/AllCategoriesScreen.dart';
import 'package:oneaddress/Screens/CartScreen.dart';
import 'package:oneaddress/Screens/ChangeLanguageScreen.dart';
import 'package:oneaddress/Screens/ChangePasswordScreen.dart';
import 'package:oneaddress/Screens/EditProfileScreen.dart';
import 'package:oneaddress/Screens/ForgetPassScreen.dart';
import 'package:oneaddress/Screens/ListProductsScreen.dart';
import 'package:oneaddress/Screens/ProductScreen.dart';
import 'package:oneaddress/Screens/SignInScreen.dart';
import 'package:oneaddress/Screens/SignUpScreen.dart';
import 'package:oneaddress/Screens/ViewOrdersScreen.dart';
import 'package:oneaddress/main.dart';

import 'CustomRouteAnimation.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());
      case ViewOrdersScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => ViewOrdersScreen());
      case CartScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => CartScreen());
      case AllCategoriesScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => AllCategoriesScreen());
      case ListProductsScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => ListProductsScreen(
            subCategory: args,
          ),
        );
      case ChangeLanguageScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChangeLanguageScreen());
      case EditProfileScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditProfileScreen());
      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChangePasswordScreen());
      case ForgetPassScreen.routeName:
        return ProductRouteAnimation(
          widget: ForgetPassScreen(),
        );
      case ProductScreen.routeName:
        return ProductRouteAnimation(
          widget: ProductScreen(
            product: args,
          ),
        );
      case AboutScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => AboutScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
