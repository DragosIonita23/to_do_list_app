import 'package:flutter/cupertino.dart';
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
        if (snapshot.connectionState == ConnectionState.done) {
          return _global.userName != null ? ToDoListWidget() : CreateUserNamePage();
        }
        return LoadingPage();
      },
    );
  }

}
