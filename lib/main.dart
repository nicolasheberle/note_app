import './screens/home_screen.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('Flutter Notes'),
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark
      ),
      home: const HomeScreen(),
    );
  }
}