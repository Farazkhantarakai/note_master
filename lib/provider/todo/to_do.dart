import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:white_note/models/todo_model.dart';
import 'package:white_note/services/database_services.dart';

class Todo with ChangeNotifier {
  List<ToDoModel> _item = [];
  String searchItem = '';
  List<ToDoModel> tDeletingList = [];
  DatabaseService db = DatabaseService.instance;
  List<ToDoModel> get allToDo {
    return searchItem.isEmpty
        ? _item
        : _item
            .where((element) =>
                element.title!.toLowerCase().contains(searchItem.toLowerCase()))
            .toList();
  }

  void queryTodo(String query) {
    searchItem = query;
    notifyListeners();
  }

  void deletingItem() {
    tDeletingList.forEach((d) {
      db.todoDelete(d);
      _item.removeWhere((element) => element.id == d.id);
    });
    notifyListeners();
  }

  void addItem(ToDoModel tm) {
    tDeletingList.add(tm);
    if (kDebugMode) {
      print('deleting $tDeletingList');
    }
    notifyListeners();
  }

  void removeItem(ToDoModel tm) {
    //you can remove a particular element or a particular element with an id
    tDeletingList.remove(tm);
    notifyListeners();
  }

  void insertTodo(BuildContext context, ToDoModel toDo) async {
    DatabaseService db = DatabaseService.instance;
    int result = await db.toDoInsert(toDo);
    if (result > 0) {
      Fluttertoast.showToast(
          msg: 'Data is inserted', backgroundColor: Colors.deepOrange);
    } else {
      Fluttertoast.showToast(
          msg: 'Some Thing Went Wrong', backgroundColor: Colors.deepOrange);
    }
    notifyListeners();
  }

  Future<void> getTodos() async {
    DatabaseService db = DatabaseService.instance;
    _item = await db.getData();
    if (kDebugMode) {
      print('inside todos $_item');
    }
    notifyListeners();
  }
}
