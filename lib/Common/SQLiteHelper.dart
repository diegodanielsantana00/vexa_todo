// ignore_for_file: file_names, avoid_init_to_null, unused_local_variable, argument_type_not_assignable_to_error_handler, non_constant_identifier_names

import 'dart:io';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vexa_todo/Screens/AddTask/Models/Tags.dart';
import 'package:vexa_todo/Screens/AddTask/Models/TaskTags.dart';
import 'package:vexa_todo/Screens/Home/Models/Task.dart';
import 'package:vexa_todo/Screens/Home/Models/Type.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  DatabaseHelper._crateInstance();

  factory DatabaseHelper() => _databaseHelper ??= DatabaseHelper._crateInstance();

  Future<Database> get database async => _database ??= await initializeDatabase();

  Future<Database> initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = "${dir.path}kpxsknsdw_234S32.db";
    var exercisesDatabase = await openDatabase(path, version: 1, onCreate: _createDatabase);

    return exercisesDatabase;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE task(id INTEGER primary key autoincrement, text TEXT, title TEXT, color TEXT, priority INTEGER, date_create DATETIME, date_programmed DATETIME, notifications DATETIME, finish TEXT)");
    await db.execute("CREATE TABLE task_type(id INTEGER primary key autoincrement, id_task INTEGER, title TEXT, check_task TEXT );");
    await db.execute("CREATE TABLE tags(id INTEGER primary key autoincrement, icon TEXT, title TEXT, color TEXT);");
    await db.execute("CREATE TABLE task_tags(id INTEGER primary key autoincrement, id_task INTEGER, id_tag INTEGER);");
    await db.execute("CREATE TABLE version(id INTEGER primary key autoincrement, version TEXT);");

    await db.execute("INSERT INTO version (version) VALUES('${await GetVersion()}');");
  }

  Future<int> insertDatabase(String table, dynamic object, {Database? database2}) async {
    var result = null;
    if (database2 == null) {
      Database db = await database;
      result = db.insert(table, object.toMap());
    } else {
      result = database2.insert(table, object.toMap());
    }
    return result;
  }

  Future<void> executeStringLocal(String sql) async {
    Database db = await database;
    dynamic result;
    if (sql.toLowerCase().contains("delete")) {
      result = await db.rawDelete(sql);
    } else if (sql.toLowerCase().contains("insert")) {
      result = await db.rawInsert(sql);
    } else {
      await db.execute(sql);
    }
  }

  Future<List<Task>> getTask() async {
    Database db = await database;
    var result = await db.query("task");
    return result.isNotEmpty ? result.map((c) => Task.fromMap(c)).toList() : [];
  }

  Future<void> updateTypeCheck(String type, int id_type) async {
    Database db = await database;

    await db.rawUpdate('''
    UPDATE task_type 
    SET check_task = ?
    WHERE id = ?
    ''', [type, id_type]);
  }

  Future<void> updateTaskComplete(int id_type) async {
    Database db = await database;

    await db.rawUpdate('''
    UPDATE task 
    SET finish = ?
    WHERE id = ?
    ''', ["Y", id_type]);
  }

  Future<void> deleteTask(int id_task) async {
    Database db = await database;

    await db.rawUpdate('''
    DELETE FROM task 
    WHERE id = ?
    ''', [id_task]);

    await db.rawUpdate('''
    DELETE FROM task_type 
    WHERE id_task = ?
    ''', [id_task]);
  }

  Future<List<TypeTask>> getTaskType({int? id_task}) async {
    Database db = await database;
    var result = await db.query("task_type", where: "id_task = $id_task");
    return result.isNotEmpty ? result.map((c) => TypeTask.fromMap(c)).toList() : [];
  }

  Future<List<TaskTags>> getTaskTags({int? id_task}) async {
    Database db = await database;
    var result = await db.query("task_tags", where: "id_task = $id_task");
    return result.isNotEmpty ? result.map((c) => TaskTags.fromMap(c)).toList() : [];
  }

  Future<String> getLastVersion() async {
    Database db = await database;
    var result = await db.query("version");
    return result[result.length - 1]["version"].toString();
  }

  Future<List<Tags>> getTags() async {
    Database db = await database;
    var result = await db.query("tags");
    return result.isNotEmpty ? result.map((c) => Tags.fromMap(c)).toList() : [];
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
