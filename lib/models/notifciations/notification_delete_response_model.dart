class NotificationDeleteResponseModel {
  final String message;

  NotificationDeleteResponseModel({required this.message});

  factory NotificationDeleteResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationDeleteResponseModel(message: json['message'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
