import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:to_do_list_app/Task/Task.dart';
import 'package:path/path.dart';
import 'package:to_do_list_app/User/User.dart';

// singleton, used for loading data
class Global {
  static Global _global = Global._Global();

  static Global getInstance() {
    if (_global == null) return Global._Global();
    return _global;
  }

  RegExp nameValidator = RegExp(r'^[a-zA-ZăĂâÂîÎțȚșȘ]+$');

  String
      userName; // load-uit din SQLite sau cerut in loading screen (daca e null)

  List<Task> toDoList = List<Task>();

  String databaseName = 'to_do_list.db';

  Database _database;

  int lastIndex = 0;

  int userID = 1;

  Database get database => _database;

  // ignore: non_constant_identifier_names
  Global._Global();

  // int id;
  // String title;
  // String description;
  // String category; // 2 categories for importance hierarchy
  // int done; // 0 for false, 1 for true

  Future<void> loadData() async {
    await createTables();
    await readTables();
  }


  Future<void> createTables() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, done INTEGER)",
        );
        await database.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)"
        );
      },
      version: 1,
    );

  }

  Future<void> readTables() async {
    List<Map<String, dynamic>> usersMaps = await _database.query('users');
    List<Map<String, dynamic>> tasksMaps = await _database.query('tasks');
    List<User> usersList = List.generate(usersMaps.length, (i) {
      return User(
        usersMaps[i]['id'],
        usersMaps[i]['name'],
      );
    });
    List<Task> tasksList = List.generate(tasksMaps.length, (i) {
      return Task(
        tasksMaps[i]['id'],
        tasksMaps[i]['title'],
        tasksMaps[i]['description'],
        tasksMaps[i]['category'],
        tasksMaps[i]['done'],
      );
    });
    userName = usersList[0].name;
    toDoList = List.from(tasksList);
    lastIndex = getLastIndexFromList(toDoList);
    print("@@@@@ TO DO LIST = " + toDoList.toString());
    print("@@@@@@@@ USERNAME = " + userName);
  }

  int getLastIndexFromList(List<Task> toDoList) {
    int max = 0;
    for (int i = 0; i < toDoList.length; i++) {
      if (toDoList[i].id > max) max = toDoList[i].id;
    }
    return max;
  }
}
