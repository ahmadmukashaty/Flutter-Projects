import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';
import 'package:oneaddress/Classes/ProductList/ProductGroup.dart';
import 'package:oneaddress/Classes/ProductList/ProductsList.dart';
import 'package:oneaddress/Classes/Slider/SubCategory.dart';
import 'package:oneaddress/Components/BottomNavBar/BottomAppBarComponent.dart';
import 'package:oneaddress/Components/FilterSideBar/FilterSideBarContent.dart';
import 'package:oneaddress/Components/ListProducts/ProductGroupComponent.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/Network_Cache_Management/ImageCacheManagement.dart';
import 'package:oneaddress/Services/Management/CountryManagement.dart';
import 'package:oneaddress/Services/WebServices/ProductListService.dart';

class ListProductsScreen extends StatefulWidget {
  static const routeName = '/listProducts';

  final SubCategory subCategory;
  ListProductsScreen({
    this.subCategory,
  });

  @override
  _ListProductsScreenState createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  ScrollController _controller;
  ProductsList productsList;
  List<ProductGroup> displayedProducts;
  IconData filterIcon = Icons.filter_list;
  bool loading = true;
  bool endOfList = false;
  int startIndex = 0;
  int listStartIndex = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          if (listStartIndex > 0) {}
        } else {
          if (!endOfList && ModalRoute.of(context).isCurrent) {
            showLoadingDialog();
            List values = await ImageCacheManagement.saveCategoryImagesInCache(
              products: productsList.products,
              categoryId: widget.subCategory.id,
              isPrimary: false,
              startIndex: startIndex,
            );

            updateListProducts(values);
            setState(() {
              hideLoadingDialog();
            });
          }
        }
      }
    });

    productsList = ProductsList();
    displayedProducts = List<ProductGroup>();
    getListProductsData();
    super.initState();
  }

  void getListProductsData() async {
    Country country = CountryManagement.countryData();
    List<ProductGroup> listProductsData = await ProductListService()
        .getProductList(
            widget.subCategory.id.toString(), country.id.toString());
    if (listProductsData.length > 0) {
      productsList = ProductsList(products: listProductsData);
      List values = await ImageCacheManagement.saveCategoryImagesInCache(
        products: productsList.products,
        categoryId: widget.subCategory.id,
      );
      updateListProducts(values);
      setState(() {
        loading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void updateListProducts(List values) {
    endOfList = values[0];
    startIndex = values[1];
    int endIndex = values[2];
    for (int i = startIndex; i <= endIndex; i++) {
      displayedProducts.add(productsList.products[i]);
    }
    startIndex = endIndex + 1;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return (loading)
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                widget.subCategory.getName(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors
                  .white, /*
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(filterIcon),
                    onPressed: () {
                      setState(() {
                        if (_scaffoldKey.currentState.isEndDrawerOpen ==
                            false) {
                          _scaffoldKey.currentState.openEndDrawer();
                          filterIcon = Icons.close;
                        } else {
                          _scaffoldKey.currentState.openDrawer();
                          filterIcon = Icons.filter_list;
                        }
                      });
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],*/
            ),
            body: Scaffold(
              bottomNavigationBar: BottomAppBarComponent(),
              drawerScrimColor: Colors.transparent,
              //key: _scaffoldKey,
              endDrawer: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors
                      .white, //This will change the drawer background to blue.
                  //other styles
                ),
                child: SizedBox(
                  width: 200.0,
                  child: Drawer(
                    child: FilterSideBarContent(),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: ListView.builder(
                addAutomaticKeepAlives: true,
                controller: _controller,
                itemCount: displayedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ProductGroupComponent(
                              productGroup: displayedProducts[index],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
