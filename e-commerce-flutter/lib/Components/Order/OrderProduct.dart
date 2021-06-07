import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderProduct extends StatefulWidget {
  final CartProduct product;
  OrderProduct({
    this.product,
  });

  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  double calculatePrice() {
    if (widget.product.discountActive == 1) {
      return widget.product.discountPrice;
    }
    return widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              _sizedContainerCartProduct(
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: FileImage(widget.product.file),
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
                        top: 10.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Text(
                        widget.product.getName(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Text(
                        "size".tr() + " : " + widget.product.size,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Text(
                        "color".tr() + " : " + widget.product.getColor(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 8.0,
                        right: 8.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        calculatePrice().round().toString() +
                            " * 1 " +
                            widget.product.currency,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
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
    );
  }

  Widget _sizedContainerCartProduct(Widget child) => SizedBox(
        width: 115.0,
        height: 115.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            right: 10.0,
            left: 10.0,
          ),
          child: Center(child: child),
        ),
      );
}
