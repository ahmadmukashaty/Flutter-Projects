import 'package:oneaddress/Classes/About/BranchInfo.dart';
import 'package:oneaddress/Classes/About/BranchItem.dart';
import 'package:oneaddress/Services/Management/CountryManagement.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class BranchList {
  List<BranchInfo> values;

  BranchList.english() {
    values = List<BranchInfo>();
    if (CountryManagement.isSyria()) {
      BranchItem branchItem1 = BranchItem(
        location: "Al-shaalan main street",
        phone: "3320203",
      );
      BranchItem branchItem2 = BranchItem(
        location: "Al-mazzeh Highway, in front of the Justice caurt",
        phone: "6125486",
      );
      BranchItem branchItem3 = BranchItem(
        location: "Mashrou dummar, al-Sham Central Market",
        phone: "3122774",
      );
      BranchItem branchItem4 = BranchItem(
        location: "Qudsaya suburb, the phone center decline.",
        phone: "3456232",
      );
      List<BranchItem> items1 = List<BranchItem>();
      items1.add(branchItem1);
      items1.add(branchItem2);
      items1.add(branchItem3);
      items1.add(branchItem4);
      BranchInfo branchInfo1 = BranchInfo(name: "Damascus", branches: items1);
      values.add(branchInfo1);

      BranchItem branchItem5 = BranchItem(
        location: "Orange Mall, ground floor",
        phone: "041/2335549",
      );
      BranchItem branchItem6 = BranchItem(
        location: "8th March Street",
        phone: "041/2594023",
      );
      BranchItem branchItem7 = BranchItem(
        location: "Hanano Street, next to Jaara Ice Cream",
        phone: "041/2562366",
      );

      List<BranchItem> items2 = List<BranchItem>();
      items2.add(branchItem5);
      items2.add(branchItem6);
      items2.add(branchItem7);
      BranchInfo branchInfo2 = BranchInfo(name: "Lattakia", branches: items2);
      values.add(branchInfo2);

      BranchItem branchItem8 = BranchItem(
        location: "Al-Dablan, Al-Arrab Street",
        phone: "031/2225577",
      );

      List<BranchItem> items3 = List<BranchItem>();
      items3.add(branchItem8);

      BranchInfo branchInfo3 = BranchInfo(name: "Homs", branches: items3);
      values.add(branchInfo3);

      BranchItem branchItem9 = BranchItem(
        location: "Hanano Street",
        phone: "043/2323659",
      );

      List<BranchItem> items4 = List<BranchItem>();
      items4.add(branchItem9);

      BranchInfo branchInfo4 = BranchInfo(name: "Tartus", branches: items4);
      values.add(branchInfo4);

      BranchItem branchItem10 = BranchItem(
        location: "Al-amara Circle",
        phone: "041/8894617",
      );

      List<BranchItem> items5 = List<BranchItem>();
      items5.add(branchItem10);

      BranchInfo branchInfo5 = BranchInfo(name: "Jablah", branches: items5);
      values.add(branchInfo5);

      BranchItem branchItem11 = BranchItem(
        location: "The beginning of Jules Jamal Street",
        phone: "043/7773980",
      );

      List<BranchItem> items6 = List<BranchItem>();
      items6.add(branchItem11);

      BranchInfo branchInfo6 = BranchInfo(name: "Baniyas", branches: items6);
      values.add(branchInfo6);
    } else {
      BranchItem branchItem1 = BranchItem(
        location: "Fujairah Tower, 11th Floor, Fujairah",
        phone: "+971 50 474 212 5",
      );

      List<BranchItem> items1 = List<BranchItem>();
      items1.add(branchItem1);

      BranchInfo branchInfo1 = BranchInfo(name: "Dubai", branches: items1);
      values.add(branchInfo1);
    }
  }

  BranchList.arabic() {
    values = List<BranchInfo>();

    if (CountryManagement.isSyria()) {
      BranchItem branchItem1 = BranchItem(
        location: "Al-shaalan main street",
        phone: "3320203",
      );
      BranchItem branchItem2 = BranchItem(
        location: "Al-mazzeh Highway, in front of the Justice caurt",
        phone: "6125486",
      );
      BranchItem branchItem3 = BranchItem(
        location: "Mashrou dummar, al-Sham Central Market",
        phone: "3122774",
      );
      BranchItem branchItem4 = BranchItem(
        location: "Qudsaya suburb, the phone center decline.",
        phone: "3456232",
      );
      List<BranchItem> items1 = List<BranchItem>();
      items1.add(branchItem1);
      items1.add(branchItem2);
      items1.add(branchItem3);
      items1.add(branchItem4);
      BranchInfo branchInfo1 = BranchInfo(name: "دمشق", branches: items1);
      values.add(branchInfo1);

      BranchItem branchItem5 = BranchItem(
        location: "Orange Mall, ground floor",
        phone: "041/2335549",
      );
      BranchItem branchItem6 = BranchItem(
        location: "8th March Street",
        phone: "041/2594023",
      );
      BranchItem branchItem7 = BranchItem(
        location: "Hanano Street, next to Jaara Ice Cream",
        phone: "041/2562366",
      );

      List<BranchItem> items2 = List<BranchItem>();
      items2.add(branchItem5);
      items2.add(branchItem6);
      items2.add(branchItem7);
      BranchInfo branchInfo2 = BranchInfo(name: "اللاذقية", branches: items2);
      values.add(branchInfo2);

      BranchItem branchItem8 = BranchItem(
        location: "Al-Dablan, Al-Arrab Street",
        phone: "031/2225577",
      );

      List<BranchItem> items3 = List<BranchItem>();
      items3.add(branchItem8);

      BranchInfo branchInfo3 = BranchInfo(name: "حمص", branches: items3);
      values.add(branchInfo3);

      BranchItem branchItem9 = BranchItem(
        location: "Hanano Street",
        phone: "043/2323659",
      );

      List<BranchItem> items4 = List<BranchItem>();
      items4.add(branchItem9);

      BranchInfo branchInfo4 = BranchInfo(name: "طرطوس", branches: items4);
      values.add(branchInfo4);

      BranchItem branchItem10 = BranchItem(
        location: "Al-amara Circle",
        phone: "041/8894617",
      );

      List<BranchItem> items5 = List<BranchItem>();
      items5.add(branchItem10);

      BranchInfo branchInfo5 = BranchInfo(name: "جبلة", branches: items5);
      values.add(branchInfo5);

      BranchItem branchItem11 = BranchItem(
        location: "The beginning of Jules Jamal Street",
        phone: "043/7773980",
      );

      List<BranchItem> items6 = List<BranchItem>();
      items6.add(branchItem11);

      BranchInfo branchInfo6 = BranchInfo(name: "بانياس", branches: items6);
      values.add(branchInfo6);
    } else {
      BranchItem branchItem1 = BranchItem(
        location: "Fujairah Tower, 11th Floor, Fujairah",
        phone: "+971 50 474 212 5",
      );

      List<BranchItem> items1 = List<BranchItem>();
      items1.add(branchItem1);

      BranchInfo branchInfo1 = BranchInfo(name: "دبي", branches: items1);
      values.add(branchInfo1);
    }
  }
}
