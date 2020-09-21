import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class Themes {
  AppTheme LightTheme() {
    return AppTheme(
      id: "light_theme",
      description: 'light app theme',
      data: ThemeData(
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          color: Colors.deepPurpleAccent,
        ),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        indicatorColor: Colors.white,
        primaryColor: Colors.deepPurpleAccent,
        accentColor: Colors.deepPurpleAccent,
        colorScheme: ColorScheme(
          primary: Colors.deepPurpleAccent,
          primaryVariant: Colors.deepPurpleAccent,
          onPrimary: Colors.white,
          onBackground: Colors.black,
          onError: Colors.black,
          secondary: Colors.deepPurpleAccent,
          secondaryVariant: Colors.deepPurpleAccent,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          brightness: Brightness.light,
          surface: Colors.white,
          background: Colors.white,
          error: Color(0xFFF44336),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          headline6: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          headline3: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          headline1: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          subtitle1: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          subtitle2: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          button: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AppTheme DarkTheme() {
    return AppTheme(
      id: "dark_theme",
      description: "dark app theme",
      data: ThemeData(
        fontFamily: 'Roboto',
        indicatorColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color(0xFF202020),
        ),
        primaryColor: Colors.deepPurpleAccent,
        accentColor: Colors.deepPurpleAccent,
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: Color(0xFF202020),
        colorScheme: ColorScheme(
          primary: Colors.deepPurple[900],
          primaryVariant: Colors.deepPurple[900],
          onPrimary: Colors.black,
          onBackground: Colors.black,
          onError: Colors.black,
          secondary: Colors.deepPurple[900],
          secondaryVariant: Colors.deepPurple[900],
          onSecondary: Colors.black,
          onSurface: Colors.white,
          brightness: Brightness.dark,
          surface: Color(0xFF121212),
          background: Color(0xFF121212),
          error: Color(0xFFF44336),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          headline6: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          headline3: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          headline1: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          subtitle1: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          subtitle2: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          button: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
