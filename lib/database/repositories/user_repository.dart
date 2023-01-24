import 'package:sqflite_database/database/db_helper/db_connection.dart';
import 'package:sqflite_database/database/db_helper/db_service.dart';
import 'package:sqflite_database/database/model/users_model.dart';

class UserRepository
{
  static const table = 'users' ;
  late DatabaseService _databaseService ;
  UserRepository()
  {
    _databaseService = DatabaseService() ;
  }

  saveData(UsersModel usersModel) async
  {
    return await _databaseService.insert(table, usersModel.toMap()) ;
  }

  realAllUsers(table) async
  {
    return await _databaseService.readAllData(table) ;
  }

  updateUser(UsersModel usersModel) async
  {
    return await _databaseService.updateData(table, usersModel.toMap()) ;
  }

  deleteUser(itemId) async
  {
    return await _databaseService.deleteData(table, itemId) ;
  }

  deleteAllUser() async
  {
    return await _databaseService.deleteAllData(table) ;
  }
}