import 'package:flutter/material.dart';
import 'package:oneaddress/Components/BottomNavBar/ButtonIconNavBarComponent.dart';
import 'package:oneaddress/Components/BottomNavBar/ButtonTextNavBarComponent.dart';
import 'package:oneaddress/Screens/AboutScreen.dart';
import 'package:oneaddress/Screens/CartScreen.dart';
import 'package:oneaddress/Screens/SignInScreen.dart';
import 'package:oneaddress/Screens/ViewOrdersScreen.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';

import 'ButtonCartIconNavBarComponent.dart';

class BottomAppBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          ButtonIconNavBarComponent(
            icon: Icons.assignment_turned_in,
            assignedRoute: ViewOrdersScreen.routeName,
            authorization: true,
          ),
          ButtonIconNavBarComponent(
            icon: (Authentication.isAuth()) ? Icons.person_pin : Icons.person,
            assignedRoute: SignInScreen.routeName,
          ),
          ButtonTextNavBarComponent(
            text: 'categories',
            flexNumber: 2,
          ),
          ButtonIconNavBarComponent(
            icon: Icons.phone,
            assignedRoute: AboutScreen.routeName,
          ),
          (ButtonCartIconNavBarComponent.numberOfItems > 0)
              ? ButtonCartIconNavBarComponent(
                  icon: Icons.local_grocery_store,
                  assignedRoute: CartScreen.routeName,
                )
              : ButtonIconNavBarComponent(
                  icon: Icons.local_grocery_store,
                  assignedRoute: CartScreen.routeName,
                ),
        ],
      ),
    );
  }
}
