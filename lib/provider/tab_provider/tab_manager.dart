import 'package:flutter/cupertino.dart';

class TabManager extends ChangeNotifier {
  int index = 0;

  int get getIndex => index;

  //you have to assign that index to the current index
  void select(int nIndex) {
    index = nIndex;
    print(index);
    notifyListeners();
  }
}
