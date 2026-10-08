import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/authentication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  Future<AuthenticationModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final authenticationModel = AuthenticationModel.fromJson(data);

        if (authenticationModel.accessToken.isEmpty) {
          return null;
        }

        if (authenticationModel.refreshToken.isEmpty) {
          return null;
        }

        await _saveTokens(
          authenticationModel.accessToken,
          authenticationModel.refreshToken,
        );

        return authenticationModel;
      }

      try {
        final data = jsonDecode(response.body);

        log('Login Error: ${data['message'] ?? 'Login failed'}');
      } catch (e) {
        log('Could not decode error response');
      }

      return null;
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();

    StringConstants.accessToken = accessToken;
    StringConstants.refreshToken = refreshToken;

    await prefs.setString("acessToken", accessToken);

    await prefs.setString("refreshToken", refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("acessToken");
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken");
  }

  Future<bool> loggedIn() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      StringConstants.accessToken = accessToken;
      StringConstants.refreshToken = refreshToken;
    }

    return accessToken != null &&
        accessToken.isNotEmpty &&
        refreshToken != null &&
        refreshToken.isNotEmpty;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(StringConstants.accessToken);
    await prefs.remove(StringConstants.refreshToken);
  }
}
