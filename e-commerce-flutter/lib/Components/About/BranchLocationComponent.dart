import 'package:flutter/material.dart';

class BranchLocationComponent extends StatelessWidget {
  final String location;

  BranchLocationComponent({this.location});

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
              Icons.location_on,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
            ),
            child: Text(
              location,
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
