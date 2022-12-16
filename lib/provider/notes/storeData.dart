import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:white_note/provider/deleteoptions.dart';
import 'package:white_note/provider/notes/note_model.dart';
import 'package:white_note/services/database_services.dart';
import 'package:white_note/widgets/widgets.dart';

class StoreData extends ChangeNotifier {
  List<NoteModel> _notes = [];
  String searchString = '';
  List<NoteModel> deleteList = [];
  DatabaseService db = DatabaseService.instance;
  List<NoteModel> get allNotes {
    // if (kDebugMode) {
    //   print('store $_notes');
    // }
    return searchString.isEmpty
        ? _notes
        : _notes
            .where((note) =>
                note.title!.toLowerCase().contains(searchString.toLowerCase()))
            .toList();
  }

  NoteModel findById(id) {
    return _notes.firstWhere((element) => element.id == id);
  }

  bool deleteSelectedItems() {
    deleteList.forEach((item) {
      allNotes.removeWhere((element) {
        return element.id == item.id;
      });
    });

    notifyListeners();
    return true;
  }

  void insertData(NoteModel nm) async {
    int result = await db.insertNote(nm);

    if (result > 0) {
      showToast('Data Inserted Succefully');
    } else {
      showToast('Some Thing Went Wrong');
    }
    notifyListeners();
  }

  void deletList(NoteModel nm) {
    deleteList.add(nm);
    if (kDebugMode) {
      print(deleteList);
    }
    notifyListeners();
  }

  void queryOnListView(String searchText) {
    searchString = searchText;
    notifyListeners();
  }

  Future<void> getData() async {
    DatabaseService db = DatabaseService.instance;
    _notes = await db.getAllNotes();
    notifyListeners();
  }

  Future<void> updateData(NoteModel noteModel, int trackNoteId) async {
    DatabaseService db = DatabaseService.instance;
    int result = await db.updateNoteModel(noteModel, trackNoteId);
    if (result > 0) {
      Fluttertoast.showToast(
          msg: 'Note  Updated', backgroundColor: Colors.deepOrange);
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    notifyListeners();
  }
}
