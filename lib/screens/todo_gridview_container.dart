import 'package:flutter/material.dart';

class ToDoContainer extends StatelessWidget {
  const ToDoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 150,
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            children: [
              const Text(
                '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 2),
                child: SizedBox(
                  width: double.infinity,
                  height: constraint.maxHeight * 0.65,
                  child:
                      const Text('', style: TextStyle(color: Colors.black54)),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(' ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              )
            ],
          );
        }),
      ),
    );
  }
}
