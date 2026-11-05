class NotificationDeleteRequestModel {
  final String notificationId;

  NotificationDeleteRequestModel({required this.notificationId});

  Map<String, dynamic> toJson() {
    return {'notification_id': notificationId};
  }
}
