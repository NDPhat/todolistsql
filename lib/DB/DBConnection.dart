import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class DBConnection
{
  setDatabase() async
  {
    var directory=await getApplicationDocumentsDirectory();
    var path=join(directory.path,'db"_todolist');
    var database=await openDatabase(path,version: 1,onCreate: onCreateingDatabase);
    return database;
  }
  onCreateingDatabase(Database database,int version) async
    {
      await database.execute('CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,description TEXT)');
    }
}