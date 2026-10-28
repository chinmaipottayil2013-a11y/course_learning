class PaymentResponseModel {
  final String name;
  final String merchantId;
  final double amount;
  final String currency;
  final String orderId;
  final String paymentMode;
  final double taxableAmount;
  final double totalTaxAmount;
  final double cgstAmount;
  final double sgstAmount;
  final double igstAmount;
  final double cgstRate;
  final double sgstRate;
  final double igstRate;
  final String? billingState;
  final String billingCountry;
  final String? buyerGstin;

  PaymentResponseModel({
    required this.name,
    required this.merchantId,
    required this.amount,
    required this.currency,
    required this.orderId,
    required this.paymentMode,
    required this.taxableAmount,
    required this.totalTaxAmount,
    required this.cgstAmount,
    required this.sgstAmount,
    required this.igstAmount,
    required this.cgstRate,
    required this.sgstRate,
    required this.igstRate,
    this.billingState,
    required this.billingCountry,
    this.buyerGstin,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      name: json['name'] as String,
      merchantId: json['merchantId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      orderId: json['orderId'] as String,
      paymentMode: json['paymentMode'] as String,
      taxableAmount: (json['taxable_amount'] as num).toDouble(),
      totalTaxAmount: (json['total_tax_amount'] as num).toDouble(),
      cgstAmount: (json['cgst_amount'] as num).toDouble(),
      sgstAmount: (json['sgst_amount'] as num).toDouble(),
      igstAmount: (json['igst_amount'] as num).toDouble(),
      cgstRate: (json['cgst_rate'] as num).toDouble(),
      sgstRate: (json['sgst_rate'] as num).toDouble(),
      igstRate: (json['igst_rate'] as num).toDouble(),
      billingState: json['billing_state'] as String?,
      billingCountry: json['billing_country'] as String,
      buyerGstin: json['buyer_gstin'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'merchantId': merchantId,
      'amount': amount,
      'currency': currency,
      'orderId': orderId,
      'paymentMode': paymentMode,
      'taxable_amount': taxableAmount,
      'total_tax_amount': totalTaxAmount,
      'cgst_amount': cgstAmount,
      'sgst_amount': sgstAmount,
      'igst_amount': igstAmount,
      'cgst_rate': cgstRate,
      'sgst_rate': sgstRate,
      'igst_rate': igstRate,
      'billing_state': billingState,
      'billing_country': billingCountry,
      'buyer_gstin': buyerGstin,
    };
  }
}
