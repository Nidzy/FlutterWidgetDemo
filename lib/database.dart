import 'package:fluttercomponent_demo/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  static Database _database;

  //it will initialise the darabase
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String directoryPath = join(documentsDirectory.path, "ToDoList.db");
    return await openDatabase(directoryPath, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE todo (id INTEGER PRIMARY KEY, first_name TEXT, number TEXT, address TEXT, email TEXT, city TEXT)");
      await db.execute("CREATE TABLE USER (id INTEGER PRIMARY KEY, name TEXT)");
    });
  }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE User ("
        "id INTEGER PRIMARY KEY,"
        "first_name TEXT,"
        "number TEXT,"
        "address TEXT,"
        "email TEXT"
        "city TEXT"
        ")");
  }

//first approach using insert method
  Future<int> createUser(User user, Database database) async {
    var result = await database.insert("User", user.toMap());
    return result;
  }
/*
//second approach using rawinsert method.
createUser(User user) async {
    var result = await database.rawInsert(
        "INSERT INTO User (id,first_name, number, address, email, city)"
        " VALUES (${user.id},${user.firstName},${user.address},${user.email},${user.city})");
    return result;
  }

//get user
Future<List> getUsers() async {
    var result = await database
        .query("Customer", columns: ["id", "first_name", "last_name", "email"]);

    return result.toList();
  }*/
}
