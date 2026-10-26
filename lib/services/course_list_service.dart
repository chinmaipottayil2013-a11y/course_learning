import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/models/courses/course_response_model.dart';
import 'package:learning_course2/models/courses/filters_model.dart';
import 'package:learning_course2/models/courses/region_selection_model.dart';

class CourseListService {
  final ApiClient _client = ApiClient();

  Future<CourseResponseModel> getCourseList({
    BuildContext? context,
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

    // log('url is : $uri');
    // log('request body : ${jsonEncode(body)}');

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 404 && page != 1) {
      return CourseResponseModel(
        count: 0,
        next: null,
        previous: null,
        results: [],
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
    final response = await _client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return FiltersOptionsModel.fromJson(data);
    }
    throw Exception('Failed to load courses: ${response.statusCode}');
  }

  Future<List<RegionSelectionModel>> getListByRegion() async {
    final uri = Uri.parse(ApiConstants.courseByRegionUrl);
    final response = await _client.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((data) => RegionSelectionModel.fromJson(data)).toList();
    }
    throw Exception('Failed to load region data ${response.statusCode}');
  }
}
