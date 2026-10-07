import 'dart:convert';

import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/models/course_details_model.dart';
import 'package:http/http.dart' as http;

class CourseDetailsService {
  Future<CourseDetailsModel> getCourseDetails(String slug) async {
    final uri = Uri.parse('${ApiConstants.detailsUrl}$slug/');
    final response = await http.get(uri);
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
