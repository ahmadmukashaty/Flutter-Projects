import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:oneaddress/Classes/Slider/SubCategory.dart';
import 'package:oneaddress/Screens/ListProductsScreen.dart';
import 'package:oneaddress/Services/Network_Cache_Management/CustomCacheManager.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class SubCategoryItem extends StatefulWidget {
  final SubCategory subCategory;

  SubCategoryItem({
    this.subCategory,
  });

  @override
  _SubCategoryItemState createState() => _SubCategoryItemState();
}

class _SubCategoryItemState extends State<SubCategoryItem> {
  //File imageFile;
  //bool loading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ListProductsScreen(
                subCategory: this.widget.subCategory,
              );
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Color.fromRGBO(236, 236, 236, 1),
          ),
        ),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _sizedContainerSubCategory(
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(widget.subCategory.file),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                          left: 8.0,
                          bottom: 8.0,
                          right: 8.0,
                        ),
                        child: Text(
                          widget.subCategory.getName(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizedContainerSubCategory(Widget child) => SizedBox(
        width: 80.0,
        height: 80.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            right: 10.0,
            bottom: 10.0,
            left: 10.0,
          ),
          child: Center(child: child),
        ),
      );
}
