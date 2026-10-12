class LastViewedLectureModel {
  final dynamic id;
  final String name;
  final String types;
  final int orderBy;
  final String titleName;
  final String createdAt;
  final String? videoUrl;

  LastViewedLectureModel({
    required this.id,
    required this.name,
    required this.types,
    required this.orderBy,
    required this.titleName,
    required this.createdAt,
    required this.videoUrl,
  });

  factory LastViewedLectureModel.fromJson(Map<String, dynamic> json) {
    return LastViewedLectureModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      types: json['types'] ?? '',
      orderBy: json['order_by'] ?? 0,
      titleName: json['title_name'] ?? '',
      createdAt: json['created_at'] ?? '',
      videoUrl: json['video_url'],
    );
  }
}
