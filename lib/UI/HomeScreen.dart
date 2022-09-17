import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistsql/Drawer/drawernavigation.dart';
import 'package:todolistsql/UI/todoscreen.dart';

import '../Models/todo.dart';
import '../Service/TodoService.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todolist = <Todo>[];
  var todoService = TodoService();
  void initState() {
    super.initState();
    getAllTodo();
  }
  getAllTodo() async {
    todolist = <Todo>[];
    var todos = await todoService.loadTodo();
    todos.forEach((todo) {
      setState(() {
        var todoModel = Todo();
        todoModel.title = todo['title'];
        todoModel.description = todo['description'];
        todoModel.id = todo['id'];
        todoModel.todoDate = todo['todoDate'];
        todoModel.isFinished = todo['isFinished'];
        todoModel.category = todo['category'];
        todolist.add(todoModel);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: todolist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                  child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(todolist[index].title),
                        ],
                      ),
                      subtitle: Text(todolist[index].description))),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodoScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
