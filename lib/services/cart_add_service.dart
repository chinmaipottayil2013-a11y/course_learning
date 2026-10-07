import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/add_to_cart_model.dart';

class CartAddService {
  Future<AddToCartRequestModel> addCourse({
    required int courseId,
    required int region,
  }) async {
    log("course id is $courseId");
    final uri = Uri.parse(ApiConstants.addToCarUrl);

    final body = {'course_id': courseId, 'region': region};

    log("add to cart service calling");
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (StringConstants.accessToken != "" &&
            StringConstants.accessToken.isNotEmpty)
          'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
      body: jsonEncode(body),
    );

    log("add to cart response code is ${response.statusCode}");
    log("add to cart response is ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      log("add to cart response is ${response.body}");
      return AddToCartRequestModel.fromJson(data);
    }
    throw Exception('Failed to add course : ${response.statusCode}');
  }
}
