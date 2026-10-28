import 'dart:convert';
import 'dart:developer';

import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/models/payments/payment_response_model.dart';

class PaymentApiService {
  final ApiClient _client = ApiClient();

  Future<PaymentResponseModel> createOrder({
    int? regionId,
    String? currency,
  }) async {
    // Stop early instead of sending a request the backend will reject
    if (regionId == null) {
      log('createOrder called with regionId = null (caller is not passing it)');
      throw Exception('Region is missing. Please select a region.');
    }

    final uri = Uri.parse(ApiConstants.paymentUrl);
    final body = {'region_id': regionId, 'currency': currency ?? 'INR'};
    log('Create order URL : $uri');
    log('Create order body : ${jsonEncode(body)}');

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    log('Create order ${response.statusCode} : ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = jsonDecode(response.body);
        return PaymentResponseModel.fromJson(data);
      } catch (e, st) {
        log('Create order PARSE ERROR : $e', error: e, stackTrace: st);
        rethrow;
      }
    } else {
      throw Exception('Failed to do payment ${response.statusCode}');
    }
  }
}
