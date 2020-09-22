import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:theme_provider/theme_provider.dart';

import 'Drawer/DrawerWidget.dart';
import 'Themes/Themes.dart';
import 'package:to_do_list_app/ToDoList/ToDoListWidget.dart';

import 'Welcome/WelcomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
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
            title: 'To Do Flutter App',
            home: WelcomePage(),
          ),
        ),
      ),
    );
  }
}
