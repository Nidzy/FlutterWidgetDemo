import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttercomponent_demo/database/model/user.dart';

//database utility class
class DatabaseHelper {
  static final DatabaseHelper _instance =
      new DatabaseHelper.internal(); // defining named generated constructor.

  factory DatabaseHelper() =>
      _instance; // factory keyword is use to create singleton instance. i.e one instance per class

  static Database _db;

  //Future is use to represent potential value, error that will be available at the same time in future.
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  //internal is just name to create
  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory =
        await getApplicationDocumentsDirectory(); // path to directory where the application may place the data
    String path = join(documentDirectory.path,
        "main.db"); // join => joins the given path with documentDirectory path ie: /path/main.db

    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    //when creating the db create the table
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, dob TEXT)");
  }

//save user
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<List<User>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM User'); // select all user from User table

    List<User> users = new List();

    //list of user
    for (int i = 0; i < list.length; i++) {
      var user =
          new User(list[i]["firstname"], list[i]["lastname"], list[i]["dob"]);
      user.setUserId(list[i]["id"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

//delete the user
  Future<int> deleteUsers(User user) async {
    var dbClient = await db;

    //delete perticular user id wise
    int res =
        await dbClient.rawDelete('DELETE FROM User WHERE id = ?', [user.id]);
    return res;
  }

//update the database
  Future<bool> update(User user) async {
    var dbClient = await db;
    int res = await dbClient.update("User", user.toMap(),
        where: "id= ?", whereArgs: <int>[user.id]);

    return res > 0 ? true : false;
  }
}
