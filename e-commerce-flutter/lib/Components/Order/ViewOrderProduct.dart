import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Order/OrderProduct.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewOrderProduct extends StatelessWidget {
  final OrderProduct orderProduct;
  ViewOrderProduct({
    this.orderProduct,
  });

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
              _sizedContainerOrderProduct(
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: FileImage(orderProduct.imageFile),
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
                        orderProduct.getName(),
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
                        "size".tr() + " : " + orderProduct.size,
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
                        "color".tr() + " : " + orderProduct.getColor(),
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
                        orderProduct.cost.round().toString() + " * 1 ",
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

  Widget _sizedContainerOrderProduct(Widget child) => SizedBox(
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
