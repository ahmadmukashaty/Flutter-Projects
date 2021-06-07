import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Filter/FilterItemModelView.dart';

class FilterItemComponent extends StatefulWidget {
  final FilterItemModelView filterItem;
  FilterItemComponent({@required this.filterItem});

  @override
  _FilterItemComponentState createState() => _FilterItemComponentState();
}

class _FilterItemComponentState extends State<FilterItemComponent> {
  FontWeight filterFontWeight;
  Color filterIconColor;
  @override
  void initState() {
    this.filterFontWeight =
        widget.filterItem.isChecked ? FontWeight.bold : FontWeight.normal;
    this.filterIconColor =
        widget.filterItem.isChecked ? Colors.black : Colors.transparent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.filterItem.isChecked = !widget.filterItem.isChecked;
          this.filterFontWeight =
              widget.filterItem.isChecked ? FontWeight.bold : FontWeight.normal;
          this.filterIconColor =
              widget.filterItem.isChecked ? Colors.black : Colors.transparent;
        });
      },
      child: ListTile(
        title: Text(
          widget.filterItem.name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: filterFontWeight,
            fontSize: 12.0,
          ),
        ),
        trailing: Icon(
          Icons.check,
          size: 15.0,
          color: filterIconColor,
        ),
      ),
    );
  }
}
