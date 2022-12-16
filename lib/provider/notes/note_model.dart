//this is my model and i want to store this model

import 'package:flutter/cupertino.dart';

class NoteModel extends ChangeNotifier {
  int? id;
  String? title;
  String? content;
  String? dateTime;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.dateTime,
  });

//recieving data from
  factory NoteModel.fromJson(Map map) {
    return NoteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      dateTime: map['dateTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime,
    };
  }
}
