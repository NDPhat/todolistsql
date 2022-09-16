
import '../DB/Repositories.dart';
import '../Models/category.dart';

class CategoryService{
  late Repository repository;

 CategoryService()
  {
    repository=Repository();
  }
  saveCategory(Category a) async
  {
   return await repository.insertData('categories',a.categoryMap());
  }

  loadCategory() async
  {
    return await repository.readData('categories');
  }

  loadCatebyId(cateroryId) async {
   return await repository.readDatabyId('categories',cateroryId);
  }

  updateCategory(Category category) async {
   return await repository.updateDatabyId('categories',category.categoryMap());

  }

}