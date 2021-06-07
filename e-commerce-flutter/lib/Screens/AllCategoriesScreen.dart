import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Classes/Slider/CategoryTree.dart';
import 'package:oneaddress/Components/AllCategories/AllCategories.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/WebServices/CategoryListService.dart';
import 'package:oneaddress/Services/Management/CountryManagement.dart';
import 'package:oneaddress/Utilities/CustomAppBar.dart';

class AllCategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  ScrollController _scrollController;
  CategoryTree categoryTree;
  bool loading = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    getCategoryData();
  }

  void getCategoryData() async {
    Country country = CountryManagement.countryData();
    if (CategoryListService.getCategories() == null) {
      await CategoryListService.getCategoryInfo(country.id);
    }
    var categoryData = CategoryListService.getCategories();
    categoryTree = CategoryTree(tree: categoryData);
    categoryTree.getCategoryList();
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(),
            body: SafeArea(
              child: AllCategories(
                controller: _scrollController,
                categories: categoryTree.getCategoryList(),
              ),
            ),
          );
  }
}
