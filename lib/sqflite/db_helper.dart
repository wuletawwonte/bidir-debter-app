
import 'dart:async';
import 'dart:io' as io; 
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'person.dart';
import 'tenant.dart';


class DBHelper {
  static Database _db;
  static const String PERSON_ID = 'person_id';
  static const String TENANT_ID = 'tenant_id';
  static const String TENANT_TYPE = 'tenant_type';  
  static const String TENANTEE_ID = 'tenantee_id'; 
  static const String ITEM_TYPE = 'item_type';
  static const String ITEM_DETAILS = 'item_details';
  static const String ITEM_QUANTITY = 'item_quantity';
  static const String DEADLINE = 'deadline';   
  static const String DATE_CREATED = 'date_created';
  static const String FIRST_NAME = 'first_name';
  static const String LAST_NAME = 'last_name';
  static const String PROFILE_COLOR = 'profile_color';
  static const String PERSONS_TABLE = 'persons';
  static const String TENANTS_TABLE = 'tenants';
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

  // CREATES BOTH PERSONS AND TENANTS TABLE

  _onCreate(Database db, int version) async{
    await db
      .execute("CREATE TABLE IF NOT EXISTS $PERSONS_TABLE ($PERSON_ID INTEGER PRIMARY KEY, $FIRST_NAME TEXT, $LAST_NAME TEXT, $PROFILE_COLOR INTEGER, $DATE_CREATED DEFAULT CURRENT_TIMESTAMP)");
    await db
      .execute("CREATE TABLE IF NOT EXISTS $TENANTS_TABLE ($TENANT_ID INTEGER PRIMARY KEY, $TENANT_TYPE TEXT, $TENANTEE_ID INTEGER,$ITEM_TYPE TEXT,$ITEM_DETAILS TEXT, $ITEM_QUANTITY INTEGER, $DEADLINE TEXT, $DATE_CREATED DEFAULT CURRENT_TIMESTAMP)");
  }

  // SAVE PERSON TO THE PERSONS TABLE

  Future<Person> savePerson(Person person) async{
    var dbClient = await db;
    person.id = await dbClient.insert(PERSONS_TABLE, person.toMap());
    return person;
  }

  // GET ALL THE PERSONS FROM THE PERSONS TABLE

  Future<List<Person>> getPersons() async{
    var dbClient = await db; 
    List<Map> maps = await dbClient.query(PERSONS_TABLE, columns: [PERSON_ID, FIRST_NAME, LAST_NAME, PROFILE_COLOR]);
  
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

  // DELETE A PERSON FROM PERSONS TABLE

  Future<int> deletePerson(int id) async{
    var dbClient = await db;
    return await dbClient.delete(PERSONS_TABLE, where:'$PERSON_ID = ?', whereArgs: [id]);
  }

  // UPDATE THE RECORD OF A PERSON FROM THE PERSONS TABLE

  Future<int> updatePerson(Person person) async{
    var dbClient = await db;
    return await dbClient.update(PERSONS_TABLE, person.toMap(), where: '$PERSON_ID = ?', whereArgs: [person.id]);
  }

  // ______________ THIS RELATES TO TENANTS TABLE __________
  // SAVE TENANT RECORD TO TENANTS TABLE

  Future<Tenant> saveTenant(Tenant tenant) async{
    var dbClient = await db;
    tenant.id = await dbClient.insert(TENANTS_TABLE, tenant.toMap());
    return tenant;
  }

  // GET TENANTS FROM TENANTS TABLE

  Future<List<Tenant>> getTenants() async{
    var dbClient = await db; 
    List<Map> maps = await dbClient.query(TENANTS_TABLE);
  
    List<Tenant> tenants = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++){
        tenants.add(Tenant.fromMap(maps[i]));
      }
      return tenants;
    } else {
      return null;
    }
  }

  // DELETE THE RECORD OF A TENANT FROM TENANTS TABLE

  Future<int> deleteTenant(int id) async{
    var dbClient = await db;
    return await dbClient.delete(TENANTS_TABLE, where:'$TENANT_ID = ?', whereArgs: [id]);
  }

  // UPDATE THE RECORD OF A PERSON FROM THE PERSONS TABLE

  Future<int> updateTenant(Tenant tenant) async{
    var dbClient = await db;
    return await dbClient.update(TENANTS_TABLE, tenant.toMap(), where: '$TENANT_ID = ?', whereArgs: [tenant.id]);
  }

  // CLOSE THE DATABASE 

  Future close() async{
    var dbClient = await db;
    dbClient.close();
  }

}
