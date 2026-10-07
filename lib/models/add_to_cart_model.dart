class AddToCartRequestModel {
  final int courseId;
  final int region;

  AddToCartRequestModel({required this.courseId, required this.region});

  factory AddToCartRequestModel.fromJson(Map<String, dynamic> json) {
    return AddToCartRequestModel(
      courseId: json['course_id'],
      region: json['region'],
    );
  }
}
