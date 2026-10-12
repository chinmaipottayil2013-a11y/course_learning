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

class AddToCartResponseModel {
  final String message;
  final int courseId;
  final bool isCartAdded;

  AddToCartResponseModel({
    required this.message,
    required this.courseId,
    required this.isCartAdded,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddToCartResponseModel(
      message: json['message'] ?? '',
      courseId: json['course_id'] ?? 0,
      isCartAdded: json['is_cart_added'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'course_id': courseId,
      'is_cart_added': isCartAdded,
    };
  }
}
