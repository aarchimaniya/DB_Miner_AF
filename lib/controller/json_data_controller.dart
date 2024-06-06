import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MyQuotes extends ChangeNotifier {
  List allData = [];

  MyQuotes() {
    loadJSON();
  }

  Future<void> loadJSON() async {
    String data = await rootBundle.loadString("lib/assets/quotes_data.json");
    List jsonResult = jsonDecode(data);

    allData = jsonResult.map((e) => e).toList();
    notifyListeners();
  }
}
