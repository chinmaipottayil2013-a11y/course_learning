class TokenRefreshResponseModel {
  final String access;
  final String? refresh;

  TokenRefreshResponseModel({
    required this.access,
    this.refresh,
  });

  factory TokenRefreshResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenRefreshResponseModel(
      access: (json['access'] ?? json['access_token'] ?? '') as String,
      refresh: (json['refresh'] ?? json['refresh_token']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      if (refresh != null) 'refresh': refresh,
    };
  }
}

