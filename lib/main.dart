import 'package:flutter/material.dart';
import 'package:sqflite_database/ui/screens/add_user.dart';
import 'package:sqflite_database/ui/screens/edit_user.dart';
import 'package:sqflite_database/ui/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //home: AddUser(),
      //home: EditUser(),
    ) ;
  }
}