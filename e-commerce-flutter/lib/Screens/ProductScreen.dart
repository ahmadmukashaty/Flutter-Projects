import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Components/Product/ProductSlider.dart';
import 'package:oneaddress/Components/Product/SlidingUpCollapsed.dart';
import 'package:oneaddress/Components/Product/SlidingUpContent.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/Network_Cache_Management/ImageCacheManagement.dart';
import 'package:oneaddress/Utilities/CustomAppBar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';

  final Product product;
  ProductScreen({
    this.product,
  });

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  PageController _controller;
  Product product;
  bool loading = true;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
    );
    loading = true;
    initProductParams();
    super.initState();
  }

  void initProductParams() async {
    await ImageCacheManagement.saveSingleProductImagesInCache(
        product: widget.product);
    product = widget.product;
    //product = await ProductService(product: widget.product)
    // .getProductImages();
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    showLoadingDialog();
    await ImageCacheManagement.clearProductData(product.id);
    hideLoadingDialog();
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double slideMaxSize = MediaQuery.of(context).size.height;
    double slideMinSize = MediaQuery.of(context).size.height / 4;
    return (loading)
        ? LoadingScreen()
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
              key: UniqueKey(),
              backgroundColor: Colors.white,
              appBar: CustomAppBar(),
              body: SlidingUpPanel(
                panelBuilder: (ScrollController sc) => SlidingUpContent(
                  product: product,
                  scrollController: sc,
                ),
                maxHeight: slideMaxSize,
                minHeight: slideMinSize,
                backdropEnabled: true,
                collapsed: SlidingUpCollapsed(
                  product: product,
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ProductSlider(
                          controller: _controller,
                          product: product,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
