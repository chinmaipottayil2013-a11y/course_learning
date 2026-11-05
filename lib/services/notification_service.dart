import 'dart:convert';

import 'package:learning_course2/core/constants/api_constants.dart';
import 'package:learning_course2/core/constants/network/auth_http_client.dart';
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/models/notifciations/notification_delete_request_model.dart';
import 'package:learning_course2/models/notifciations/notification_response_model.dart';

class NotificationService {
  final ApiClient _client = ApiClient();

  Future<NotificationResponseModel> getNotifications({
    int? page,
    int? pageSize,
  }) async {
    final uri = Uri.parse(ApiConstants.notificationsUrl).replace(
      queryParameters: {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      },
    );

    final response = await _client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> notifcationData = jsonDecode(response.body);
      return NotificationResponseModel.fromJson(notifcationData);
    } else {
      throw Exception('Failed to fetch notifications ${response.statusCode}');
    }
  }

  Future<NotificationResponseModel> deleteNotification({
    required String notificationId,
  }) async {
    final uri = Uri.parse(ApiConstants.deleteNotification);

    final request = NotificationDeleteRequestModel(
      notificationId: notificationId,
    );
    final response = await _client.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StringConstants.accessToken}',
      },
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NotificationResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to delete notification : ${response.statusCode}');
    }
  }
}
