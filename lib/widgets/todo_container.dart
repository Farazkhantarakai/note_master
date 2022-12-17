import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_note/models/todo_model.dart';
import 'package:white_note/provider/todo/toDeleteOption.dart';
import 'package:white_note/provider/todo/to_do.dart';
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
  bool checkValue = false;
  bool newValue = false;
  @override
  Widget build(BuildContext context) {
    var to = Provider.of<ToDoDelte>(context, listen: false);
    var data = Provider.of<ToDoModel>(context, listen: false);
    var todo = Provider.of<Todo>(context);
    if (kDebugMode) {
      // print('getcheckboxfalse ${data.getCheckBoxFalse}');
    }
    return Stack(children: [
      Card(
        elevation: 5,
        child: ListTile(
          onLongPress: () {
            to.makeToDoTrue();
          },
          onTap: () {
            //to.makeToDoFalse();
          },
          leading: to.getToDoOption == false
              ? Checkbox(
                  activeColor: Colors.deepOrange,
                  value: data.checked,
                  onChanged: (value) {
                    setState(() {
                      data.toggleCheckBox();
                      DatabaseService databaseService =
                          DatabaseService.privateConstructor();
                      ToDoModel toDoModel = ToDoModel(
                          title: '${data.title}',
                          id: data.id,
                          checked: data.checked);
                      databaseService.updateTodo(toDoModel);
                    });
                  })
              : null,
          title: data.checked == false
              ? Text('${data.title}')
              : Text(
                  '${data.title}',
                  style:
                      const TextStyle(decoration: TextDecoration.lineThrough),
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
      ),
      Positioned(
        bottom: 25,
        left: -8,
        child: to.getToDoOption == true
            ? Checkbox(
                value: data.checkBoxFalse,
                checkColor: Colors.red,
                activeColor: Colors.white,
                onChanged: (val) {
                  setState(() {
                    newValue = val!;
                    if (data.checkBoxFalse == true) {
                      data.checkBoxFalse = false;
                      todo.removeItem(ToDoModel(
                          title: data.title,
                          id: data.id,
                          checked: data.checked));
                    } else {
                      data.checkBoxFalse = true;
                      todo.addItem(ToDoModel(
                          title: data.title,
                          id: data.id,
                          checked: data.checked));
                    }
                  });
                })
            : Container(),
      )
    ]);
  }
}
