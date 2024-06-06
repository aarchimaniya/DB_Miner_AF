import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  // State
  bool isDark = false;
  // Behaviours
  void getTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
