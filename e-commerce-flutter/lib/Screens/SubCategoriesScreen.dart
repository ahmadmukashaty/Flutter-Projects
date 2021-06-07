import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/Category.dart';
import 'package:oneaddress/Components/AllCategories/AllSubCategories.dart';

class SubCategoriesScreen extends StatefulWidget {
  final Category category;

  SubCategoriesScreen({
    @required this.category,
  });

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecebeb),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.category.getName().toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: AllSubCategories(
          controller: _scrollController,
          category: widget.category,
        ),
      ),
    );
  }
}
