import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:white_note/main.dart';
import 'package:white_note/models/todo_model.dart';
import 'package:white_note/provider/todo/to_do.dart';

class ToDosRow extends StatefulWidget {
  const ToDosRow({Key? key, required this.titleController}) : super(key: key);
  final TextEditingController titleController;
  @override
  State<ToDosRow> createState() => _ToDosRowState();
}

class _ToDosRowState extends State<ToDosRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor),
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  theme: const DatePickerTheme(
                      backgroundColor: Colors.deepOrangeAccent,
                      itemStyle: TextStyle(color: Colors.white),
                      cancelStyle: TextStyle(color: Colors.white),
                      doneStyle: TextStyle(color: Colors.white)),
                  currentTime: DateTime.now(),
                  locale: LocaleType.en, onChanged: (date) {
                if (kDebugMode) {
                  print('$date');
                }
              }, onConfirm: (date) {
                if (kDebugMode) {
                  print('$date');
                }
              });
            },
            child: const Text('select time')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
            onPressed: () {
              setState(() {
                Todo toDB = Todo();
                ToDoModel toDo = ToDoModel(title: widget.titleController.text);
                toDB.insertTodo(context, toDo);
                widget.titleController.text = '';
              });
              // Provider.of<TabManager>(context).select(1);
              // print('i am out');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            },
            child: const Text('save')),
      ],
    );
  }
}
