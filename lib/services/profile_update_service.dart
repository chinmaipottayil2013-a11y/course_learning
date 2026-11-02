import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/models/profile/user_profile_model.dart';

class ProfileUpdateService {
  final ApiClient _client = ApiClient();

  Future<http.Response> send(String name, File? image) async {
    final request = http.MultipartRequest(
      'PATCH',
      Uri.parse(ApiConstants.profileUpdateUrl),
    );
    request.fields['name'] = name;
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_picture', image.path),
      );
    }
    final streamed = await _client.send(request);
    return http.Response.fromStream(streamed);
  }

  Future<UserProfileModel?> updateProfile({
    required String name,
    File? image,
  }) async {
    try {
      var response = await send(name, image);

      if (response.statusCode == 401) {
        log('Profile update got 401, retrying with refreshed token...');
        response = await send(name, image);
      }
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return UserProfileModel.fromJson(data);
      }
      throw Exception(
        'Failed to update profile : ${response.statusCode}-${response.body}',
      );
    } catch (e, st) {
      log('Profile update service error : $e', stackTrace: st);
      rethrow;
    }
  }
}
