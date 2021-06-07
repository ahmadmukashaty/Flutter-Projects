import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreenHome extends StatefulWidget {
  @override
  _LoadingScreenHomeState createState() => _LoadingScreenHomeState();
}

class _LoadingScreenHomeState extends State<LoadingScreenHome> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
