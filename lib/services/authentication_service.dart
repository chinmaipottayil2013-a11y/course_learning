import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as apiclient;
import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/authentication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  Future<AuthenticationModel?> login(String email, String password) async {
    try {
      final response = await apiclient.post(
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

  Future<bool> refreshAccessToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        log('Refresh token is empty');
        return false;
      }
      final response = await http.post(
        Uri.parse(ApiConstants.refreshUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['access_token']?.toString() ?? '';
        final newRefreshToken = data['refresh_token']?.toString();

        if (newAccessToken.isEmpty) {
          return false;
        }
        await _saveTokens(
          newAccessToken,
          newRefreshToken?.isNotEmpty == true ? newRefreshToken! : refreshToken,
        );
        return true;
      }
      return false;
    } catch (e) {
      log('Token refresh error : $e');
      return false;
    }
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();

    StringConstants.accessToken = accessToken;
    StringConstants.refreshToken = refreshToken;

    await prefs.setString("accessToken", accessToken);

    await prefs.setString("refreshToken", refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("accessToken");
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

    await prefs.clear();
  }
}
