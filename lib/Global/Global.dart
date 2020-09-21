import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:to_do_list_app/Task/Task.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// singleton, used for loading data
class Global {
  static Global _global = Global._Global();

  static Global getInstance() {
    if (_global == null) return Global._Global();
    return _global;
  }

  RegExp nameValidator = RegExp(r'^[a-zA-ZăĂâÂîÎțȚșȘ]+$');

  String userName; // load-uit din SQLite sau cerut in loading screen (daca e null)

  List<Task> toDoList = List<Task>();

  // ignore: non_constant_identifier_names
  Global._Global();
}