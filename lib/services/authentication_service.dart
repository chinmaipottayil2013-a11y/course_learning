import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as apiclient;
import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/authentication/authentication_model.dart';
import 'package:learning_course2/models/authentication/token_refresh_request_model.dart';
import 'package:learning_course2/models/authentication/token_refresh_response_model.dart';
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
      final currentRefreshToken = await getRefreshToken();
      if (currentRefreshToken == null || currentRefreshToken.isEmpty) {
        log('Refresh token is empty');
        return false;
      }
      log('Refreshing token using: ${ApiConstants.refreshUrl}');

      final requestModel = TokenRefreshRequestModel(
        refresh: currentRefreshToken,
      );
      final response = await http.post(
        Uri.parse(ApiConstants.refreshUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      log(
        'Refresh response code: ${response.statusCode}, body: ${response.body}',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        final refreshResponse = TokenRefreshResponseModel.fromJson(data);

        if (refreshResponse.access.isEmpty) {
          log('Refresh failed: new access token is empty');
          return false;
        }

        final newRefreshToken =
            (refreshResponse.refresh != null &&
                refreshResponse.refresh!.isNotEmpty)
            ? refreshResponse.refresh!
            : currentRefreshToken;

        await _saveTokens(refreshResponse.access, newRefreshToken);
        log('Token refreshed and saved successfully');
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

    await prefs.remove("accessToken");
    await prefs.remove("refreshToken");

    await prefs.clear();
    StringConstants.accessToken = '';
    StringConstants.refreshToken = '';
  }
}
