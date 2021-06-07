import 'package:flutter/material.dart';
import 'package:oneaddress/Screens/SignInScreen.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:badges/badges.dart';

class ButtonCartIconNavBarComponent extends StatefulWidget {
  final IconData icon;
  final int flexNumber;
  final String assignedRoute;
  final bool authorization;
  static int numberOfItems = 0;

  ButtonCartIconNavBarComponent({
    @required this.icon,
    this.flexNumber = 1,
    this.assignedRoute,
    this.authorization = false,
  });

  @override
  _ButtonCartIconNavBarComponentState createState() =>
      _ButtonCartIconNavBarComponentState();
}

class _ButtonCartIconNavBarComponentState
    extends State<ButtonCartIconNavBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flexNumber,
      child: Badge(
        badgeContent:
            Text(ButtonCartIconNavBarComponent.numberOfItems.toString()),
        position: BadgePosition.topLeft(top: -10, left: 40),
        child: GestureDetector(
          child: Icon(
            widget.icon,
            color: Colors.black,
          ),
          onTap: () async {
            if (widget.authorization && Authentication.notAuth()) {
              Navigator.push(
                context,
                ProductRouteAnimation(
                  widget: SignInScreen(),
                ),
              );
            } else {
              setState(() {
                if (widget.assignedRoute != null)
                  Navigator.pushNamed(
                    context,
                    widget.assignedRoute,
                  );
              });
            }
          },
        ),
      ),
    );
  }
}
