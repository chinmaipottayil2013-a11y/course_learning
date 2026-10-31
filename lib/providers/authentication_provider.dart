import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_course2/models/authentication/authentication_model.dart';
import 'package:learning_course2/services/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isObscure = true;
  final AuthenticationService _authService = AuthenticationService();
  AuthenticationModel? model;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  String name = '';
  String email = '';

  bool get isObscure => _isObscure;
  void showPassword() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  AuthenticationProvider() {
    loadUser();
  }

  // Method to load User Datas (name,email)
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');

    if (userData == null) return;

    try {
      final decodedData = jsonDecode(userData);
      model = AuthenticationModel.fromJson({'user_data': decodedData});
      notifyListeners();
    } catch (_) {
      prefs.remove('user_data');
    }
  }
  //

  Future<bool> login() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (result != null) {
      emailController.clear();
      passwordController.clear();
      model = result;
      // Method to load User Datas
      final user = result.userData;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'user_data',
        jsonEncode({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'username': user.username,
          'profile_picture': user.profilePicture,
          'role': user.role,
          'user_type': user.userType,
        }),
      );

      isLoading = false;
      notifyListeners();
      return true;
    } else {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    return await _authService.loggedIn();
  }

  Future<String?> getAcessToken() async {
    return await _authService.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _authService.getRefreshToken();
  }

  Future<void> logout() async {
    await _authService.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    model = null;
    notifyListeners();
  }
}
