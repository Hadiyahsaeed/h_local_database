import 'package:local_database/models/note_model.dart';
import 'package:local_database/models/note_students.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";

  // Make sure this method is awaited when called.
  static Future<Database> _getDB() async {
    String databasePath = await getDatabasesPath();
    Database db = await openDatabase(
      join(databasePath, _dbName),
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);",
        );
      },
      version: _version,
    );

    return db;
  }

  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    return await db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete("Note", where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<List<Note>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }

  static addStudent(Student studentToUpdate) {}

  static updateStudent(Student studentToUpdate) {}
}

class DatabaseStudent {
  static const int _version = 1;
  static const String _dbName = "Notes.db";

  // Make sure this method is awaited when called.
  static Future<Database> _getDB() async {
    String databasePath = await getDatabasesPath();
    Database db = await openDatabase(
      join(databasePath, _dbName),
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE student(id INTEGER PRIMARY KEY, s_name TEXT NOT NULL, s.address TEXT NOT NULL);",
        );
      },
      version: _version,
    );

    return db;
  }

  static Future<int> addNote(Student student) async {
    final db = await _getDB();
    return await db.insert("Student", student.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Student student) async {
    final db = await _getDB();
    return await db.update("Student", student.toJson(),
        where: 'id = ?', whereArgs: [student.id]);
  }

  static Future<int> deleteNote(Student student) async {
    final db = await _getDB();
    return await db.delete("Student", where: 'id = ?', whereArgs: [student.id]);
  }

  static Future<List<Student>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Student");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Student.fromJson(maps[index]));
  }
}
