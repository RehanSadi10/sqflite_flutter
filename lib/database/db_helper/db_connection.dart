import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection
{
  static const databaseName = 'db_crud.db' ;
  static const table = 'users' ;

  static const columnId = 'id' ;
  static const columnName = 'name' ;
  static const columnContact = 'contact' ;
  static const columnAdress = 'address' ;
  static const columnPincode = 'pincode' ;

  Future<Database> setDatabase() async
  {
    var directory = await getApplicationDocumentsDirectory() ;
    var path = join(directory.path,databaseName) ;

    var database = await openDatabase(
        path,
        version: 1,
        onCreate: _createDatabase,
    ) ;

    return database ;
  }

  Future<void> _createDatabase(Database db , int version)
  async {
    String sql =
    '''
    CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    name TEXT,
    contact TEXT,
    address TEXT,
    pincode TEXT
    )
    '''
    ;

    await db.execute(sql) ;
  }
}