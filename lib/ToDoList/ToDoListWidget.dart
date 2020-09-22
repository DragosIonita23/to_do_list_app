import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Drawer/DrawerWidget.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_app/Loading/LoadingPage.dart';
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

  @override
  void initState() {
    _global = Global.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _global.toDoList.sort((task1, task2) {
      return task2.id - task1.id;
    });
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _global.toDoList.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                title: Text(
                  _global.toDoList[i].title,
                  style: ThemeProvider.themeOf(context).data.textTheme.headline4,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdateTaskWidget(_global.toDoList[i]);
                        }
                      ),
                    ).then((value) {
                      setState(() { });
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(

      ),
    );
  }
}
