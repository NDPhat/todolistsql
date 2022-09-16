import 'package:sqflite/sqflite.dart';
import 'package:todolistsql/DB/DBConnection.dart';

class Repository {
  DBConnection dbConnection = DBConnection();

  Repository();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await dbConnection.setDatabase();
    return _database!;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDatabyId(table,itemid) async{
    var connection = await database;
    return await connection.query(table,where:'id=?',whereArgs: [itemid]);
  }

  updateDatabyId(table, caterory) async {
    var connection = await database;
    return await connection.update(table, caterory,where:'id=?',whereArgs: [caterory['id']]);
  }
}
