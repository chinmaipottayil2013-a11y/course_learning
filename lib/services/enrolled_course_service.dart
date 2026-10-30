import 'dart:convert';
import 'dart:developer';

import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/models/enrolled_courses/enrolled_response_model.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';

class EnrolledCourseService {
  final ApiClient _client = ApiClient();

  Future<EnrolledCoursesResponseModel> getEnrolledCourses({
    String? status,
    String? search,
    int? page,
    int? pageSize,
  }) async {
    final uri = Uri.parse(ApiConstants.enrolledCourses).replace(
      queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
        if (search != null && search.isNotEmpty) 'search': search,
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      },
    );

    final response = await _client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      log('Response body:${response.body}');
      final Map<String, dynamic> jsonData =
          jsonDecode(response.body) as Map<String, dynamic>;

      return EnrolledCoursesResponseModel.fromJson(jsonData);
    } else {
      throw Exception(
        'Failed to fetch enrolled courses. '
        'Status code: ${response.statusCode}, '
        'Response: ${response.body}',
      );
    }
  }
}
