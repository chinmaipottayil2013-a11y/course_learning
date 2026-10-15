import 'dart:convert';

import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/models/courses/course_details_model.dart';

class CourseDetailsService {
  final ApiClient _client = ApiClient();

  Future<CourseDetailsModel> getCourseDetails(String slug) async {
    final uri = Uri.parse('${ApiConstants.detailsUrl}$slug/');
    final response = await _client.get(
      uri,
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      final data = datas['Datas'] ?? datas['data'] ?? datas;

      if (data is Map<String, dynamic>) {
        return CourseDetailsModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch data $data');
      }
    } else {
      throw Exception('Failed to load products : ${response.body}');
    }
  }
}
