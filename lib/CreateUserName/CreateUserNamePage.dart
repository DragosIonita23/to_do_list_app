import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sqflite/sqflite.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/UserLoading.dart';
import 'package:to_do_list_app/ToDoList/ToDoListWidget.dart';
import 'package:to_do_list_app/User/User.dart';

class CreateUserNamePage extends StatefulWidget {
  @override
  _CreateUserNamePageState createState() => _CreateUserNamePageState();
}

class _CreateUserNamePageState extends State<CreateUserNamePage> {
  String userName;

  Global _global;

  final GlobalKey<FormFieldState> userNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _global = Global.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'To Do App',
            style: ThemeProvider.themeOf(context).data.textTheme.headline5,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/userNamePage.png',
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FadingText(
                      'Welcome, ' +
                          (_global.userName != ""
                              ? _global.userName
                              : "dear user"),
                      style: TextStyle(
                        fontWeight: ThemeProvider.themeOf(context)
                            .data
                            .textTheme
                            .headline2
                            .fontWeight,
                        fontSize: ThemeProvider.themeOf(context)
                                .data
                                .textTheme
                                .headline3
                                .fontSize +
                            15,
                        fontFamily: 'Lobster',
                        color: ThemeProvider.themeOf(context)
                            .data
                            .textTheme
                            .headline3
                            .color,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeProvider.themeOf(context).id == 'light_theme'
                          ? Colors.black
                          : Colors.white54,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: _global.userName ?? "",
                    style:
                        ThemeProvider.themeOf(context).data.textTheme.headline1,
                    cursorColor: Colors.black,
                    key: userNameKey,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      labelText: 'What\'s your name?',
                      labelStyle: ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline1,
                    ),
                    validator: (String value) {
                      if (_global.nameValidator.hasMatch(value) &&
                          value.isNotEmpty &&
                          value.length <= 25) {
                        userName = value;
                        return null;
                      } else {
                        if (value.isNotEmpty)
                          return 'Maximum 25 alpha-numeric characters allowed.';
                        return "";
                      }
                    },
                    onFieldSubmitted: (String value) {
                      if (userNameKey.currentState.validate()) {
                        userName = value;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.deepPurpleAccent,
          child: FlatButton(
            child: Text(
              'Create User Name',
              style: ThemeProvider.themeOf(context).data.textTheme.headline2,
            ),
            onPressed: () async {
              if (userNameKey.currentState.validate()) {
                showGeneralDialog(
                  barrierDismissible: false,
                  transitionDuration: Duration(milliseconds: 1),
                  barrierColor: Colors.black12.withOpacity(0.9),
                  context: context,
                  pageBuilder: (a, b, c) => SizedBox.expand(
                    child: UserLoadingPage('Creating user ...'),
                  ),
                );
                await createUser(User(_global.userID, userName));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ThemeConsumer(
                        child: ToDoListWidget(),
                      );
                    },
                  ),
                );
              } else {
                showSnackBar(_scaffoldKey, 'Username must be validated');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<User> createUser(User user) async {
    final Database db = _global.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  void showSnackBar(_scaffoldKey, message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
        color: Colors.deepPurpleAccent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FadingText(
              message,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
