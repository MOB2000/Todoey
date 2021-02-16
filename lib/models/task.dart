import 'package:flutter/foundation.dart';
import 'package:todoey/helpers/db_helper.dart';

class Task {
  int id;
  String title;
  bool isDone;

  Task({
    this.id,
    @required this.title,
    this.isDone = false,
  });

  Task.fromMap(Map<String, dynamic> map) {
    id = map[DBHelper.columnId];
    title = map[DBHelper.columnTitle];
    isDone = map[DBHelper.columnDone] == 1;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DBHelper.columnTitle: title,
      DBHelper.columnDone: isDone == true ? 1 : 0
    };
    if (id != null) {
      map[DBHelper.columnId] = id;
    }
    return map;
  }

  void toggleDone() {
    isDone = !isDone;
  }
}
