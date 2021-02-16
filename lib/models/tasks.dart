import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todoey/helpers/db_helper.dart';

import './task.dart';

class Tasks extends ChangeNotifier {
  List<Task> _tasks = [];

  Future<void> getDataFromDB() async {
    _tasks = await DBHelper.getData();
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get tasksCount => _tasks.length;
  bool get isEmpty => tasksCount == 0;

  void addTask(String newTaskTitle) {
    final newTask = Task(title: newTaskTitle);
    _tasks.add(newTask);
    DBHelper.insert(newTask);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    DBHelper.updateTask(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    DBHelper.deleteTask(task.id);
    notifyListeners();
  }
}
