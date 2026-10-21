class FavoriteRequestModel {
  final int courseId;

  FavoriteRequestModel({required this.courseId});

  factory FavoriteRequestModel.fromJson(Map<String, dynamic> json) {
    return FavoriteRequestModel(courseId: json['course_id'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'course_id': courseId};
  }
}
