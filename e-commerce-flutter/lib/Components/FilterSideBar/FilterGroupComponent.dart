import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Filter/FilterGroupModelView.dart';
import 'package:oneaddress/Classes/Filter/FilterItemModelView.dart';
import 'package:oneaddress/Components/FilterSideBar/FilterItemComponent.dart';

class FilterGroupComponent extends StatefulWidget {
  final FilterGroupModelView filterGroup;
  FilterGroupComponent({@required this.filterGroup});

  @override
  _FilterGroupComponentState createState() => _FilterGroupComponentState();
}

class _FilterGroupComponentState extends State<FilterGroupComponent> {
  List<Widget> generateFilterItems() {
    List<Widget> filterItems = List<Widget>();
    for (FilterItemModelView filterItem in widget.filterGroup.filters) {
      FilterItemComponent filterItemComponent = FilterItemComponent(
        filterItem: filterItem,
      );
      filterItems.add(filterItemComponent);
    }
    return filterItems;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: widget.filterGroup.isExpanded,
      trailing: Icon(
        Icons.keyboard_arrow_down,
        size: 26.0,
        color: Colors.black,
      ),
      title: Text(
        widget.filterGroup.groupName,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: generateFilterItems(),
    );
  }
}
