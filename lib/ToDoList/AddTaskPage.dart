import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Task/Task.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String category = "";
  String title, description;

  Global _global;

  final GlobalKey<FormFieldState> titleKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> descriptionKey = GlobalKey<FormFieldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _global = Global.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add a new task',
          style: ThemeProvider.themeOf(context).data.textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                // title
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeProvider.themeOf(context).id == 'light_theme'
                          ? Colors.black
                          : Colors.white54,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: "",
                    style:
                        ThemeProvider.themeOf(context).data.textTheme.subtitle2,
                    cursorColor: Colors.black,
                    key: titleKey,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      labelText: 'Task title',
                    ),
                    validator: (String value) {
                      if (_global.nameValidator.hasMatch(value) &&
                          value.isNotEmpty) {
                        title = value;
                        return null;
                      } else {
                        return 'Invalid Title for the Task';
                      }
                    },
                    onFieldSubmitted: (String value) {
                      if (titleKey.currentState.validate()) {
                        title = value;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                // description
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeProvider.themeOf(context).id == 'light_theme'
                          ? Colors.black
                          : Colors.white54,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: "",
                    style:
                        ThemeProvider.themeOf(context).data.textTheme.subtitle2,
                    cursorColor: Colors.black,
                    key: descriptionKey,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      labelText: 'Description of the task',
                    ),
                    validator: (String value) {
                      if (_global.nameValidator.hasMatch(value) &&
                          value.isNotEmpty) {
                        description = value;
                        return null;
                      } else {
                        return 'Invalid description of the task';
                      }
                    },
                    onFieldSubmitted: (String value) {
                      if (descriptionKey.currentState.validate()) {
                        description = value;
                      }
                    },
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  'Show categories',
                  style:
                      ThemeProvider.themeOf(context).data.textTheme.headline4,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                child: Text(
                                  'Normal',
                                  style: TextStyle(
                                    color: ThemeProvider.controllerOf(context)
                                                .theme
                                                .id ==
                                            'light_theme'
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: ThemeProvider.themeOf(context)
                                        .data
                                        .textTheme
                                        .headline3
                                        .fontSize,
                                    fontFamily: ThemeProvider.themeOf(context)
                                        .data
                                        .textTheme
                                        .headline3
                                        .fontFamily,
                                    fontWeight: ThemeProvider.themeOf(context)
                                        .data
                                        .textTheme
                                        .headline3
                                        .fontWeight,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    category = 'Normal';
                                  });
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  'Important',
                                  style: TextStyle(
                                    color: ThemeProvider.controllerOf(context)
                                                .theme
                                                .id ==
                                            'light_theme'
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: ThemeProvider.themeOf(context)
                                        .data
                                        .textTheme
                                        .headline3
                                        .fontSize,
                                    fontFamily: ThemeProvider.themeOf(context)
                                        .data
                                        .textTheme
                                        .headline3
                                        .fontFamily,
                                    fontWeight: ThemeProvider.themeOf(context)
                                        .data
                                        .textTheme
                                        .headline3
                                        .fontWeight,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    category = 'Important';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: FlatButton(
            child: Text(
              'Add task',
              style: ThemeProvider.themeOf(context).data.textTheme.headline4,
            ),
            onPressed: () {
              if (titleKey.currentState.validate() &&
                  descriptionKey.currentState.validate()) {
                if (category == "") {
                  showErrorSnackBar(_scaffoldKey);
                } else {
                  // TO DO SQLITE INSERT ROW IN TASKS TABLE
                  var index = _global.toDoList.length + 1;
                  _global.toDoList.add(
                    Task(index, title, description, category, false),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }

  void showErrorSnackBar(_scaffoldKey) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
        color: Colors.deepPurpleAccent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadingText(
              'Please choose a category for your task',
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
