class RegionSelectionModel {
  final int id;
  final String name;
  final String countryCode;
  final String languageCode;
  final String currency;
  final String? currencySymbol;
  final double exchangeRate;
  final bool isActive;

  RegionSelectionModel({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.languageCode,
    required this.currency,
    this.currencySymbol,
    required this.exchangeRate,
    required this.isActive,
  });

  factory RegionSelectionModel.fromJson(Map<String, dynamic> json) {
    return RegionSelectionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      countryCode: json['country_code'] as String,
      languageCode: json['language_code'] as String,
      currency: json['currency'] as String,
      currencySymbol: json['currency_symbol'] as String?,
      exchangeRate: (json['exchange_rate'] as num).toDouble(),
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_code': countryCode,
      'language_code': languageCode,
      'currency': currency,
      'currency_symbol': currencySymbol,
      'exchange_rate': exchangeRate,
      'is_active': isActive,
    };
  }
}
