import 'package:sqflite/sqflite.dart';
import 'dart:io'as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'cart_model.dart';

class DataBaseHelper
{
  static Database? _db;


  Future<Database?> get db async
  {
    if(_db!=null) {
      return _db;
    }
    _db =await initDatabase();
    return null;
  }
  initDatabase() async
  {
    io.Directory documentDirectory=await getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path,'cart.db');
    var db=await  openDatabase(path,version: 1,onCreate:_onCreate );
    return db;
  }
  _onCreate(Database db,int version)async
  {
   await db.execute('CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER, unitTag TEXT , image TEXT )');


  }
  Future<Cart> insert(Cart cart)async
  {
   print(cart.toMap());
    var dbClient=await db;
   await dbClient!.insert('cart',cart.toMap());
   return cart;
  }
  Future<List<Cart>> getCartList()async
  {
    var dbClient=await db;
    final List<Map<String,Object?>> queryResult=await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();

  }
  Future<int> delete(int id)async{
    var dbClient=await db;
    return dbClient!.delete('cart',where:'id=?' ,whereArgs:[id]);
    
      }
  Future<int> updateQuantity(Cart cart)async{
    var dbClient=await db;
    return dbClient!.update('cart',
        cart.toMap(),
        where:'id=?' ,whereArgs:[cart.id]);

  }
}