import 'package:flutter/material.dart';

class BranchPhoneComponent extends StatelessWidget {
  final String phone;

  BranchPhoneComponent({this.phone});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
            ),
            child: Icon(
              Icons.phone_in_talk,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
            ),
            child: Text(
              phone,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
