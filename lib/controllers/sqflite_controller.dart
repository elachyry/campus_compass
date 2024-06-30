import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/models.dart';

class SqfliteController extends GetxController {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'uniConnect.db');
    Database db = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
      id TEXT PRIMARY KEY,
      fullName TEXT,
      email TEXT,
      password TEXT,
      isCompleted INTEGER,
      phoneNumber TEXT,
      imageUrl TEXT,
      gender TEXT,
      birthDate TEXT,
      interests TEXT
      )
''');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {}

  Future<List<Map<String, Object?>>> readData(String query) async {
    Database? myDb = await db;
    List<Map<String, Object?>> response = await myDb!.rawQuery(query);
    return response;
  }

  Future<int> insertData(String query) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(query);
    return response;
  }

  Future<int> updateData(String query) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(query);
    return response;
  }

  Future<int> deleteData(String query) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(query);
    return response;
  }

Future<void> insertUserData(User user) async {
    String interestsJson = jsonEncode(user.interests); // Convert List<String> to JSON string

    // Escape single quotes in JSON string for SQLite
    interestsJson = interestsJson.replaceAll("'", "''");

    String query = '''
      INSERT INTO user ("id", "fullName", "email", "isCompleted", "phoneNumber", "imageUrl", "gender", "birthDate", "interests") 
      VALUES ("${user.id}", "${user.name}", "${user.email}", ${user.isCompleted ? 1 : 0}, 
              "${user.phoneNumber}", "${user.imageUrl}", "${user.gender}", "${user.birthDate}", '$interestsJson')
    ''';

    await insertData(query);
  }

Future<int> updatetUserData(User user) async {
  String interestsJson = jsonEncode(user.interests);

  // Escape single quotes in JSON string for SQLite
  interestsJson = interestsJson.replaceAll("'", "''");

  String query = '''
    UPDATE user SET 
      isCompleted = ${user.isCompleted ? 1 : 0}, 
      phoneNumber = "${user.phoneNumber}", 
      imageUrl = "${user.imageUrl}", 
      gender = "${user.gender}", 
      birthDate = "${user.birthDate}", 
      interests = '$interestsJson' 
    WHERE id = "${user.id}"
  ''';

  return await updateData(query);
}

  Future<User?> getUserData(String uid) async {
    List<Map<String, dynamic>> result =
        await readData('SELECT * FROM user WHERE id = "$uid"');
    if (result.isNotEmpty) {
      bool isCompleted = result.first['isCompleted'] == 1;

      return User(
        id: result.first['id'],
        name: result.first['fullName'],
        email: result.first['email'],
        isCompleted: isCompleted,
        phoneNumber: result.first['phoneNumber'],
        imageUrl: result.first['imageUrl'],
        gender: result.first['gender'],
        birthDate: result.first['birthDate'],
        interests: List<Interest>.from(
          jsonDecode(result.first['interests']).map(
            (interest) => Interest.fromJson(interest),
          ),
        )
      );
    }
    return null;
  }
}
