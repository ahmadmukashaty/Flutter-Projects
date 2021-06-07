import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Components/ListProducts/ProductImage.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class TwoProductsInRowComponent extends StatelessWidget {
  final Product product1;
  final Product product2;
  TextDecoration decoration1;
  String saleText1;
  TextDecoration decoration2;
  String saleText2;

  TwoProductsInRowComponent(
      {@required this.product1, @required this.product2}) {
    decoration1 = (this.product1.discountActive == 1)
        ? TextDecoration.lineThrough
        : TextDecoration.none;
    saleText1 = (this.product1.discountActive == 1)
        ? this.product1.discountPrice.round().toString()
        : "";

    decoration2 = (this.product2.discountActive == 1)
        ? TextDecoration.lineThrough
        : TextDecoration.none;
    saleText2 = (this.product2.discountActive == 1)
        ? this.product1.discountPrice.round().toString()
        : "";
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width / 2;
    double imageHeight = MediaQuery.of(context).size.height / 2;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ProductImage(
                    width: imageWidth,
                    height: imageHeight,
                    product: this.product1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                    child: Text(
                      product1.getName(),
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
                                "${(product1.price.round()).toString()}  ${product1.currency.toString()}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  decoration: decoration1,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 10.0),
                              child: Text(
                                "  " +
                                    saleText1 +
                                    " ${product1.currency.toString()} ",
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
                                  "${(product1.price.round()).toString()}  ${product1.currency.toString()}",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                decoration: decoration1,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "  " +
                                      saleText1 +
                                      " ${product1.currency.toString()} ",
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProductImage(
                    width: imageWidth,
                    height: imageHeight,
                    product: this.product2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                    child: Text(
                      this.product2.getName(),
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
                                "${(product2.price.round()).toString()}  ${product2.currency.toString()}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  decoration: decoration2,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 10.0),
                              child: Text(
                                "  " +
                                    saleText2 +
                                    " ${product2.currency.toString()} ",
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
                                  "${(product2.price.round()).toString()}  ${product2.currency.toString()}",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                decoration: decoration2,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "  " +
                                      saleText2 +
                                      " ${product2.currency.toString()} ",
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
    );
  }
}
