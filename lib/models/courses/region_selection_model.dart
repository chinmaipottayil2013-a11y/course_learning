class RegionResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<RegionSelectionModel> results;

  RegionResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory RegionResponseModel.fromJson(Map<String, dynamic> json) {
    return RegionResponseModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List<dynamic>?)
              ?.map((item) => RegionSelectionModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((item) => item.toJson()).toList(),
    };
  }
}

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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      countryCode: json['country_code'] ?? '',
      languageCode: json['language_code'] ?? '',
      currency: json['currency'] ?? '',
      currencySymbol: json['currency_symbol'],
      exchangeRate: (json['exchange_rate'] as num?)?.toDouble() ?? 0.0,
      isActive: json['is_active'] ?? false,
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
