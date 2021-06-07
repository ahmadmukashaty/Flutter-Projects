import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/About/BranchInfo.dart';
import 'package:oneaddress/Classes/About/BranchItem.dart';
import 'package:oneaddress/Components/About/BranchLocationComponent.dart';
import 'package:oneaddress/Components/About/BranchPhoneComponent.dart';

class BranchGroupComponent extends StatelessWidget {
  final BranchInfo branchInfo;
  BranchGroupComponent({this.branchInfo});

  List<Widget> generateAllBranchItems() {
    if (branchInfo.branches.length == 0) return null;

    List<Widget> list = List<Widget>();
    bool firstItem = true;
    for (var i = 0; i < branchInfo.branches.length; i++) {
      BranchItem branchItem = branchInfo.branches[i];
      BranchLocationComponent branchLocationComponent = BranchLocationComponent(
        location: branchItem.location,
      );
      BranchPhoneComponent branchPhoneComponent = BranchPhoneComponent(
        phone: branchItem.phone,
      );
      SizedBox sizedBox = SizedBox(height: 20.0);
      if (!firstItem) {
        list.add(sizedBox);
      } else {
        firstItem = !firstItem;
      }
      list.add(branchLocationComponent);
      list.add(branchPhoneComponent);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      trailing: Icon(
        Icons.keyboard_arrow_down,
        size: 26.0,
        color: Colors.black,
      ),
      title: Text(
        branchInfo.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: generateAllBranchItems(),
    );
  }
}
