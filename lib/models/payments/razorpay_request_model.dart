class RazorpayRequestModel {
  final int regionId;
  final int billingAddressId;
  final int shippingAddressId;
  final String currency;

  RazorpayRequestModel({
    required this.regionId,
    required this.billingAddressId,
    required this.shippingAddressId,
    required this.currency,
  });

  factory RazorpayRequestModel.fromJson(Map<String, dynamic> json) {
    return RazorpayRequestModel(
      regionId: json['region_id'] as int,
      billingAddressId: json['billing_address_id'] as int,
      shippingAddressId: json['shipping_address_id'] as int,
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region_id': regionId,
      'billing_address_id': billingAddressId,
      'shipping_address_id': shippingAddressId,
      'currency': currency,
    };
  }
}
