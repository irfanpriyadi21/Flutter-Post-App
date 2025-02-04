import 'package:mobile_pos_app/data/models/response/product_response_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();

  static final ProductLocalDatasource instance = ProductLocalDatasource._init();

  final String tableProducts = 'products';
  static Database? _database;

  Future<Database> _initDB(String filePath)async{
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version)async{
    await db.execute( '''
          CREATE TABLE $tableProducts (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT,
            description TEXT,
            price INTEGER,
            image TEXT,
            category TEXT,
            createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )
          ''');
  }

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('post1.db');
    return _database!;
  }

  //remove all data Product
  Future<void> removeAllProduct()async{
    final db = await instance.database;
    await db.delete(tableProducts);
  }

  //insert data product from list product
  Future<void> insertProduct(List<Product> products)async{
    final db = await instance.database;
    for(var product in products){
      await db.insert(tableProducts, product.toJson());
    } 
  }
}