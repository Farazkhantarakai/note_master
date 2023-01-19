import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:white_note/provider/notes/deleteoptions.dart';
import 'package:white_note/provider/notes/note_model.dart';
import 'package:white_note/screens/edit_note_page.dart';

class RecentContainer extends StatefulWidget {
  const RecentContainer({
    Key? key,
    // required this.title,
    // required this.description,
    // required this.bgColor,
    // required this.dateTime})
    // required this.isLongPressed
  }) : super(key: key);
  // final bool isLongPressed;
  // final String title;
  // final String description;
  // final int bgColor;
  // final dateTime;

  @override
  State<RecentContainer> createState() => _RecentContainerState();
}

class _RecentContainerState extends State<RecentContainer> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<NoteModel>(context);
    Delete del = Provider.of<Delete>(context);
    if (kDebugMode) {
      print('reseting date and time ${data.dateTime}');
    }

    String? dateAndTime = data.dateTime;
    DateTime? now = DateTime.parse(dateAndTime!);
    String date = DateFormat.yMd().format(now);
    String time = DateFormat.jms().format(now);
    //converting int value back to color

    return InkWell(
      onTap: () {
        //  del.changeOption();
        Navigator.pushNamed(context, EditNotePage.routName, arguments: data.id);
      },
      child: Card(
        margin: const EdgeInsets.all(3),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 150,
          height: 120,
          constraints: const BoxConstraints(maxWidth: 150, maxHeight: 120),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                LimitedBox(
                  maxHeight: 20,
                  child: Text(
                    data.title!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
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
                    child: Text(data.content!,
                        style: const TextStyle(color: Colors.black54)),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('$date   $time ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
