import 'package:database_/db/dbHelper.dart';
import 'package:database_/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final dbHelper = DBHelper();

void main() {
  DBHelper();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
