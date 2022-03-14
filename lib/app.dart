import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_screen.dart';

class MyApp extends StatefulWidget {
  @override 
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      home: ListScreen(),
    );
  }
}
