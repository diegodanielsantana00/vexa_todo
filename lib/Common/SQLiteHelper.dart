// ignore_for_file: file_names

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
    // await Structure().RunTableSQLite(db);
    await db.execute("CREATE TABLE task(id INTEGER primary key autoincrement, text TEXT, priority INTEGER, date_create DATETIME, date_programmed DATETIME, notifications DATETIME [], type TEXT [], tags INTEGER [])");
    await db.execute("CREATE TABLE tags(id INTEGER primary key autoincrement, icon TEXT, title TEXT);");
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

  // Future<User> getUserSQLite() async {
  //   Database db = await database;
  //   var result = await db.query("user");
  //   List<User> list = result.isNotEmpty ? result.map((c) => User.fromMapLocal(c)).toList() : [];
  //   if (list.isNotEmpty) {
  //     return list[0];
  //   } else {
  //     return User(0, "", "", "", "", 0, "", "", "", "");
  //   }
  // }

  Future<String> getCVV(String cardID) async {
    Database db = await database;
    var result = await db.query("card", where: "cardid = '$cardID'");

    if (result.length > 0) {
      return result[0]['cvv'].toString();
    } else {
      return "";
    }
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
