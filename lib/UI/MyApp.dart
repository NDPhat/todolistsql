
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList With SQFLITE',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
