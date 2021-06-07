import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        'back',
        style: TextStyle(
          color: Colors.black,
        ),
      ).tr(),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
