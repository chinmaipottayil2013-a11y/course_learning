import 'dart:convert';
import 'dart:developer';

import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/checkout_page/order_response_model.dart';
import 'package:learning_course2/models/checkout_page/verify_payment_model.dart';

class CheckoutService {
  final ApiClient _client = ApiClient();

  Future<OrderResponseModel> verifyPayment({
    required VerifyPaymentRequestModel verify,
  }) async {
    final uri = Uri.parse(ApiConstants.verifyPayment);
    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
      body: jsonEncode(verify.toJson()),
    );
    log('verify status: ${response.statusCode}, body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return OrderResponseModel.fromJson(data);
      }
    }
    throw Exception('Payment verification failed : ${response.statusCode}');
  }
}
