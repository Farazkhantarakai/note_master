import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:white_note/models/todo_model.dart';
import 'package:white_note/services/database_services.dart';

class TileContainer extends StatefulWidget {
  const TileContainer({
    Key? key,
  }) : super(key: key);
  @override
  State<TileContainer> createState() => _TileContainer();
}

class _TileContainer extends State<TileContainer> {
  bool falseSwitch = false;
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ToDoModel>(context, listen: false);
    if (kDebugMode) {}
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Checkbox(
            activeColor: Colors.deepOrange,
            value: data.checked,
            onChanged: (value) {
              setState(() {
                data.toggleCheckBox();
                DatabaseService databaseService =
                    DatabaseService.privateConstructor();
                ToDoModel toDoModel = ToDoModel(
                    title: '${data.title}', id: data.id, checked: data.checked);
                databaseService.updateTodo(toDoModel);
              });
            }),
        title: data.checked == false
            ? Text('${data.title}')
            : Text(
                '${data.title}',
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
        trailing: Switch(
            activeColor: Colors.deepOrangeAccent,
            value: falseSwitch,
            onChanged: (value) {
              setState(() {
                falseSwitch = value;
                //we will store this thing in the sqflite database
              });
            }),
      ),
    );
  }
}
