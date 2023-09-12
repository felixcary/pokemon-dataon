import 'package:flutter/material.dart';
import 'package:pokemon/models/user_model.dart';
import 'package:pokemon/services/database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewProvider extends ChangeNotifier {
  final DatabaseService databaseService;

  AuthViewProvider({
    required this.databaseService,
  }) : super();

  String email = '';
  String password = '';
  String token = '';
  String warningMessage = '';

  Future<void> saveUserDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'loggedin');
  }

  Future<void> getUserDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    notifyListeners();
  }

  Future<void> deleteUserDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();
  }

  Future<void> saveUserToDatabase() async {
    warningMessage = '';
    final newUser = UserModel(email: email, password: password);
    await databaseService.insertUser(newUser);
    notifyListeners();
  }

  Future<UserModel?> getUserFromDatabase() async {
    warningMessage = '';
    final userModel = await databaseService.getUserByEmail(email);
    notifyListeners();
    return userModel;
  }
}