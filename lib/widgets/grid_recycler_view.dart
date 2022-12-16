import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_note/provider/deleteoptions.dart';
import 'package:white_note/provider/notes/note_model.dart';
import 'package:white_note/provider/notes/storeData.dart';
import 'package:white_note/widgets/recent_container.dart';
import 'package:white_note/widgets/widgets.dart';

class GridRecyclerView extends StatefulWidget {
  GridRecyclerView({
    Key? key,
    required this.storeData,
    // required this.onLongPressed
  }) : super(key: key);
  // Function onLongPressed;
  final List<NoteModel> storeData;

  @override
  State<GridRecyclerView> createState() => _GridRecyclerViewState();
}

class _GridRecyclerViewState extends State<GridRecyclerView> {
  bool? isLongPressed = false;
  bool select = false;
  String groupValue = 'Groups';
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Delete del = Provider.of<Delete>(context);
    StoreData sd = Provider.of<StoreData>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: screenSize.height * 0.78,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              showText('AllNotes', Theme.of(context).primaryColor, 20),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: GridView.builder(
                itemCount: widget.storeData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
                itemBuilder: ((context, index) {
                  return ChangeNotifierProvider<NoteModel>.value(
                      //with this it will be to that shit
                      value: widget.storeData[index],
                      builder: (context, child) {
                        return InkWell(
                          onLongPress: () {
                            setState(() {
                              del.changeOption();
                              // isLongPressed = !isLongPressed!;
                              // log(isLongPressed.toString());
                              // if (kDebugMode) {
                              //   print(
                              //       'pressed inside grid recycler view $isLongPressed');
                              // }
                              // widget.onLongPressed(isLongPressed);
                            });
                          },
                          onTap: () {
                            // setState(() {
                            //   isLongPressed = !isLongPressed!;
                            // });
                            del.makeDeleteOptionFalse();
                            // if (kDebugMode) {
                            //   print('i am pressed now!');
                            // }
                          },
                          child: Stack(fit: StackFit.expand, children: [
                            const RecentContainer(),
                            del.getDeleteOption
                                ? Positioned(
                                    height: 30,
                                    right: 0,
                                    child: Checkbox(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: select,
                                        onChanged: (bool? val) {
                                          setState(() {
                                            select = val!;
                                            if (kDebugMode) {
                                              print(val);
                                            }

                                            if (select == true) {
                                              sd.deletList(
                                                  widget.storeData[index]);
                                            }
                                          });
                                        }),
                                  )
                                : Container(),
                          ]),
                        );
                      });
                })),
          )
        ],
      ),
    );
  }
}
