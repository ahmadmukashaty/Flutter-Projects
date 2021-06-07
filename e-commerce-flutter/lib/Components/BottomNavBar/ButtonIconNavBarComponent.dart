import 'package:flutter/material.dart';
import 'package:oneaddress/Screens/SignInScreen.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';

class ButtonIconNavBarComponent extends StatefulWidget {
  final IconData icon;
  final int flexNumber;
  final String assignedRoute;
  final bool authorization;

  ButtonIconNavBarComponent({
    @required this.icon,
    this.flexNumber = 1,
    this.assignedRoute,
    this.authorization = false,
  });

  @override
  _ButtonIconNavBarComponentState createState() =>
      _ButtonIconNavBarComponentState();
}

class _ButtonIconNavBarComponentState extends State<ButtonIconNavBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flexNumber,
      child: IconButton(
        icon: Icon(
          widget.icon,
          color: Colors.black,
        ),
        onPressed: () async {
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
    );
  }
}
