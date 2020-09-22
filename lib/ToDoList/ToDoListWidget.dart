import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Drawer/DrawerWidget.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/UserLoading.dart';
import 'package:to_do_list_app/Task/Task.dart';
import 'package:to_do_list_app/ToDoList/TaskWidget.dart';
import 'AddTaskPage.dart';
import 'UpdateTaskWidget.dart';

class ToDoListWidget extends StatefulWidget {
  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  Global _global;

  List<Task> filteredList;

  String categoryString = "";

  @override
  void initState() {
    _global = Global.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filteredList = createFilteredList(_global.toDoList, categoryString);
    filteredList.sort((task1, task2) {
      return task2.id - task1.id;
    });
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Your To Do List',
          style: ThemeProvider.themeOf(context).data.textTheme.headline5,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredList.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: CheckboxListTile(
                value: filteredList[i].done == 1 ? true : false,
                onChanged: (value) async {
                  return FutureBuilder(
                    future: _global.database.update(
                      'tasks',
                      filteredList[i].toMap(),
                      where: "id = ?",
                      whereArgs: [filteredList[i].id],
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return this.build(context);
                      } else {
                        return ((filteredList[i].done == 1)
                            ? UserLoadingPage('Marking the task as done...')
                            : UserLoadingPage(
                                'Marking the task as \'to do\'...'));
                      }
                    },
                  );
                },
                title: Card(
                  color: ThemeProvider.controllerOf(context).theme.id ==
                          'light_theme'
                      ? (filteredList[i].done == 1
                          ? Colors.white24
                          : Colors.white)
                      : (filteredList[i].done == 1 ? Colors.red : Colors.black),
                  child: ListTile(
                    title: Text(
                      filteredList[i].title,
                      style: TextStyle(
                        color: ThemeProvider.themeOf(context)
                            .data
                            .textTheme
                            .headline4
                            .color,
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
                        decoration: ((filteredList[i].done == 1)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return ThemeConsumer(
                              child: UpdateTaskWidget(filteredList[i]),
                            );
                          }),
                        ).then((value) {
                          if (mounted) setState(() {});
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return ThemeConsumer(
                            child: TaskWidget(filteredList[i]),
                          );
                        }),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                shadowColor: categoryString == 'Normal' ? Colors.deepPurpleAccent : Colors.transparent,
                borderOnForeground: false,
                child: FlatButton(
                  child: Text(
                    'Normal',
                    style: TextStyle(
                      fontFamily: ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontFamily,
                      color: ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .color,
                      fontSize: categoryString == 'Normal'
                          ? ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontSize
                          : ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontSize,
                      fontWeight: categoryString == 'Normal'
                          ? ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontWeight
                          : ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontWeight,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (categoryString == 'Normal') {
                        categoryString = "";
                      } else {
                        categoryString = 'Normal';
                      }
                      setState(() {});
                    });
                  },
                ),
              ),
              Card(
                borderOnForeground: false,
                shadowColor: categoryString == 'Important' ? Colors.deepPurpleAccent : Colors.transparent,
                child: FlatButton(
                  child: Text(
                    'Important',
                    style: TextStyle(
                      fontFamily: ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontFamily,
                      color: ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .color,
                      fontSize: categoryString == 'Important'
                          ? ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontSize
                          : ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontSize,
                      fontWeight: categoryString == 'Important'
                          ? ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontWeight
                          : ThemeProvider.themeOf(context)
                          .data
                          .textTheme
                          .headline3
                          .fontWeight,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (categoryString == 'Important') {
                        categoryString = "";
                      } else {
                        categoryString = 'Important';
                      }
                      setState(() {});
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                iconSize: 45,
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ThemeConsumer(
                          child: AddTaskPage(),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Task> createFilteredList(List<Task> toDoList, String categoryString) {
    if (toDoList == null || toDoList.length == 0) return List<Task>();
    List<Task> list = List<Task>();
    if (categoryString == "") {
      return List.from(_global.toDoList);
    }
    for (int i = 0; i < toDoList.length; i++) {
      if (toDoList[i].category == categoryString) {
        list.add(toDoList[i]);
      }
    }
    return list;
  }
}
