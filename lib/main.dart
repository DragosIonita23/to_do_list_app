import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:theme_provider/theme_provider.dart';

import 'Drawer/DrawerWidget.dart';
import 'Themes/Themes.dart';
import 'package:to_do_list_app/ToDoList/ToDoListWidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        themes: [
          Themes().LightTheme(),
          Themes().DarkTheme(),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              theme: ThemeProvider.themeOf(themeContext).data,
              title: 'Fire Food Delivery App',
              home: ToDoListWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
