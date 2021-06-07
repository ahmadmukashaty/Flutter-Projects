import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Specification.dart';

class ProductSpecification extends StatefulWidget {
  final Specification specification;

  ProductSpecification({
    this.specification,
  });

  @override
  _ProductSpecificationState createState() => _ProductSpecificationState();
}

class _ProductSpecificationState extends State<ProductSpecification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
      child: Text(
        widget.specification.key + " : " + widget.specification.value,
        style: TextStyle(
          color: Colors.black,
          height: 2.0,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
