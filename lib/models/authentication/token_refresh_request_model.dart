class TokenRefreshRequestModel {
  final String refresh;

  TokenRefreshRequestModel({required this.refresh});

  factory TokenRefreshRequestModel.fromJson(Map<String, dynamic> json) {
    return TokenRefreshRequestModel(refresh: json['refresh'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'refresh': refresh};
  }
}
