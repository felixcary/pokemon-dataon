import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewProvider extends ChangeNotifier {
  String email = '';

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    notifyListeners();
  }

  Future<void> deleteUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    notifyListeners();
  }
}
