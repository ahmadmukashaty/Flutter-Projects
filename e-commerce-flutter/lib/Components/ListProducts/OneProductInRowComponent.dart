import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Components/ListProducts/ProductImage.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class OneProductInRowComponent extends StatelessWidget {
  final Product product;
  TextDecoration decoration;
  String saleText;

  OneProductInRowComponent({@required this.product}) {
    decoration = (this.product.discountActive == 1)
        ? TextDecoration.lineThrough
        : TextDecoration.none;
    saleText = (this.product.discountActive == 1)
        ? this.product.discountPrice.round().toString()
        : "";
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = double.maxFinite;
    double imageHeight = MediaQuery.of(context).size.height * (2 / 3);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProductImage(
                        width: imageWidth,
                        height: imageHeight,
                        product: this.product,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Text(
                          product.getName(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      (LanguageManagement.isArabic())
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Text(
                                    "${(product.price.round()).toString()}  ${product.currency.toString()}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      decoration: decoration,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0),
                                  child: Text(
                                    "  " +
                                        saleText +
                                        " ${product.currency.toString()} ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text.rich(
                                TextSpan(
                                  text:
                                      "${(product.price.round()).toString()}  ${product.currency.toString()}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    decoration: decoration,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "  " +
                                          saleText +
                                          " ${product.currency.toString()} ",
                                      style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    // can add more TextSpans here...
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
