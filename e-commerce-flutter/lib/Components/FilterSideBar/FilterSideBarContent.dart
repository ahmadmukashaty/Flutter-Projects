import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Filter/Filter.dart';
import 'package:oneaddress/Classes/Filter/FilterGroupModelView.dart';
import 'package:oneaddress/Components/FilterSideBar/FilterGroupComponent.dart';

class FilterSideBarContent extends StatefulWidget {
  @override
  _FilterSideBarContentState createState() => _FilterSideBarContentState();
}

class _FilterSideBarContentState extends State<FilterSideBarContent> {
  List<FilterGroupModelView> filters;

  @override
  void initState() {
    filters = (new Filter()).generateFilterGroups();
    super.initState();
  }

  List<Widget> generateFilterGroups() {
    List<Widget> filterGroups = List<Widget>();
    for (FilterGroupModelView filterGroup in this.filters) {
      FilterGroupComponent filterGroupComponent = FilterGroupComponent(
        filterGroup: filterGroup,
      );
      filterGroups.add(filterGroupComponent);
    }
    return filterGroups;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Column(
                children: generateFilterGroups(),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
              ),
            )),
            Checkbox(
              checkColor: Colors.black,
              activeColor: Colors.white,
              focusColor: Colors.white,
              hoverColor: Colors.white,
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
