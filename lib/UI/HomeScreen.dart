import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistsql/Drawer/drawernavigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
      ),
      drawer:  DrawerNavigation(),
    );
  }
}
