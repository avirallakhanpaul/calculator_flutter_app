import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {

  SharedPreferences _prefs;
  final themeKey = "isdarkTheme";
  
  bool _isDarkTheme;
  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _isDarkTheme = false;
    _loadFromPrefs();
    print("loading from prefs");
  }

  Future<void> _initPrefs() async {
    if(_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
      print("prefs initiated");
    } else {
      return;
    }
  }

  void _loadFromPrefs() async {
    await _initPrefs();
    _isDarkTheme = _prefs.getBool(themeKey) ?? false;
    print("value loaded from prefs");
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _initPrefs();
    _prefs.setBool(themeKey, _isDarkTheme);
    print("theme toggle done");
    notifyListeners();
  }
}