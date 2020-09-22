import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/UserLoading.dart';
import 'package:to_do_list_app/Task/Task.dart';

class UpdateTaskWidget extends StatefulWidget {
  final Task task;

  const UpdateTaskWidget(this.task, {Key key}) : super(key: key);

  @override
  _UpdateTaskWidgetState createState() => _UpdateTaskWidgetState(task);
}

class _UpdateTaskWidgetState extends State<UpdateTaskWidget> {
  _UpdateTaskWidgetState(this.task);

  Task task;

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Update this task',
            style: TextStyle(
              color: Colors.white,
              fontSize: ThemeProvider.themeOf(context).data.textTheme.headline5.fontSize,
              fontWeight: ThemeProvider.themeOf(context).data.textTheme.headline5.fontWeight,
              fontFamily: ThemeProvider.themeOf(context).data.textTheme.headline5.fontFamily,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                // title
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          ThemeProvider.themeOf(context).id == 'light_theme'
                              ? Colors.black
                              : Colors.white54,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: task.title,
                    style: ThemeProvider.themeOf(context)
                        .data
                        .textTheme
                        .subtitle2,
                    cursorColor: Colors.black,
                    key: titleKey,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      labelText: 'Task title',
                      labelStyle: TextStyle(
                        color: ThemeProvider.themeOf(context).id == 'light_theme' ? Colors.black : Colors.white,
                        fontSize: ThemeProvider.themeOf(context).data.textTheme.headline4.fontSize,
                        fontWeight: ThemeProvider.themeOf(context).data.textTheme.headline4.fontWeight,
                        fontFamily: ThemeProvider.themeOf(context).data.textTheme.headline4.fontFamily,
                      ),
                    ),
                    validator: (String value) {
                      if (_global.nameValidator.hasMatch(value) &&
                          value.isNotEmpty &&
                          value.length <= 25) {
                        task.title = value;
                        return null;
                      } else {
                        return 'Invalid Title\n.Maximum 80 alpha-numeric characters allowed.';
                      }
                    },
                    onFieldSubmitted: (String value) {
                      if (titleKey.currentState.validate()) {
                        task.title = value;
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
                      color:
                          ThemeProvider.themeOf(context).id == 'light_theme'
                              ? Colors.black
                              : Colors.white54,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: task.description,
                    style: ThemeProvider.themeOf(context)
                        .data
                        .textTheme
                        .subtitle2,
                    cursorColor: Colors.black,
                    key: descriptionKey,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      labelText: 'Description of the task',
                      labelStyle: TextStyle(
                        color: ThemeProvider.themeOf(context).id == 'light_theme' ? Colors.black : Colors.white,
                        fontSize: ThemeProvider.themeOf(context).data.textTheme.headline4.fontSize,
                        fontWeight: ThemeProvider.themeOf(context).data.textTheme.headline4.fontWeight,
                        fontFamily: ThemeProvider.themeOf(context).data.textTheme.headline4.fontFamily,
                      ),
                    ),
                    validator: (String value) {
                      if (_global.nameValidator.hasMatch(value) &&
                          value.isNotEmpty &&
                          value.length <= 80) {
                        task.description = value;
                        return null;
                      } else {
                        return 'Invalid description.\nMaximum 80 alpha-numeric characters allowed.';
                      }
                    },
                    onFieldSubmitted: (String value) {
                      if (descriptionKey.currentState.validate()) {
                        task.description = value;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Category: ' + task.category,
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).id == 'light_theme' ? Colors.black : Colors.white,
                    fontFamily: 'Lobster',
                    fontSize: ThemeProvider.themeOf(context).data.textTheme.headline4.fontSize + 5,
                    fontWeight: ThemeProvider.themeOf(context).data.textTheme.headline4.fontWeight,
                  ),
                ),
              ),
              FlatButton(
                color: Colors.deepPurpleAccent,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FlatButton(
                                color: Colors.deepPurpleAccent,
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
                                    task.category = 'Normal';
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                color: Colors.deepPurpleAccent,
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
                                    task.category = 'Important';
                                  });
                                  Navigator.of(context).pop();
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
        bottomNavigationBar: BottomAppBar(
          color: Colors.deepPurpleAccent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                child: Text(
                  'Update this task',
                  style:
                      ThemeProvider.themeOf(context).data.textTheme.headline5,
                ),
                onPressed: () async {
                  if (titleKey.currentState.validate() &&
                      descriptionKey.currentState.validate()) {
                    if (task.category == "") {
                      showSnackBar(_scaffoldKey,
                          'Please choose a category for your task');
                    } else {
                      // updates the database and the local list in global
                      showGeneralDialog(
                        barrierDismissible: false,
                        transitionDuration: Duration(milliseconds: 1),
                        barrierColor: Colors.black12.withOpacity(0.9),
                        context: context,
                        pageBuilder: (a, b, c) => SizedBox.expand(
                          child: UserLoadingPage('Adding your new task ...'),
                        ),
                      );
                      await updateTask(task);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  } else {
                    showSnackBar(_scaffoldKey,
                        'The title and the description must be validated.');
                  }
                },
              ),
              FlatButton(
                child: Text(
                  'Delete this task',
                  style:
                      ThemeProvider.themeOf(context).data.textTheme.headline5,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Are you sure you want to DELETE this task?',
                          style: TextStyle(
                            fontSize: ThemeProvider.themeOf(context)
                                .data
                                .textTheme
                                .headline4
                                .fontSize,
                            fontWeight: ThemeProvider.themeOf(context)
                                .data
                                .textTheme
                                .headline4
                                .fontWeight,
                            fontFamily: ThemeProvider.themeOf(context)
                                .data
                                .textTheme
                                .headline4
                                .fontFamily,
                            color:
                                ThemeProvider.controllerOf(context).theme.id ==
                                        'light_theme'
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              showGeneralDialog(
                                barrierDismissible: false,
                                transitionDuration: Duration(milliseconds: 1),
                                context: context,
                                pageBuilder: (a, b, c) => SizedBox.expand(
                                  child: UserLoadingPage(
                                      'Deleting your task ...'),
                                ),
                              );
                              await _global.database.delete(
                                'tasks',
                                where: "id = ?",
                                whereArgs: [task.id],
                              );
                              await Future.delayed(Duration(seconds: 3));
                              _global.toDoList.removeWhere((element) {
                                return element.id == task.id;
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (context) => WillPopScope(
                                  onWillPop: () => Future.value(false),
                                  child: AlertDialog(
                                    title: Text(
                                      'Task has been deleted!',
                                      style: TextStyle(
                                        fontSize: ThemeProvider.themeOf(context)
                                            .data
                                            .textTheme
                                            .headline4
                                            .fontSize,
                                        fontWeight:
                                            ThemeProvider.themeOf(context)
                                                .data
                                                .textTheme
                                                .headline4
                                                .fontWeight,
                                        fontFamily:
                                            ThemeProvider.themeOf(context)
                                                .data
                                                .textTheme
                                                .headline4
                                                .fontFamily,
                                        color:
                                            ThemeProvider.controllerOf(context)
                                                        .theme
                                                        .id ==
                                                    'light_theme'
                                                ? Colors.black
                                                : Colors.white,
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text(
                                          'OK',
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'OK',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(_scaffoldKey, message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
        color: Colors.deepPurpleAccent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

  Future<Task> updateTask(Task task) async {
    await _global.database.update(
      'tasks',
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
    for (int i = 0; i < _global.toDoList.length; i++) {
      if (_global.toDoList[i].id == task.id) {
        _global.toDoList[i] = Task(
            task.id, task.title, task.description, task.category, task.done);
        break;
      }
    }
    return task;
  }
}
