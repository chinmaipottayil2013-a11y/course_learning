import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:http/http.dart' as apiclient;
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/course_response_mode.dart';

import 'package:learning_course2/models/filters_model.dart';
import 'package:learning_course2/screens/screen_login.dart';

class CourseListService {
  Future<CourseResponseModel> getCourseList({
    required BuildContext context,
    int? page,
    int? pageSize,
    String? searchQuery,
    String? types,
    String? categoryId,
    String? levelId,
    String? region,
    String? industryId,
    String? languageId,
    String? duration,
    String? rating,
    String? price,
    bool? freeCourse,
    String? sortBy,
  }) async {
    final uri = Uri.parse(
      ApiConstants.courseListUrl,
    ).replace(queryParameters: {if (page != null) 'page': page.toString()});

    final Map<String, dynamic> body = {
      'region': "3",
      if (pageSize != null) 'page_size': pageSize.toString(),
      if (searchQuery != null && searchQuery.isNotEmpty)
        'search_query': searchQuery,
      if (types != null && types.isNotEmpty) 'types': types,
      if (categoryId != null && categoryId.isNotEmpty)
        'category_id': categoryId,
      if (levelId != null && levelId.isNotEmpty) 'level_id': levelId,
      if (region != null && region.isNotEmpty) 'region': region,
      if (industryId != null && industryId.isNotEmpty)
        'industry_id': industryId,
      if (languageId != null && languageId.isNotEmpty)
        'language_id': languageId,
      if (duration != null && duration.isNotEmpty) 'duration': duration,
      if (rating != null && rating.isNotEmpty) 'rating': rating,
      if (price != null && price.isNotEmpty) 'price': price,
      'free_course': ?freeCourse,
      if (sortBy != null && sortBy.isNotEmpty) 'sort_by': sortBy,
    };

    log('url is : $uri');
    log('request body : ${jsonEncode(body)}');

    final response = await apiclient.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${StringConstants.accessToken}',
      },

      body: jsonEncode(body),
    );

    log('Request URL: $uri');
    log('Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');
    log('Response Headers: ${response.headers}');

    // log('response body : ${response.body}');
    // log('status code : ${response.statusCode}');

    if (response.statusCode == 404 && page != 1) {
      return CourseResponseModel(
        count: 0,
        next: null,
        previous: null,
        results: [],
      );
    }

    if (response.statusCode == 401) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ScreenLogin()),
      );
    }

    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      return CourseResponseModel.fromJson(datas);
    } else {
      throw Exception('Failed to load datas :${response.statusCode}');
    }
  }

  Future<FiltersOptionsModel> getFilters() async {
    final uri = Uri.parse(ApiConstants.courseListUrl);
    final response = await apiclient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // log('Response of filters : ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return FiltersOptionsModel.fromJson(data);
    }
    throw Exception('Failed to load courses: ${response.statusCode}');
  }
}
