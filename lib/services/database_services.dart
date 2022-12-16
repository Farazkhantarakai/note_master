import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:white_note/models/todo_model.dart';
import 'package:white_note/provider/notes/note_model.dart';

class DatabaseService {
  DatabaseService.privateConstructor();
  static final DatabaseService instance = DatabaseService.privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    //this will get a path for our database
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/noteAp.db';

    var noteDatabase =
        await openDatabase(path, version: 2, onCreate: _createDb);
    return noteDatabase;
  }

  Future<void> _createDb(Database db, int version) async {
    db.execute('''

CREATE TABLE Note(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT,dateTime TEXT)

''');

    db.execute('''
CREATE TABLE todo(id  INTEGER PRIMARY KEY   AUTOINCREMENT,title TEXT,checked INTEGER)
''');
  }

  Future<int> insertNote(NoteModel noteModel) async {
    Database db = await instance.database;
    int result = await db.insert('Note', {
      'title': noteModel.title,
      'content': noteModel.content,
      'dateTime': noteModel.dateTime
    });
    return result;
  }

  Future<List<NoteModel>> getAllNotes() async {
    List<NoteModel> notes = [];
    Database db = await instance.database;

    List<Map<String, dynamic>> result = await db.query('Note');
    for (var i in result) {
      var value = NoteModel.fromJson(i);
      notes.add(value);
    }
    if (kDebugMode) {
      print('inside database notes $notes');
    }
    return notes;
  }

  updateNoteModel(NoteModel noteModel, int trackNoteId) async {
    Database db = await instance.database;
    int result = await db.update('Note', noteModel.toMap(),
        where: 'id=?', whereArgs: [trackNoteId]);
    return result;
  }

  Future<int> toDoInsert(ToDoModel md) async {
    Database db = await instance.database;
    int result = await db.insert('todo', md.toMap());
    return result;
  }

  Future<List<ToDoModel>> getData() async {
    List<ToDoModel> data = [];
    Database db = await instance.database;
    List<Map<String, Object?>> item = await db.query('todo');

    for (var i in item) {
      ToDoModel singleData = ToDoModel.from(i);
      data.add(singleData);
    }
    if (kDebugMode) {
      print('inside getting database $data');
    }
    return data;
  }

  Future<int> updateTodo(ToDoModel toDoModel) async {
    Database db = await instance.database;
    final result = await db.update('todo', toDoModel.toMap(),
        where: 'id=?', whereArgs: [toDoModel.id]);
    return result;
  }
}
