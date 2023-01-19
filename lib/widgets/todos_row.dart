import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              // DatePicker.showDateTimePicker(context,
              //     theme: const DatePickerTheme(
              //         backgroundColor: Colors.deepOrangeAccent,
              //         itemStyle: TextStyle(color: Colors.white),
              //         cancelStyle: TextStyle(color: Colors.white),
              //         doneStyle: TextStyle(color: Colors.white)),
              //     currentTime: DateTime.now(),
              //     locale: LocaleType.en, onChanged: (date) {
              //   if (kDebugMode) {
              //     print('$date');
              //   }
              // }, onConfirm: (date) {
              //   if (kDebugMode) {
              //     print('$date');
              //   }
              // });
              BottomPicker.dateTime(
                title: 'Set the event exact time and date',
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
                onSubmit: (date) {
                  if (kDebugMode) {
                    print(date);
                  }
                },
                onClose: () {
                  if (kDebugMode) {
                    print('Picker closed');
                  }
                },
                iconColor: Colors.black,
                // minDateTime: DateTime(2021, 5, 1),
                // maxDateTime: DateTime(2021, 8, 2),
                // initialDateTime: DateTime(2021, 5, 1),
                // gradientColors: [Color(0xfffdcbf1), Color(0xffe6dee9)],
                buttonSingleColor: Colors.deepOrangeAccent,
              ).show(context);
              //   DatePicker.showDatePicker(context,
              // );
              //   DatePicker.showTime12hPicker(context);
              //deal with all your alarm managing stuff here
              // AndroidAlarmManager.periodic(
              //     const Duration(seconds: 2), 1, () {},);
            },
            child: const Text('select time')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent),
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
