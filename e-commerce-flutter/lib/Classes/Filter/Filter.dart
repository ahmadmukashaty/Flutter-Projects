import 'package:oneaddress/Classes/Filter/FilterGroupModelView.dart';
import 'package:oneaddress/Classes/Filter/FilterItemModelView.dart';

import 'FilterGroup.dart';

class Filter {
  List<FilterGroup> filters;

  Filter() {
    this.filters = List<FilterGroup>();
    List<String> sizes = ["S", "M", "L", "XL"];
    FilterGroup g1 = FilterGroup(key: "SIZE", values: sizes);
    List<String> colors = [
      "BEIGE",
      "BLACK",
      "BLUE",
      "BROWN",
      "GREEN",
      "ORANG"
          "E",
      "YELLOW"
    ];
    FilterGroup g2 = FilterGroup(key: "COLOR", values: colors);
    List<String> prices = ["10.00 USD", "20.00 USD", "30.00 USD", "50.00 USD"];
    FilterGroup g3 = FilterGroup(key: "PRICE", values: prices);

    this.filters.add(g1);
    this.filters.add(g2);
    this.filters.add(g3);
  }

  generateFilterGroups() {
    bool firstItem = true;
    List<FilterGroupModelView> displayFilters = List<FilterGroupModelView>();
    for (FilterGroup filterGroup in this.filters) {
      List<FilterItemModelView> filterItems = List<FilterItemModelView>();
      for (String filterItem in filterGroup.values) {
        FilterItemModelView filterItemModelView = FilterItemModelView(
          name: filterItem,
          isChecked: false,
        );
        filterItems.add(filterItemModelView);
      }
      FilterGroupModelView filterGroupModelView = FilterGroupModelView(
        groupName: filterGroup.key,
        isExpanded: false,
        filters: filterItems,
      );
      if (firstItem) {
        filterGroupModelView.isExpanded = firstItem;
        firstItem = !firstItem;
      }
      displayFilters.add(filterGroupModelView);
    }
    return displayFilters;
  }
}
