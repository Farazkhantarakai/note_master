import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_note/main.dart';
import 'package:white_note/provider/notes/note_model.dart';
import 'package:white_note/provider/notes/editable.dart';
import 'package:white_note/provider/notes/storeData.dart';
import 'package:white_note/widgets/widgets.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key}) : super(key: key);
  static const routName = 'EditNote';

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isinit = true;
  var oldNote = NoteModel(id: null, title: '', content: '', dateTime: '');
  var newNote = {'id': '', 'title': '', 'content': '', 'dateTime': ''};
  bool trackNoteId = false;
  var noteId;
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isinit) {
      noteId = ModalRoute.of(context)!.settings.arguments;

      if (noteId != null) {
        trackNoteId = true;
        oldNote = Provider.of<StoreData>(context).findById(noteId);
        newNote = {
          'id': oldNote.id.toString(),
          'title': '',
          'content': '',
          'dateTime': oldNote.dateTime!
        };
        _titleController.text = oldNote.title!;
        _contentController.text = oldNote.content!;
      }

      isinit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var medit = Provider.of<Editable>(context);
    // var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: medit.select,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 5),
            child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.navigate_before,
                            color: Theme.of(context).primaryColor,
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(0.0),
                          iconSize: 30,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(
                                color: medit.selectCColor,
                                fontSize: medit.size,
                                fontWeight: FontWeight.bold),
                            cursorColor: medit.selectCColor,
                            controller: _titleController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: medit.selectCColor),
                                hintText: 'Title',
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              //
                              if (trackNoteId) {
                                // if (kDebugMode) {
                                //   print('i am in the update section');
                                // }
                                if (_titleController.text.isEmpty &&
                                    _contentController.text.isEmpty) {
                                  showToast('empty note discarded');
                                  Navigator.of(context)
                                      .pushNamed(HomePage.routName);
                                  return;
                                } else {
                                  if (kDebugMode) {
                                    print('i am here');
                                  }
                                  NoteModel noteModel = NoteModel(
                                    id: noteId,
                                    title: _titleController.text,
                                    content: _contentController.text,
                                    dateTime: DateTime.now().toIso8601String(),
                                  );
                                  StoreData sd = StoreData();
                                  sd.updateData(noteModel, noteId!);
                                  // Navigator.of(context)
                                  //     .pushNamed(HomePage.routName);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      HomePage.routName, (route) => false);
                                }
                              } else {
                                if (_titleController.text.isEmpty &&
                                    _contentController.text.isEmpty) {
                                  showToast('empty note discarded');
                                  // Navigator.of(context)
                                  //     .pushNamed(HomePage.routName);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      HomePage.routName, (route) => false);
                                  return;
                                } else {
                                  NoteModel noteModel = NoteModel(
                                    title: _titleController.text,
                                    content: _contentController.text,
                                    dateTime: DateTime.now().toString(),
                                  );
                                  StoreData sd = StoreData();
                                  sd.insertData(noteModel);
                                  // Navigator.of(context)
                                  //     .pushNamed(HomePage.routName);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      HomePage.routName, (route) => false);
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.check,
                              color: Colors.orangeAccent,
                            ))
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          textAlign: medit.verticalCenter,
                          style: TextStyle(
                              color: medit.selectCColor, fontSize: medit.size),
                          cursorColor: medit.selectCColor,
                          controller: _contentController,
                          maxLines: 100,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: medit.selectCColor),
                              hintText: 'Content',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
