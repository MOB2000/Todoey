import 'package:sqflite/sqflite.dart';
import 'package:todoey/models/task.dart';

class DBHelper {
  static const String tableTodo = 'todo';
  static const String columnId = '_id';
  static const String columnTitle = 'title';
  static const String columnDone = 'isDone';
  static Database db;

  static Future<List<Task>> getData() async {
    var dbPath = await getDatabasesPath();
    dbPath += dbPath + '/tasks.db';

    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
                  create table $tableTodo (
                    $columnId integer primary key autoincrement,
                    $columnTitle text not null,
                    $columnDone integer not null)
                  ''');
      },
    );
    List<Map<String, dynamic>> records = await db.query(tableTodo);
    final tasks = records.map((e) => Task.fromMap(e)).toList();
    return tasks;
  }

  static void insert(Task newTask) {
    db.insert(
      tableTodo,
      newTask.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static void updateTask(Task task) {
    db.update(
      tableTodo,
      task.toMap(),
      where: '$columnId = ?',
      whereArgs: [task.id],
    );
  }

  static void deleteTask(int id) {
    db.delete(
      tableTodo,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
