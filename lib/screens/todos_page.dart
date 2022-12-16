import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:white_note/provider/todo/to_do.dart';
import 'package:white_note/screens/to_do_gridview.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);
  static const routName = 'todo';

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  late Todo data;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    _titleController.addListener(() {});
    data = Provider.of<Todo>(context, listen: false);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    var nData = data.allToDo;
    if (kDebugMode) {
      print(nData);
    }
    return SafeArea(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      onChanged: (String value) {
                        Provider.of<Todo>(context, listen: false)
                            .queryTodo(value);
                      },
                      decoration: InputDecoration(
                          hintText: 'search todo..',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                                style: BorderStyle.solid),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                  width: 3,
                                  style: BorderStyle.solid))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        FutureBuilder(
                          future: data.getTodos(),
                          builder: ((context, snapshot) =>
                              (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                  ? const Center(
                                      heightFactor: 10,
                                      child: CircularProgressIndicator(
                                        color: Colors.deepOrange,
                                      ),
                                    )
                                  : Consumer<Todo>(
                                      builder: ((context, todo, ch) =>
                                          todo.allToDo.isEmpty
                                              ? ch!
                                              : ToDoGridView(
                                                  tdo: data.allToDo,
                                                )),
                                      child: Center(
                                        heightFactor: 10,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/icon/todo.png',
                                              fit: BoxFit.contain,
                                              height: 50,
                                            ),
                                            const Text('No todos added yet')
                                          ],
                                        ),
                                      ))),
                        ),
                      ],
                    )
                  ],
                ),
              )))),
    );
  }
}
