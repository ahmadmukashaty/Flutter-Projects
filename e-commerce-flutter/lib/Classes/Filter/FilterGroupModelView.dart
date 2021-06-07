import 'package:oneaddress/Classes/Filter/FilterItemModelView.dart';

class FilterGroupModelView {
  String groupName;
  bool isExpanded;
  List<FilterItemModelView> filters;

  FilterGroupModelView({
    this.groupName,
    this.isExpanded,
    this.filters,
  });
}
