import 'package:db_miner/Services/quotes_dbminer_create.dart';
import 'package:db_miner/modal/dbminer_modal.dart';
import 'package:flutter/material.dart';

class DbController extends ChangeNotifier {
  List<QuoteData> allQuotesData = [];

  DbController() {
    initData();
  }

  Future<void> initData() async {
    DbServices.dbServices.initDb();
    allQuotesData = await DbServices.dbServices.getAllData();
    notifyListeners();
  }
}
