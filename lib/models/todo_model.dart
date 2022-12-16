import 'package:flutter/material.dart';

class ToDoModel extends ChangeNotifier {
  int? id;
  String? title;
  bool? checked;
  ToDoModel({this.id, this.checked = false, required this.title});
  factory ToDoModel.from(Map<String, dynamic> map) {
    return ToDoModel(
        id: map['id'],
        title: map['title'],
        checked: map['checked'] == 1 ? true : false);
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'checked': checked == false ? 0 : 1};
  }

  void toggleCheckBox() {
    checked = !checked!;
    notifyListeners();
  }
}
