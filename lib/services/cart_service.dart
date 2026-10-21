import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/models/cart/cart_model.dart';
import 'package:learning_course2/models/cart/remove_from_cart_model.dart';

class CartService {
  final ApiClient _client = ApiClient();

  Future<CartModel> getCourses(int regionId, [BuildContext? context]) async {
    final uri = Uri.parse(
      ApiConstants.cartUrl,
    ).replace(queryParameters: {'region_id': regionId.toString()});

    final response = await _client.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CartModel.fromJson(data);
    } else {
      throw Exception('Failed to load courses: ${response.statusCode}');
    }
  }

  // COURSE TO CART ADDING SERVICE
  Future<bool> addCourse({
    required int courseId,
    required int region,
    required String currency,
  }) async {
    final uri = Uri.parse(ApiConstants.addToCarUrl);
    final body = {'course_id': courseId, 'region': region};

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  // Delete from Cart Service
  Future<RemoveFromCartResponseModel> removeFromCart({
    required int courseId,
    required int region,
  }) async {
    final uri = Uri.parse(ApiConstants.deleteFromCart);
    final request = RemoveFromCartRequestModel(
      courseId: courseId,
      region: region,
    );
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return RemoveFromCartResponseModel.fromJson(data);
    }
    throw Exception('Failed to remove from cart ${response.statusCode}');
  }
}
