import 'dart:async';

import 'package:db_miner/Routes/quotesdb_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacementNamed(context, AppRoutes.instance.homePage);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    changeScreen(context);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("lib/assets/image/category/thoughtgif.png.gif"),
          fit: BoxFit.fitWidth,
        )),
      ),
    );
  }
}
