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
    final uri = Uri.parse(ApiConstants.paymentUrl);
    final body = {'region_id': regionId, 'currency': currency};
    log('Create order URL : $uri');
    log(
      'Create order body : ${jsonEncode(body)}',
    ); // check region_id is not null

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    log(
      'Create order ${response.statusCode} : ${response.body}',
    ); // real server reply

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = jsonDecode(response.body);
        return PaymentResponseModel.fromJson(data);
      } catch (e, st) {
        // fires if a field is missing/null/wrong type in the response
        log('Create order PARSE ERROR : $e', error: e, stackTrace: st);
        rethrow;
      }
    } else {
      throw Exception('Failed to do payment ${response.statusCode}');
    }
  }
}
