//this is my model and i want to store this model
import 'package:flutter/foundation.dart';

class NoteModel extends ChangeNotifier {
  int? id;
  String? title;
  String? content;
  String? dateTime;
  bool? isChecked;

  NoteModel(
      {this.id,
      this.title,
      this.content,
      this.dateTime,
      this.isChecked = false});

  // bool get getChecked => isChecked!;

//recieving data from
  factory NoteModel.fromJson(Map map) {
    return NoteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      dateTime: map['dateTime'],
    );
  }

  // void makeToggle() {
  //   isChecked = !isChecked!;
  //   if (kDebugMode) {
  //     print(isChecked);
  //   }
  //   notifyListeners();
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime,
    };
  }
}
