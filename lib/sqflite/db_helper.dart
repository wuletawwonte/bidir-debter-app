
import 'dart:async';
import 'dart:io' as io; 
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'person.dart';


class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String FIRST_NAME = 'first_name';
  static const String LAST_NAME = 'last_name';
  static const String PROFILE_COLOR = 'profile_color';
  static const String TABLE = 'person';
  static const String DB_NAME = 'bidir.db';

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async{
    await db
      .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $FIRST_NAME TEXT, $LAST_NAME TEXT, $PROFILE_COLOR INTEGER)");
  }

  Future<Person> save(Person person) async{
    var dbClient = await db;
    person.id = await dbClient.insert(TABLE, person.toMap());
    return person;
  }

  Future<List<Person>> getPersons() async{
    var dbClient = await db; 
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, FIRST_NAME, LAST_NAME, PROFILE_COLOR]);
  
    List<Person> persons = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++){
        persons.add(Person.fromMap(maps[i]));
      }
      return persons;
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient.delete(TABLE, where:'$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Person person) async{
    var dbClient = await db;
    return await dbClient.update(TABLE, person.toMap(), where: '$ID = ?', whereArgs: [person.id]);
  }

  Future close() async{
    var dbClient = await db;
    dbClient.close();
  }

}
