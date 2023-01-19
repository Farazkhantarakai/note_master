import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:white_note/provider/notes/deleteoptions.dart';
import 'package:white_note/provider/notes/editable.dart';
import 'package:white_note/provider/notes/note_model.dart';
import 'package:white_note/provider/notes/storeData.dart';
import 'package:white_note/provider/tab_provider/tab_manager.dart';
import 'package:white_note/provider/todo/toDeleteOption.dart';
import 'package:white_note/provider/todo/to_do.dart';
import 'package:white_note/screens/edit_note_page.dart';
import 'package:white_note/screens/list_screen.dart';
import 'package:white_note/screens/todos_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_note/widgets/todoadding.dart';

FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//for using local notification you need to intialize the setting first
  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings('@mipmap/note');
  DarwinInitializationSettings iosSetting = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true);

  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings, iOS: iosSetting);

  bool? result =
      await localNotificationsPlugin.initialize(initializationSettings);
  log('notification initialized $result');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => Editable())),
          ChangeNotifierProvider(create: ((context) => StoreData())),
          ChangeNotifierProvider(create: ((context) => TabManager())),
          ChangeNotifierProvider(create: (((context) => Todo()))),
          ChangeNotifierProvider(create: (context) => Delete()),
          ChangeNotifierProvider(create: (context) => NoteModel()),
          ChangeNotifierProvider(create: (context) => ToDoDelte())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                ThemeData(primaryColor: const Color.fromARGB(235, 255, 102, 0)),
            routes: {
              EditNotePage.routName: ((context) => const EditNotePage()),
              ListScreen.routName: ((context) => const ListScreen()),
              HomePage.routName: ((context) => const HomePage()),
              Todos.routName: ((context) => const Todos()),
            },
            home: const HomePage()));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final page = [const ListScreen(), const Todos()];

  var _page;
  TabManager? tab;
  @override
  void initState() {
    _page = [
      {
        'page': const ListScreen(),
        'floatingAction': FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Navigator.of(context).pushNamed(EditNotePage.routName);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      },
      {
        'page': const Todos(),
        'floatingAction': FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                builder: (ctx) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 5,
                        right: 5,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: const [ToDoAdd()],
                    ),
                  );
                });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      }
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    tab = Provider.of<TabManager>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _page[tab!.getIndex]['floatingAction'],
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            tab!.select(value);
          },
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: tab!.getIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Notes',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outlined), label: 'To dos')
          ]),
      body: _page[tab!.getIndex]['page'],
    );
  }
}
