import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/cart_model.dart';

class CartService {
  Future<CartModel> getCourses(int regionId) async {
    final uri = Uri.parse(
      ApiConstants.cartUrl,
    ).replace(queryParameters: {'region_id': regionId.toString()});
    final response = await http.get(
      uri,
      headers: {
        if (StringConstants.accessToken != "" &&
            StringConstants.accessToken.isNotEmpty)
          'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CartModel.fromJson(data);
    } else {
      throw Exception('Failed to load prodcuts');
    }
  }
}
