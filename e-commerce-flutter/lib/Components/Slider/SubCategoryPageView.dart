import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/SubCategory.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

import '../../Screens/ListProductsScreen.dart';

class SubCategoryPageView extends StatefulWidget {
  SubCategoryPageView({
    @required this.subCategory,
  });

  final SubCategory subCategory;

  @override
  _SubCategoryPageViewState createState() => _SubCategoryPageViewState();
}

class _SubCategoryPageViewState extends State<SubCategoryPageView> {
  @override
  void initState() {
    super.initState();
  }

  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    context.locale = LanguageManagement.getLocale();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: FileImage(widget.subCategory.file),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    this.widget.subCategory.getName(),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 40.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 40.0, bottom: 20.0, left: 40.0),
                    child: Text(
                      this.widget.subCategory.getDescription(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FlatButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                    onPressed: () {
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
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: textColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Text(
                      'view',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20.0,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
