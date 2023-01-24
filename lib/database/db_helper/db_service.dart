import 'package:sqflite/sqflite.dart';
import 'package:sqflite_database/database/db_helper/db_connection.dart';

class DatabaseService
{
  late DatabaseConnection _databaseConnection ;

  DatabaseService()
  {
    _databaseConnection = DatabaseConnection() ;
  }

  static Database? _database ;

  Future<Database> get database async
  {
    if(_database != null)
    {
      return _database! ;
    }

    _database = await _databaseConnection.setDatabase() ;
    return _database! ;
  }

  insert(table,data) async
  {
    final db = await database ;
    return await db.insert(
        table,
        data
    ) ;
  }

  readAllData(table) async
  {
    final db = await database ;
    return await db.query(table) ;
  }

  readById(table,itemId) async
  {
    final db = await database ;
    return await db.query(
        table,
      where: 'id = ?',
      whereArgs: [itemId],
    ) ;
  }

  updateData(table,data) async
  {
    final db = await database ;
    return await db.update(
        table,
        data,
      where: 'id = ?',
      whereArgs: [data['id']]
    ) ;
  }

  deleteData(table,itemId) async
  {
    final db = await database ;
    return await db.delete(
        table,
      where: 'id = ?',
      whereArgs: [itemId]
    ) ;
  }

  deleteAllData(table) async
  {
    final db = await database ;
    return await db.delete(table) ;
    //return await db.rawDelete('DELETE FROM $table') ;
  }
}