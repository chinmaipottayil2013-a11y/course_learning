class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String message;
  final String types;
  final String platform;
  final String? image;
  final bool isSeen;
  final String? seenAt;
  final String createdDate;
  final dynamic careerOpening;
  final dynamic institutionEvent;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.message,
    required this.types,
    required this.platform,
    this.image,
    required this.isSeen,
    this.seenAt,
    required this.createdDate,
    this.careerOpening,
    this.institutionEvent,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      message: json['message'] ?? '',
      types: json['types'] ?? '',
      platform: json['platform'] ?? '',
      image: json['image'],
      isSeen: json['is_seen'] ?? false,
      seenAt: json['seen_at'],
      createdDate: json['created_date'] ?? '',
      careerOpening: json['career_opening'],
      institutionEvent: json['institution_event'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'message': message,
      'types': types,
      'platform': platform,
      'image': image,
      'is_seen': isSeen,
      'seen_at': seenAt,
      'created_date': createdDate,
      'career_opening': careerOpening,
      'institution_event': institutionEvent,
    };
  }
}
