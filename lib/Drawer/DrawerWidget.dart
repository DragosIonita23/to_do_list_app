import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/CreateUserName/CreateUserNamePage.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/UserLoading.dart';
import 'package:to_do_list_app/Settings/SettingsPage.dart';
import 'package:to_do_list_app/ToDoList/ToDoListWidget.dart';

class DrawerWidget extends StatefulWidget {
  final toDoListPageState;

  const DrawerWidget(this.toDoListPageState, {Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState(toDoListPageState);
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Global _global = Global.getInstance();

  var toDoListPageState;

  _DrawerWidgetState(this.toDoListPageState);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Greetings, ' +
                    (Global.getInstance().userName == ""
                        ? "dear user"
                        : Global.getInstance().userName),
                style: TextStyle(
                    fontFamily: 'Lobster',
                    fontWeight:
                        Theme.of(context).textTheme.headline6.fontWeight,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline1.fontFamily,
                fontSize: Theme.of(context).textTheme.headline1.fontSize + 3,
                fontWeight: Theme.of(context).textTheme.headline1.fontWeight,
                color: Theme.of(context).textTheme.headline1.color,
              ),
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
              ).then((value) {
                if(mounted) setState(() {});
              });
            },
          ),
          ListTile(
            title: Text(
              'Delete all tasks',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline1.fontFamily,
                fontSize: Theme.of(context).textTheme.headline1.fontSize + 3,
                fontWeight: Theme.of(context).textTheme.headline1.fontWeight,
                color: Theme.of(context).textTheme.headline1.color,
              ),
            ),
            leading: Icon(
              Icons.delete_sweep,
            ),
            onTap: () async {
              showGeneralDialog(
                barrierDismissible: false,
                transitionDuration: Duration(milliseconds: 1),
                barrierColor: Colors.black12.withOpacity(0.9),
                context: context,
                pageBuilder: (a, b, c) => SizedBox.expand(
                  child: UserLoadingPage('Deleting all yours tasks ...'),
                ),
              );
              await _global.deleteAllTasks();
              Navigator.of(context).pop();
              if (mounted) {
                setState(() {
                  toDoListPageState.setState(() {});
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
