import 'package:sqflite/sqflite.dart';

import '../../../models/task_model.dart';

class SqlServices {
  static List<TaskModel> tasks = [];
  Future<Database> initDb() async {
    var db = await openDatabase('Todo.db', version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute(
            'CREATE TABLE Tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT NOT NULL,time TEXT NOT NULL,date TEXT NOT NULL,status TEXT NOT NULL)')
        .then((value) {
      print('🎉 table created');
    });
  }

  void insertToDataBas({
    required title,
    required time,
    required date,
  }) async {
    final Database db = await initDb();
    await db.transaction(
      (txn) async {
        return txn
            .rawInsert(
                'INSERT INTO Tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
            .then((value) {
          print('🎉 insert table');
          getDate();
        }).catchError((erorr) {
          print('🚨 error when insert table${erorr.toString()}');
        });
      },
    );
  }

  Future getDate() async {
    final Database db = await initDb();
    return await db.rawQuery('SELECT * FROM Tasks').then((value) {
      tasks.clear();
      for (var element in value) {
        tasks.add(TaskModel.fromJson(element));
      }
      print("🚨 tasks length ${tasks.length}");
      return tasks;
    });
  }
}
