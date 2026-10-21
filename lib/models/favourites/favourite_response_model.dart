class FavoriteResponseModel {
  final String message;

  FavoriteResponseModel({required this.message});

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    return FavoriteResponseModel(message: json['message'] as String? ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
