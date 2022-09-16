import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistsql/UI/HomeScreen.dart';

import '../UI/CategoryScreen.dart';

class DrawerNavigation extends StatefulWidget {

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}


class _DrawerNavigationState extends State<DrawerNavigation> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget> [
             const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
              backgroundImage: const NetworkImage('https://hinhanhdephd.com/wp-content/uploads/2020/03/hinh-nen-may-tinh-hinh-nen-4k-25.jpg'),
              ),
              accountName: Text('Dai Phat'),
              accountEmail: const Text('daiphatcbl@gmail.com'),
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()))
            
              ),
            ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Categories'),
                onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryScreen()))

            )
          ],
        ),
      ),
    );
  }
}
