import 'package:flutter/material.dart';
import 'package:white_note/widgets/todos_row.dart';

class ToDoAdd extends StatefulWidget {
  const ToDoAdd({Key? key}) : super(key: key);

  @override
  State<ToDoAdd> createState() => _ToDoAddState();
}

class _ToDoAddState extends State<ToDoAdd> {
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          cursorColor: Colors.deepOrange,
          decoration: const InputDecoration(
              hintText: 'Enter todo',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.deepOrange,
                    width: 3,
                    style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 3,
                      style: BorderStyle.solid))),
        ),
        ToDosRow(
          titleController: _titleController,
        )
      ],
    );
  }
}
