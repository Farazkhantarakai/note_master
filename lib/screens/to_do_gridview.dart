import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_note/models/todo_model.dart';

import 'package:white_note/widgets/todo_container.dart';

class ToDoGridView extends StatelessWidget {
  ToDoGridView({Key? key, required this.tdo}) : super(key: key);
  // List<ToDoModel> data;
  List<ToDoModel> tdo;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: screenSize.height * 0.67,
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Todos',
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: tdo.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                      value: tdo[index], child: const TileContainer());
                }),
          ),
        ],
      ),
    );
  }
}
