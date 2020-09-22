import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Themes/Themes.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: ThemeProvider.themeOf(context)
                .data
                .textTheme
                .headline5
                .fontFamily,
            fontWeight: ThemeProvider.themeOf(context)
                .data
                .textTheme
                .headline5
                .fontWeight,
            fontSize: ThemeProvider.themeOf(context)
                .data
                .textTheme
                .headline5
                .fontSize,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Change Theme',
                        style: ThemeProvider.themeOf(context)
                            .data
                            .textTheme
                            .headline3,
                      ),
                      trailing: RaisedButton(
                        child: Text(
                          ThemeProvider.themeOf(context).id == 'light_theme'
                              ? 'Dark'
                              : 'Light',
                          style: ThemeProvider.themeOf(context)
                              .data
                              .textTheme
                              .headline2,
                        ),
                        onPressed: () {
                          var themeId = ((ThemeProvider.themeOf(context).id ==
                              'light_theme')
                              ? 'dark_theme'
                              : 'light_theme');
                          ThemeProvider.controllerOf(context).setTheme(themeId);
                        },
                      ),
                    ),
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
