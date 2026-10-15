import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_course2/models/authentication/authentication_model.dart';
import 'package:learning_course2/services/authentication_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isObscure = true;
  final AuthenticationService _authService = AuthenticationService();
  AuthenticationModel? model;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  bool get isObscure => _isObscure;
  void showPassword() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<bool> login() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (result != null) {
      model = result;
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
    model = null;
    notifyListeners();
  }
}
