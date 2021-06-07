import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Slider/Category.dart';
import 'package:oneaddress/Screens/SubCategoriesScreen.dart';

class CategoryItem extends StatefulWidget {
  final Category category;

  CategoryItem({
    @required this.category,
  });

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 5.0,
        right: 5.0,
      ),
      child: Container(
        height: 150.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SubCategoriesScreen(
                    category: this.widget.category,
                  );
                },
              ),
            );
          },
          child: Card(
            color: Color(0xffecebeb),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.category.getName(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                _sizedContainer(
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(widget.category.file),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sizedContainer(Widget child) => SizedBox(
        width: 150.0,
        height: 150.0,
        child: Center(child: child),
      );
}
