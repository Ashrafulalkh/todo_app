import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/models/user/user_model.dart';

class AuthController {
  static String? accessToken;

  final String _accessTokenKey = 'token';

  Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }


  Future<bool> checkAuthState() async {
    accessToken ??= await getAccessToken();
    return accessToken != null;
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  Future<void> saveUserData(UserModel? user) async {

    final prefs = await SharedPreferences.getInstance();
    // Convert UserModel to JSON string
    String userJson = jsonEncode(user?.toJson());
    // Save JSON string to SharedPreferences
    await prefs.setString('user_data', userJson);
  }

  Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user_data');
    if (userJson != null) {
      // Convert JSON string back to UserModel
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }



}