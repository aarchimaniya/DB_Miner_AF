import 'package:db_miner/modal/dbminer_modal.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';

enum QuotesTable { quote, authore, category }

class DbServices {
  DbServices._();
  static final DbServices dbServices = DbServices._();

  Logger logger = Logger();

  String sql = "";
  String dbName = 'quotes_data.db';
  String tableName = 'Users';

  late Database database;

  Future<void> initDb() async {
    String path = await getDatabasesPath();
    database = await openDatabase(
      "$path/$dbName",
      version: 1,
      onCreate: (db, version) {
        String createTableQuery = '''
              CREATE TABLE IF NOT EXISTS Quotes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              quote TEXT NOT NULL,
              author TEXT ,
              category TEXT NOT NULL
  );
''';

        db
            .execute(createTableQuery)
            .then((value) => logger.i("Table created successfully..."))
            .onError((error, stackTrace) => logger.e("ERROR :$error"));
      },
      onUpgrade: (db, v1, v2) {},
      onDowngrade: (db, v1, v2) {},
    );
  }

  void insertData({required QuoteData user}) {}
  void updatData({required QuoteData user}) {}
  void deleteData({required QuoteData user}) {}

  Future<List<QuoteData>> getAllData() async {
    List<QuoteData> allUser = [];
    sql = "select * from $tableName;";
    List Data = await database.rawQuery(sql);
    allUser = Data.map((e) => QuoteData.fromSQL(e)).toList();
    return allUser;
  }
}
