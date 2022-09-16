import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistsql/UI/HomeScreen.dart';
import 'package:todolistsql/Models/category.dart';

import '../Service/CategoryService.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var categoryName = TextEditingController();
  var editcategoryName = TextEditingController();
  var categoryDes = TextEditingController();
  var editcategoryDes = TextEditingController();
  var category = Category();
  var cateservice = CategoryService();
  var _category;
  var deletedindex;
  List<Category> categorylist = <Category>[];
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  void initState() {
    super.initState();
    getAllCate();
  }
  getAllCate() async {
    categorylist=<Category>[];
    var categories = await cateservice.loadCategory();
    categories.forEach((category) {
      setState(() {
        var cateModel = Category();
        cateModel.name = category['name'];
        cateModel.description = category['description'];
        cateModel.id = category['id'];
        categorylist.add(cateModel);
      });
    });
  }

  getCatebyId(BuildContext context, cateroryId) async {
    _category = await cateservice.loadCatebyId(cateroryId);
    setState(() {
      editcategoryName.text = _category[0]['name'] ?? 'No Name';
      editcategoryDes.text = _category[0]['description'] ?? 'No Des';
    });
    showEditFormDialog(context);
  }

  deleteCatebyId(BuildContext context) async {
    cateservice.deleteCatebyId(categorylist[deletedindex].id);
  }

  showFormDialog(BuildContext buildContext) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  category.name = categoryName.text;
                  category.description = categoryDes.text;
                  category.id = categorylist.last.id + 1;
                  var resutl = await cateservice.saveCategory(category);
                  if (resutl > 0) {
                    Navigator.pop(context);
                    getAllCate();
                  }
                },
                child: const Text('Save'),
                color: Colors.blue,
              ),
            ],
            title: const Text('Category Form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: categoryName,
                      decoration: const InputDecoration(
                          hintText: 'Write Name Category',
                          labelText: 'Name Category')),
                  TextField(
                      controller: categoryDes,
                      decoration: const InputDecoration(
                          hintText: 'Write Description Category',
                          labelText: 'Description Category')),
                ],
              ),
            ),
          );
        });
  }

  showDeleteFormDialog(BuildContext buildContext) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () {
                  deleteCatebyId(context);
                  Navigator.pop(context);
                  showSuccessSnackbar(Text('Delete successfull'));
                  getAllCate();

                },
                child: const Text('Delete'),
                color: Colors.blue,
              ),
            ],
            title: Text('Delete Category Form'),
          );
        });
  }

  showEditFormDialog(BuildContext buildContext) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  category.id = _category[0]['id'];
                  category.name = editcategoryName.text;
                  category.description = editcategoryDes.text;
                  var resutl = await cateservice.updateCategory(category);
                  if (resutl > 0) {
                    Navigator.pop(context);
                    getAllCate();
                  }
                },
                child: const Text('Update'),
                color: Colors.blue,
              ),
            ],
            title: const Text('Edit Category Form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: editcategoryName,
                      decoration: const InputDecoration(
                          hintText: 'Write Name Category',
                          labelText: 'Name Category')),
                  TextField(
                      controller: editcategoryDes,
                      decoration: const InputDecoration(
                          hintText: 'Write Description Category',
                          labelText: 'Description Category')),
                ],
              ),
            ),
          );
        });
  }

  showSuccessSnackbar(message) {
    var _snackbar = SnackBar(content: message);
    _globalKey.currentState!.showSnackBar(_snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          child: const Icon(Icons.arrow_back),
          color: Colors.blue,
        ),
        title: const Text('Catagory'),
      ),
      body: ListView.builder(
          itemCount: categorylist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                  child: ListTile(
                      leading: IconButton(
                          onPressed: () {

                            getCatebyId(context, categorylist[index].id);
                          },
                          icon: Icon(Icons.edit)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(categorylist[index].name),
                          IconButton(
                              onPressed: () {
                                deletedindex=index;
                                showDeleteFormDialog(context);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                      subtitle: Text(categorylist[index].description))),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
