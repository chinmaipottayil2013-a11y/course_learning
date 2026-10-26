class RegionCurrencyModel {
  final int regionId;
  final String currency;

  RegionCurrencyModel({required this.regionId, required this.currency});

  factory RegionCurrencyModel.fromJson(Map<String, dynamic> json) {
    return RegionCurrencyModel(
      regionId: json['region_id'] as int,
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'region_id': regionId, 'currency': currency};
  }
}
