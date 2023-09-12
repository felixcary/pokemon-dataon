import 'package:flutter/material.dart';
import 'package:pokemon/models/user_model.dart';
import 'package:pokemon/services/database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final DatabaseService databaseService;

  AuthProvider({
    required this.databaseService,
  }) : super();

  String name = '';
  String email = '';
  String password = '';
  String token = '';
  String warningMessage = '';

  Future<void> saveUserDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', email);
  }

  Future<void> getUserDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    notifyListeners();
  }

  Future<void> saveUserToDatabase() async {
    warningMessage = '';
    final newUser = UserModel(
      name: name,
      email: email,
      password: password,
      avatar: '',
    );
    await databaseService.insertUser(newUser);
    notifyListeners();
  }

  void setWarningMessage() {
    warningMessage = 'Wrong Email/Password, please retry';
    notifyListeners();
  }

  Future<UserModel?> getUserFromDatabase() async {
    warningMessage = '';
    final userModel = await databaseService.getUserByEmail(email);
    notifyListeners();
    return userModel;
  }
}
