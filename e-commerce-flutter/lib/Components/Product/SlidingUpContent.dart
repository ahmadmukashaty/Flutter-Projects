import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Classes/ProductList/ProductGroup.dart';
import 'package:oneaddress/Classes/ProductList/Specification.dart';
import 'package:oneaddress/Components/Product/ProductColor.dart';
import 'package:oneaddress/Components/Product/ProductRelated.dart';
import 'package:oneaddress/Components/Product/ProductSpecification.dart';
import 'package:oneaddress/Screens/CartScreen.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/WebServices/CartListService.dart';
import 'package:oneaddress/Utilities/CustomRouteAnimation.dart';
import 'package:easy_localization/easy_localization.dart';

class SlidingUpContent extends StatefulWidget {
  final Product product;
  final ScrollController scrollController;
  TextDecoration decoration;
  String saleText;

  SlidingUpContent({
    @required this.product,
    @required this.scrollController,
  }) {
    decoration = (this.product.discountActive == 1)
        ? TextDecoration.lineThrough
        : TextDecoration.none;
    saleText = (this.product.discountActive == 1)
        ? this.product.discountPrice.round().toString()
        : "";
  }

  @override
  _SlidingUpContentState createState() => _SlidingUpContentState();
}

class _SlidingUpContentState extends State<SlidingUpContent> {
  String colorProductTitle = "";
  String relatedProductTitle = "";
  CartListService cartListService;
  static List<String> _listViewData;
  List<Widget> colors;
  List<Widget> relatedProducts;
  bool hasColor = false;
  bool hasRelated = false;

  @override
  void initState() {
    super.initState();
    cartListService = CartListService();
    colors = generateColorProductList();
    relatedProducts = generateRelatedProductList();
    _listViewData = widget.product.getProductSizes();
  }

  List<Widget> generateSpecificationContent() {
    List<Specification> specifications = (LanguageManagement.isEnglish())
        ? widget.product.specificationFormattingEn()
        : widget.product.specificationFormattingAr();
    List<Widget> list = List<Widget>();
    if (specifications != null && specifications.length > 0) {
      for (int i = 0; i < specifications.length; i++) {
        Widget item = ProductSpecification(
          specification: specifications[i],
        );
        list.add(item);
      }
    }
    return list;
  }

  List<Widget> generateColorProductList() {
    ProductGroup productGroup = widget.product.parentProduct;
    List<Widget> productList = List<Widget>();
    if (productGroup != null) {
      Product product = productGroup.getAsProduct();
      if (product.id != widget.product.id) {
        hasColor = true;
        productList.add(
          ProductColor(
            product: product,
          ),
        );
      }
      if (productGroup.products != null) {
        for (int i = 0; i < productGroup.products.length; i++) {
          if (productGroup.products[i].id != widget.product.id) {
            hasColor = true;
            productList.add(
              ProductColor(
                product: productGroup.products[i],
              ),
            );
          }
        }
      }
      if (hasColor) {
        setState(() {
          hasColor = true;
          colorProductTitle = "colors".tr();
        });
      }
    }
    return productList;
  }

  List<Widget> generateRelatedProductList() {
    List<Widget> productList = List<Widget>();
    if (widget.product.relatedProducts != null &&
        widget.product.relatedProducts.length > 0) {
      for (int i = 0; i < widget.product.relatedProducts.length; i++) {
        hasRelated = true;
        productList.add(
          ProductRelated(
            product: widget.product.relatedProducts[i],
          ),
        );
      }
      if (hasRelated) {
        setState(() {
          hasRelated = true;
          relatedProductTitle = "related Products".tr();
        });
      }
    }
    return productList;
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
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
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
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 20.0, right: 20.0),
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
                        left: 20.0, top: 10.0, right: 20.0),
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
                child: Text(
                  "model code".tr() + " : " + widget.product.modelCode,
                  style: TextStyle(
                    color: Colors.black,
                    height: 2.0,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
                child: Text(
                  widget.product.description,
                  style: TextStyle(
                    color: Colors.black,
                    height: 2.0,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: generateSpecificationContent(),
              ),
              (hasColor)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 30.0, right: 20.0),
                      child: Text(
                        colorProductTitle,
                        style: TextStyle(
                          color: Colors.black,
                          height: 2.0,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(0.0),
                    ),
              (hasColor)
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30.0,
                      ),
                      height: 300.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: colors,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(0.0),
                    ),
              (hasRelated)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 30.0, right: 20.0),
                      child: Text(
                        relatedProductTitle,
                        style: TextStyle(
                          color: Colors.black,
                          height: 2.0,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(0.0),
                    ),
              (hasRelated)
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30.0,
                      ),
                      height: 300.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: relatedProducts,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(0.0),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
