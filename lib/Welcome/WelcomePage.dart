import 'package:flutter/cupertino.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/CreateUserName/CreateUserNamePage.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/LoadingPage.dart';
import 'package:to_do_list_app/ToDoList/ToDoListWidget.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Global _global;

  @override
  void initState() {
    _global = Global.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _global.loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (_global.userName != null && _global.userName != "")
              ? ThemeConsumer(
                  child: ToDoListWidget(), // ASTA E OK
                )
              : ThemeConsumer(
                  child: CreateUserNamePage(),
                );
        } else {
          return LoadingPage();
        }
      },
    );
  }
}
