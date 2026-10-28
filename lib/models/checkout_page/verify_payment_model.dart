class VerifyPaymentRequestModel {
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;
  final int regionId;

  VerifyPaymentRequestModel({
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
    required this.regionId,
  });

  factory VerifyPaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyPaymentRequestModel(
      razorpayOrderId: json['razorpay_order_id'] ?? '',
      razorpayPaymentId: json['razorpay_payment_id'] ?? '',
      razorpaySignature: json['razorpay_signature'] ?? '',
      regionId: json['region_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'razorpay_order_id': razorpayOrderId,
      'razorpay_payment_id': razorpayPaymentId,
      'razorpay_signature': razorpaySignature,
      'region_id': regionId,
    };
  }
}
