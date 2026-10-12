import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/cart/cart_model.dart';
import 'package:learning_course2/models/cart/remove_from_cart_model.dart';
import 'package:learning_course2/screens/login_screen.dart';

class CartService {
  Future<CartModel> getCourses(int regionId, BuildContext context) async {
    final uri = Uri.parse(
      ApiConstants.cartUrl,
    ).replace(queryParameters: {'region_id': regionId.toString()});

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${StringConstants.accessToken}'},
    );
    // log('Token :  ${StringConstants.accessToken}');
    // log('status code :${response.statusCode}');
    // log('response body : ${response.body}');
    if (response.statusCode == 401) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return CartModel.fromJson(data);
    } else {
      throw Exception('Failed to load courses');
    }
  }

  //COURSE TO CART ADDING SERVICE

  Future<bool> addCourse({required int courseId, required int region}) async {
    // log("course id is $courseId");
    final uri = Uri.parse(ApiConstants.addToCarUrl);

    final body = {'course_id': courseId, 'region': region};

    // log("add to cart service calling");
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

    // log("add to cart response code is ${response.statusCode}");
    // log("add to cart response is ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // log("add to cart response is ${response.body}");
      return true;
    } else {
      return false;
    }
    // throw Exception('Failed to add course : ${response.statusCode}');
  }

  //Delete from Cart Service

  Future<RemoveFromCartResponseModel> removeFromCart({
    required int courseId,
    required int region,
  }) async {
    final uri = Uri.parse(ApiConstants.deleteFromCart);
    final request = RemoveFromCartRequestModel(
      courseId: courseId,
      region: region,
    );
    final response = await http.post(
      uri,

      headers: {
        'Content-Type': 'application/json',
        if (StringConstants.accessToken != "" &&
            StringConstants.accessToken.isNotEmpty)
          'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return RemoveFromCartResponseModel.fromJson(data);
    }
    throw Exception('Failed to remove from cart ${response.statusCode}');
  }
}
