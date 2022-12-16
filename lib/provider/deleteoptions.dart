import 'package:flutter/cupertino.dart';

class Delete with ChangeNotifier {
  bool deleteOption = false;

  bool get getDeleteOption => deleteOption;

  void changeOption() {
    deleteOption = true;
    notifyListeners();
  }

  void makeDeleteOptionFalse() {
    deleteOption = false;
    notifyListeners();
  }
}
