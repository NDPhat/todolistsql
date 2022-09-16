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

  List<Category> categorylist = <Category>[];

  void initState() {
    super.initState();
    getAllCate();
  }

  getAllCate() async {
    var categories = await cateservice.loadCategory();
    categories.forEach((category) {
      setState(() {
        var cateModel = Category();
        cateModel.name = category['name'];
        cateModel.description = category['description'];
        cateModel.id=category['id'];
        categorylist.add(cateModel);
      });
    });
  }

  getCatebyId(BuildContext context,cateroryId) async
  {
    _category = await cateservice.loadCatebyId(cateroryId);
    setState((){
      editcategoryName.text=_category[0]['name']??'No Name';
      editcategoryDes.text=_category[0]['description']??'No Des';

    });
    showEditFormDialog(context);
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
                  category.id=categorylist.length+1;
                  var resutl=await cateservice.saveCategory(category);
                  if(resutl>0)
                  {
                    Navigator.pop(context);
                    setState((){
                      categorylist.add(category);
                    });
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
                  category.id=_category[0]['id'];
                  category.name = editcategoryName.text;
                  category.description = editcategoryDes.text;
                  var resutl=await cateservice.updateCategory(category);
                  if(resutl>0)
                    {
                      Navigator.pop(context);
                      setState((){
                        categorylist[_category[0]['id']-1].name=editcategoryName.text;
                        categorylist[_category[0]['id']-1].description=editcategoryDes.text;

                      });
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
              child: Card(
                  child: ListTile(
                      leading:
                          IconButton(onPressed: () {
                            getCatebyId(context,categorylist[index].id);
                          }, icon: Icon(Icons.edit)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(categorylist[index].name),
                          IconButton(onPressed: () {}, icon: Icon(Icons.delete))
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
