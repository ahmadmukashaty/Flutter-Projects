import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Screens/CartScreen.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/WebServices/CartListService.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:easy_localization/easy_localization.dart';

class SlidingUpCollapsed extends StatefulWidget {
  final Product product;
  TextDecoration decoration;
  String saleText;

  SlidingUpCollapsed({
    @required this.product,
  }) {
    decoration = (this.product.discountActive == 1)
        ? TextDecoration.lineThrough
        : TextDecoration.none;
    saleText = (this.product.discountActive == 1)
        ? this.product.discountPrice.round().toString()
        : "";
  }

  @override
  _SlidingUpCollapsed createState() => _SlidingUpCollapsed();
}

class _SlidingUpCollapsed extends State<SlidingUpCollapsed> {
  CartListService cartListService;
  static List<String> _listViewData;

  @override
  void initState() {
    super.initState();
    cartListService = CartListService();
    _listViewData = widget.product.getProductSizes();
  }

  _showDrawer() {
    Future<String> future = showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 20.0),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "what is your size ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                ),
                Divider(color: Colors.black),
                Column(
                  children: List.generate(_listViewData.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, _listViewData[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            _listViewData[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        );
      },
    );
    future.then((String value) => _closeModal(value));
  }

  void _closeModal(String value) async {
    print(value);
    if (value != null) {
      CartListService cartListService = CartListService();
      await cartListService.addProductToCart(widget.product, value);
      final snackBar = SnackBar(
        content: (LanguageManagement.isEnglish())
            ? Text(
                widget.product.getName() + " is added successfully",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : Text(
                "تمت إضافة " + widget.product.getName() + " بنجاح ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        action: SnackBarAction(
          label: 'view'.tr(),
          textColor: Colors.blue,
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                ProductRouteAnimation(
                  widget: CartScreen(),
                ),
              );
            });
          },
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Text(
              widget.product.getName(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
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
                          top: 5.0, left: 20.0, right: 20.0),
                      child: Text(
                        "${(widget.product.price.round()).toString()}  ${widget.product.currency.toString()}",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          decoration: widget.decoration,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 20.0, right: 10.0),
                      child: Text(
                        "  " +
                            widget.saleText +
                            " ${widget.product.currency.toString()} ",
                        style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: Text.rich(
                    TextSpan(
                      text:
                          "${(widget.product.price.round()).toString()}  ${widget.product.currency.toString()}",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        decoration: widget.decoration,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "  " +
                              widget.saleText +
                              " ${widget.product.currency.toString()} ",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                child: FlatButton(
                  padding: EdgeInsets.all(10.0),
                  onPressed: () {
                    _showDrawer();
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 0.0,
                    ),
                    child: Text(
                      'add',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
