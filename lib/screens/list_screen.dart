import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_note/provider/notes/deleteoptions.dart';
import 'package:white_note/provider/notes/note_model.dart';
import 'package:white_note/provider/notes/storeData.dart';
import 'package:white_note/widgets/grid_recycler_view.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  static const routName = 'ListScreen';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _search = TextEditingController();
  bool firstRun = true;
  late StoreData sD;
  bool changeDesign = false;
  late List<NoteModel> nD;
  bool onPressed = false;

  @override
  void initState() {
    _search.addListener(() {});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    sD = Provider.of<StoreData>(context, listen: false);
    super.didChangeDependencies();
  }

  void onLongPressed(isLongPressed) {
    setState(() {
      onPressed = isLongPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    Delete del = Provider.of<Delete>(context);
    StoreData sd = Provider.of<StoreData>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: del.getDeleteOption
          ? AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    del.makeDeleteOptionFalse();
                  },
                  icon: const Icon(
                    Icons.dangerous_sharp,
                    color: Colors.deepOrangeAccent,
                  )),
              actions: [
                IconButton(
                    onPressed: () {
                      sd.deleteSelectedItems();
                      del.makeDeleteOptionFalse();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.deepOrangeAccent,
                    ))
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              Row(
                children: [
                  if (!del.getDeleteOption)
                    Expanded(
                        child: TextFormField(
                      onChanged: (String value) {
                        Provider.of<StoreData>(context, listen: false)
                            .queryOnListView(value);
                      },
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: 'search notes..',
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3))),
                    )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: sD.getData(),
                builder: (context, snapshot) => (snapshot.connectionState ==
                        ConnectionState.waiting)
                    ? const Center(
                        heightFactor: 6,
                        child:
                            CircularProgressIndicator(color: Colors.redAccent))
                    : Consumer<StoreData>(
                        builder: ((context, storeData, ch) =>
                            storeData.allNotes.isEmpty
                                ? ch!
                                : Column(
                                    children: [
                                      GridRecyclerView(
                                        storeData: storeData.allNotes,
                                        // onLongPressed: onLongPressed,
                                      )
                                    ],
                                  )),
                        child: Center(
                          heightFactor: 8,
                          child: Column(children: [
                            Image.asset('assets/icon/writing.png',
                                fit: BoxFit.cover, height: 50),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('No Note added yet')
                          ]),
                        )),
              ),
            ])),
      ),
    ));
  }
}
