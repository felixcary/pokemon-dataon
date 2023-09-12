import 'package:flutter/material.dart';
import 'package:pokemon/models/user_model.dart';
import 'package:pokemon/services/database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  final DatabaseService databaseService;

  ProfileProvider({
    required this.databaseService,
  }) : super();

  String token = '';
  String warningMessage = '';
  UserModel? userModel;

  Future<void> deleteUserDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();
  }

  Future<void> getUserDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    notifyListeners();
  }

  Future<void> getUserFromDatabase() async {
    await getUserDummyToken();
    userModel = await databaseService.getUserByEmail(token);
    notifyListeners();
  }

  void setWarningMessage() {
    warningMessage = 'Password not match';
    notifyListeners();
  }

  Future<void> updateUser({required String newName}) async {
    await databaseService.updateProfile(
      newName: newName,
      id: userModel!.id!,
    );
    getUserFromDatabase();
  }
}
