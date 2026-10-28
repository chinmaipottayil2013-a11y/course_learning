import 'dart:convert';
import 'dart:developer';

import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/courses/course_model.dart';
import 'package:learning_course2/models/favourites/favourite_request_model.dart';
import 'package:learning_course2/models/favourites/favourite_response_model.dart';

class FavouritesService {
  final ApiClient _client = ApiClient();

  Future<List<CourseModel>> showFavourites() async {
    final uri = Uri.parse(ApiConstants.showFavouriteUrl);
    final response = await _client.get(uri);
    log('Show status code : ${response.statusCode}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> data = decoded is List ? decoded : decoded['results'];
      log(
        'addToFavourite status: ${response.statusCode} body: ${response.body}',
      );

      return data.map((data) => CourseModel.fromJson(data)).toList();
    } else {
      throw Exception(
        'Failed to fetch favourite products ${response.statusCode}',
      );
    }
  }

  Future<FavoriteResponseModel> addToFavourite({required int courseId}) async {
    final uri = Uri.parse(ApiConstants.addToFavouriteUrl);
    final body = FavoriteRequestModel(courseId: courseId);

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
      body: jsonEncode(body.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return FavoriteResponseModel.fromJson(data);
    }
    throw Exception('Failed to fave courses');
  }
}
