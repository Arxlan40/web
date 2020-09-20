import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webviewproject/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  /// -----------------------------------------
  /// Initstate and timer for splash screen
  /// -----------------------------------------

  void initState() {
    super.initState();
        startTimer();

     }

  void startTimer() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(

    body: Container(
          height: _height / 1.1365,
      width: _width,
      child: Image.asset(
            'assets/splash.png',
          ),
        ));
  }
}

