import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/load.dart';
import 'package:oneaddress/Classes/Slider/CategoryTree.dart';
import 'package:oneaddress/Screens/LoadingScreen.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Services/Network_Cache_Management/CustomCacheManager.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Services/Management/Authentication.dart';
import 'package:oneaddress/Services/Management/CountryManagement.dart';
import 'package:oneaddress/Services/Management/ImageManagement.dart';
import 'package:oneaddress/Services/WebServices/CartListService.dart';
import 'Classes/CountryList/Country.dart';
import 'Components/CustomScaffoldComponent.dart';
import 'Screens/CategorySliderScreen.dart';
import 'Screens/SelectCountryScreen.dart';
import 'Services/WebServices/CategoryListService.dart';
import 'Utilities/RouteGenerator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  @override
  _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<MyApp> {
  //bool cacheIsCleared;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingProvider(
      themeData: LoadingThemeData(
        loadingBackgroundColor: Colors.transparent,
      ),
      loadingWidgetBuilder: (ctx, data) {
        return Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: Container(
              child: CupertinoActivityIndicator(),
              color: Colors.white,
            ),
          ),
        );
      },
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          textSelectionHandleColor: Color.fromRGBO(66, 103, 178, 1),
          textSelectionColor: Color.fromRGBO(66, 103, 178, 1),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}

/*void main() {
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
    ),
  );
}*/

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StatefulWidget> {
  bool loading = true;
  bool displayCountryList = false;
  CategoryTree categoryTree;
  @override
  void initState() {
    getInitData();
    super.initState();
  }

  void getInitData() async {
    //SharedPref sharedPref = SharedPref();
    //await sharedPref.clear();
    //await CustomCacheManager().emptyCache();
    await LanguageManagement.checkLang();
    await ImageManagement.getImageFileFromAssets();
    //check Authentication
    await Authentication.checkAuth();
    await CartListService().updateCartProductsNum();
    //get country
    displayCountryList = await checkCountryInfo();
    if (!displayCountryList) {
      Country country = CountryManagement.countryData();
      await CategoryListService.getCategoryInfo(country.id);
      var categoryData = CategoryListService.getCategories();
      categoryTree = CategoryTree(tree: categoryData);
    }

    if (this.mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<bool> checkCountryInfo() async {
    await CountryManagement.checkCountry();
    Country country = CountryManagement.countryData();
    return (country == null);
  }

  Future<bool> _onBackPressed() async {
    bool res = Navigator.canPop(context);
    if (!res) {
      showLoadingDialog();
      SharedPref sharedPref = SharedPref();
      await sharedPref.clear();
      await CustomCacheManager().emptyCache();
      hideLoadingDialog();
      SystemNavigator.pop();
    }
    return false;
  }

  getCountryCallback(Country country) async {
    showLoadingDialog();
    if (CategoryListService.getCategories() == null) {
      await CategoryListService.getCategoryInfo(country.id);
    }
    var categoryData = CategoryListService.getCategories();
    categoryTree = CategoryTree(tree: categoryData);
    SharedPref sharedPref = SharedPref();
    await sharedPref.saveCountryInfo(country);
    CountryManagement.updateCountry(country);
    setState(() {
      displayCountryList = false;
    });
    hideLoadingDialog();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? LoadingScreen()
        : ((displayCountryList)
            ? SelectCountryScreen(
                countryCallback: getCountryCallback,
              )
            : WillPopScope(
                onWillPop: _onBackPressed,
                child: CustomScaffoldComponent(
                  hasBottomNavbar: true,
                  child: CategorySliderScreen(
                    categoryTree: categoryTree,
                  ),
                ),
              ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
