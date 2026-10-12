class RemoveFromCartRequestModel {
  final int courseId;
  final int region;

  RemoveFromCartRequestModel({required this.courseId, required this.region});

  factory RemoveFromCartRequestModel.fromJson(Map<String, dynamic> json) {
    return RemoveFromCartRequestModel(
      courseId: json['course_id'],
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'course_id': courseId, 'region': region};
  }
}

class RemoveFromCartResponseModel {
  final String message;

  RemoveFromCartResponseModel({required this.message});

  factory RemoveFromCartResponseModel.fromJson(Map<String, dynamic> json) {
    return RemoveFromCartResponseModel(message: json['message'] ?? '');
  }
}
