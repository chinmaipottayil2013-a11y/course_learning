import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/add_to_cart_model.dart';

class CartAddService {
  Future<AddToCartRequestModel> addCourse({int? courseId, int? region}) async {
    final uri = Uri.parse(ApiConstants.addToCarUrl).replace(
      queryParameters: {
        if (courseId != null) 'course_id': courseId.toString(),
        if (region != null) 'region': region.toString(),
      },
    );
    final response = await http.post(
      uri,
      headers: {
        if (StringConstants.accessToken != "" &&
            StringConstants.accessToken.isNotEmpty)
          'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return AddToCartRequestModel.fromJson(data);
    }
    throw Exception('Failed to add course : ${response.statusCode}');
  }
}
