import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/Category.dart';
import 'package:oneaddress/Classes/Slider/SubCategory.dart';
import 'package:oneaddress/Components/AllCategories/SubCategoryItem.dart';
import 'package:oneaddress/Screens/ListProductsScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class AllSubCategories extends StatefulWidget {
  final ScrollController controller;
  final Category category;

  AllSubCategories({
    @required this.controller,
    @required this.category,
  });

  @override
  _AllSubCategoriesState createState() => _AllSubCategoriesState();
}

class _AllSubCategoriesState extends State<AllSubCategories> {
  File imageFile;
  bool hasNewIn = false;
  SubCategory newInCategory;
  @override
  void initState() {
    checkNewIn();
    //loadingImage();
    super.initState();
  }

  checkNewIn() {
    if (widget.category.children != null &&
        widget.category.children.length > 0) {
      String categoryName = widget.category.children[0].nameEn;
      categoryName = categoryName.replaceAll(new RegExp(r"\s+"), "");
      if (categoryName.toLowerCase() == "newin") {
        newInCategory = widget.category.children[0];
        widget.category.children.remove(newInCategory);
        hasNewIn = true;
      }
    }
  }

  List<Widget> generateSubCategoryList() {
    if (widget.category.children.length == 0) return null;

    List<Widget> list = List<Widget>();

    for (var i = 0; i < widget.category.children.length; i++) {
      SubCategoryItem subCategoryItem = SubCategoryItem(
        subCategory: widget.category.children[i],
      );

      list.add(subCategoryItem);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Container(
              child: Card(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 250.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  top: 20.0,
                                  right: 8.0,
                                ),
                                child: Text(
                                  widget.category.getName().toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.category.getDescription(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        _sizedContainer(
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(widget.category.file),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                        right: 5.0,
                        bottom: 20.0,
                      ),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: FlatButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          onPressed: () {
                            if (hasNewIn) {
                              Navigator.pushNamed(
                                context,
                                ListProductsScreen.routeName,
                                arguments: newInCategory,
                              );
                            }
                          },
                          child: Text(
                            "new in",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ).tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 5.0,
              right: 5.0,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 20.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Text(
                      "new products",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                  Column(
                    children: generateSubCategoryList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sizedContainer(Widget child) => SizedBox(
        width: 130.0,
        height: 130.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 20.0,
            right: 20.0,
            bottom: 20.0,
            left: 20.0,
          ),
          child: Center(child: child),
        ),
      );
}
