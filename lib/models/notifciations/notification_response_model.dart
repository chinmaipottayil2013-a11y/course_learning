import 'notification_model.dart';

class NotificationResponseModel {
  int unreadCount;
  final List<NotificationModel> notifications;
  final int count;
  final String? next;
  final String? previous;

  NotificationResponseModel({
    required this.unreadCount,
    required this.notifications,
    required this.count,
    this.next,
    this.previous,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      unreadCount: json['unread_count'] ?? 0,

      notifications: (json['notifications'] as List? ?? [])
          .map((e) => NotificationModel.fromJson(e))
          .toList(),

      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unread_count': unreadCount,
      'notifications': notifications.map((e) => e.toJson()).toList(),
      'count': count,
      'next': next,
      'previous': previous,
    };
  }
}
