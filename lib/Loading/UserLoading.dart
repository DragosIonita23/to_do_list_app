import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:theme_provider/theme_provider.dart';

class UserLoadingPage extends StatefulWidget {
  final String title;

  const UserLoadingPage(this.title, {Key key}) : super(key: key);

  @override
  _UserLoadingPageState createState() => _UserLoadingPageState(title);
}

class _UserLoadingPageState extends State<UserLoadingPage> {

  _UserLoadingPageState(this.title);

  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadingText(
          title,
          style: ThemeProvider.themeOf(context).data.textTheme.headline3,
        ),
      ),
    );
  }

}
