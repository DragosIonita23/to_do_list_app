import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sqflite/sqflite.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/UserLoading.dart';
import 'package:to_do_list_app/Task/Task.dart';
import 'package:to_do_list_app/ToDoList/ToDoListWidget.dart';

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
      body: Column(
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
                    ThemeProvider.themeOf(context).data.textTheme.headline2,
                cursorColor: Colors.black,
                key: titleKey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  labelText: 'Task title',
                ),
                validator: (String value) {
                  if (_global.nameValidator.hasMatch(value) &&
                      value.isNotEmpty &&
                      value.length <= 25) {
                    title = value;
                    return null;
                  } else {
                    return 'Invalid Title\n.Maximum 80 alpha-numeric characters allowed.';
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
                    ThemeProvider.themeOf(context).data.textTheme.headline2,
                cursorColor: Colors.black,
                key: descriptionKey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  labelText: 'Description of the task',
                ),
                validator: (String value) {
                  if (_global.nameValidator.hasMatch(value) &&
                      value.isNotEmpty &&
                      value.length <= 80) {
                    description = value;
                    return null;
                  } else {
                    return 'Invalid description.\nMaximum 80 alpha-numeric characters allowed.';
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
                  ThemeProvider.themeOf(context).data.textTheme.headline3,
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
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: FlatButton(
            child: Text(
              'Add task',
              style: ThemeProvider.themeOf(context).data.textTheme.headline3,
            ),
            onPressed: () {
              if (titleKey.currentState.validate() &&
                  descriptionKey.currentState.validate()) {
                if (category == "") {
                  showSnackBar(
                      _scaffoldKey, 'Choose a category');
                } else {
                  // TO DO SQLITE INSERT ROW IN TASKS TABLE
                  var index = _global.lastIndex + 1;
                  return FutureBuilder(
                    future: insertTask(Task(index, title, description, category, 0)),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return UserLoadingPage('Adding your new task ...');
                      } else {
                        _global.toDoList.add(
                          Task(index, title, description, category, 0),
                        );
                        Navigator.of(context).pop();
                        return ThemeConsumer(child: ToDoListWidget(),);
                      }
                    },
                  );
                }
              } else {
                showSnackBar(_scaffoldKey,
                    'Validation error.');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Task> insertTask(Task task) async {
    await _global.database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return task;
  }

  void showSnackBar(_scaffoldKey, message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
        height: 50,
        child: FadingText(
          message,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
