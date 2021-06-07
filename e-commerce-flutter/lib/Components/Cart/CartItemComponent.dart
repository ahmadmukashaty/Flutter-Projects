import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:oneaddress/Classes/Cart/CartProduct.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/WebServices/CartListService.dart';
import 'package:easy_localization/easy_localization.dart';

class CartItemComponent extends StatefulWidget {
  final CartProduct product;
  final DeleteCallback deleteCallback;

  CartItemComponent({
    @required this.product,
    @required this.deleteCallback,
  });

  @override
  _CartItemComponentState createState() => _CartItemComponentState();
}

class _CartItemComponentState extends State<CartItemComponent> {
  double calculatePrice() {
    if (widget.product.discountActive == 1) {
      return widget.product.discountPrice;
    }
    return widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    double cwidth = MediaQuery.of(context).size.width / 2;
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.only(
          bottom: 20.0,
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: _sizedContainer(
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        widget.product.file,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 30.0,
                  ),
                  child: Container(
                    width: cwidth,
                    child: Text(
                      widget.product.getName(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 20.0,
                  ),
                  child: Container(
                    width: cwidth,
                    child: Text(
                      "size".tr() + ": " + widget.product.size,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 20.0,
                  ),
                  child: Container(
                    width: cwidth,
                    child: Text(
                      "color".tr() + ": " + widget.product.getColor(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 30.0,
                  ),
                  child: Container(
                    width: cwidth,
                    child: Text(
                      "price".tr() + ": " + calculatePrice().round().toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: IconSlideAction(
            caption: 'delete'.tr(),
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _showSnackBar(context),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context) async {
    CartListService cartListService = CartListService();

    await cartListService.removeProductFromCart(widget.product);
    final snackBar = SnackBar(
      content: (LanguageManagement.isEnglish())
          ? Text(
              widget.product.getName() + " is removed successfully",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : Text(
              "تم حذف " + widget.product.getName() + " بنجاح ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black,
    );
    Scaffold.of(context).showSnackBar(snackBar);
    widget.deleteCallback(widget.product);
  }

  Widget _sizedContainer(Widget child) => SizedBox(
        width: 160.0,
        height: 210.0,
        child: Center(child: child),
      );
}

typedef DeleteCallback = void Function(CartProduct product);
