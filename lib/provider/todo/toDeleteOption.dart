import 'package:flutter/cupertino.dart';

class ToDoDelte extends ChangeNotifier {
  bool toDoChecked = false;

  get getToDoOption => toDoChecked;

  void makeToDoFalse() {
    toDoChecked = false;
    notifyListeners();
  }

  void makeToDoTrue() {
    toDoChecked = true;
    notifyListeners();
  }
}
