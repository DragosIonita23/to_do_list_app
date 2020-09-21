import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Drawer/DrawerWidget.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_app/Task/Task.dart';
import 'package:to_do_list_app/ToDoList/TaskWidget.dart';

import 'AddTaskPage.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List Application',
          style: ThemeProvider.themeOf(context).data.textTheme.headline5,
        ),
      ),
      body: _global.toDoList.isEmpty
          ? Container(
              child: Card(
                child: ListTile(
                  title: Text(
                    'You don\'t have any tasks to do right now',
                    style:
                        ThemeProvider.themeOf(context).data.textTheme.headline5,
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Task 1 demo',
                    style:
                        ThemeProvider.themeOf(context).data.textTheme.headline4,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TaskWidget(Task(1,'asdad','adsa','Important',false),),
                      ),
                    );
                  },
                );
              },
            ),
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddTaskPage(),
                  ),
                );
                // TO DO INSERT A ROW IN TASK TABLE SQLITE
              },
              icon: Icon(Icons.add_circle_outline),
              iconSize: 22,
            ),
          ],
        ),
      ),
    );
  }
}
