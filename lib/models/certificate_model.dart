class CertificateModel {
  final int id;
  final String name;
  final String originType;
  final String? accreditationBody;
  final String? badgeLogo;
  final String mrp;
  final String salePrice;
  final String currency;
  final String currencyCode;
  final bool isSelected;

  CertificateModel({
    required this.id,
    required this.name,
    required this.originType,
    this.accreditationBody,
    this.badgeLogo,
    required this.mrp,
    required this.salePrice,
    required this.currency,
    required this.currencyCode,
    required this.isSelected,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id'],
      name: json['name'] ?? '',
      originType: json['origin_type'] ?? '',
      accreditationBody: json['accreditation_body'],
      badgeLogo: json['badge_logo'],
      mrp: json['mrp'] ?? '0.00',
      salePrice: json['sale_price'] ?? '0.00',
      currency: json['currency'] ?? '',
      currencyCode: json['currency_code'] ?? '',
      isSelected: json['is_selected'] ?? false,
    );
  }
}
