import 'package:db_miner/view/screens/detail_page/detail_page.dart';
import 'package:db_miner/view/screens/home_page/home_page.dart';
import 'package:db_miner/view/screens/splash_screens/splash_screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  String splashScreen = '/';
  String homePage = 'home_page';
  String detailPage = 'detail_page';

  Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    'home_page': (context) => const HomePage(),
    'detail_page': (context) => const DetailPage(),
  };

  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();
}
