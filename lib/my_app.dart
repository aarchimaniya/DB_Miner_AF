import 'package:db_miner/Routes/quotesdb_routes.dart';
import 'package:db_miner/modal/theme_controller.dart';
import 'package:db_miner/view/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.instance.routes,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFF75A47F),
        appBarTheme: const AppBarTheme(
          foregroundColor: Color(0xFF9AC8CD),
          backgroundColor: Color(0xFF77B0AA),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleSpacing: 1,
        ),
      ),
      themeMode: Provider.of<ThemeController>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      // routes: AppRoutes.route,
    );
  }
}
