import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ButtonTextNavBarComponent extends StatefulWidget {
  final String text;
  final int flexNumber;
  ButtonTextNavBarComponent({@required this.text, this.flexNumber = 1});
  @override
  _ButtonTextNavBarComponentState createState() =>
      _ButtonTextNavBarComponentState();
}

class _ButtonTextNavBarComponentState extends State<ButtonTextNavBarComponent> {
  @override
  Widget build(BuildContext context) {
    print(context.locale.toString());
    return Expanded(
      flex: widget.flexNumber,
      child: FlatButton(
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
        ).tr(),
        onPressed: () {
          setState(() {
            Navigator.pushNamed(
              context,
              '/categories',
            );
          });
        },
      ),
    );
  }
}
