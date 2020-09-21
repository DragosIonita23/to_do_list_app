import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HeartbeatProgressIndicator(
          child: Image.asset(
            'assets/Logo/toDoListLoadingLogo.png',
            height: 70,
            width: 70,
          ),
        ),
      ),
    );
  }

}