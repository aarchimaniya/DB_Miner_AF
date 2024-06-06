import 'package:db_miner/Services/quotes_dbminer_create.dart';
import 'package:db_miner/controller/dbminer_controller.dart';
import 'package:db_miner/controller/json_data_controller.dart';
import 'package:db_miner/modal/theme_controller.dart';
import 'package:db_miner/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbServices.dbServices.initDb();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DbController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyQuotes(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
