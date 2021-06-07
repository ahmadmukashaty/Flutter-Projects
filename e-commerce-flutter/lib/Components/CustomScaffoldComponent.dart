import 'package:flutter/material.dart';
import 'package:oneaddress/Components/BottomNavBar/BottomAppBarComponent.dart';

class CustomScaffoldComponent extends StatelessWidget {
  final bool hasBottomNavbar;
  final Widget child;
  CustomScaffoldComponent({@required this.child, this.hasBottomNavbar = false});

  Widget checkBottomNavBar() {
    return (this.hasBottomNavbar ? BottomAppBarComponent() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: checkBottomNavBar(),
          body: Center(child: child),
        ),
      ),
    );
  }
}
