import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/About/BranchList.dart';
import 'package:oneaddress/Components/About/BranchGroupComponent.dart';
import 'package:oneaddress/Services/Management/CountryManagement.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';
import 'package:oneaddress/Utilities/CustomAppBar.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  BranchList branchList;
  ScrollController _controller;

  @override
  void initState() {
    if (LanguageManagement.isEnglish()) {
      branchList = BranchList.english();
    } else {
      branchList = BranchList.arabic();
    }

    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: _sizedContainerAboutUs(
                          Image(
                            image: AssetImage('images/OneAddress'
                                '.jpg'),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 30.0,
                        ),
                        child: Text(
                          "contact us",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                      ),
                      (CountryManagement.isSyria())
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 10.0,
                                    top: 30.0,
                                  ),
                                  child: Text(
                                    "phone".tr() + " : +963 933222109",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 10.0,
                                    top: 30.0,
                                  ),
                                  child: Text(
                                    "email".tr() +
                                        ": contact@oneaddress.fashion",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 10.0,
                                    top: 30.0,
                                  ),
                                  child: Text(
                                    "phone".tr() + " : +971 50 474 212 5",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 10.0,
                                    top: 30.0,
                                  ),
                                  child: Text(
                                    "email".tr() +
                                        ": support.dubai@oneaddress.fashion",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 30.0,
                          bottom: 20.0,
                        ),
                        child: Text(
                          "branches".tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    controller: _controller,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _controller,
                      itemCount: branchList.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BranchGroupComponent(
                          branchInfo: branchList.values[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sizedContainerAboutUs(Widget child) => SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        height: 100.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            right: 10.0,
            bottom: 10.0,
            left: 10.0,
          ),
          child: Center(child: child),
        ),
      );
}
