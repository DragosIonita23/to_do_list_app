import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class User {

  int id; // id-ul functioneaza ca un timestamp. incepe de la 1
          // si mereu se va incrementa, pentru pastrarea ordinii relative
  String name;

  User(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

}