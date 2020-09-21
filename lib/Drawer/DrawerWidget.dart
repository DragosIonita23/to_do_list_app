import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Settings/SettingsPage.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Greetings, ' + Global.getInstance().userName,
                style: TextStyle(
                    fontFamily: 'Lobster',
                    fontWeight:
                        Theme.of(context).textTheme.headline6.fontWeight,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    color: Theme.of(context).textTheme.headline6.color),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline1,
            ),
            leading: Icon(
              Icons.settings,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ThemeConsumer(child: SettingsPage());
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
