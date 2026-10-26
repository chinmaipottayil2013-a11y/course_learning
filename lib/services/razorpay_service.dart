import 'package:learning_course2/core/constants/razorpay_constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  final Razorpay _razorpay = Razorpay();

  RazorpayService({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout({
    required String keyId,
    required String orderId,
    required int amountInPaisa,
    required String currency,
    required String courseName,
  }) {
    _razorpay.open({
      'key': RazorpayConstants.keyId,
      'order_id': orderId,
      'name': 'Chinmai',
      'amount': amountInPaisa,
      'currency': currency,
      'description': courseName,
      'timeout': 200,
    });
  }

  void dispose() {
    _razorpay.clear();
  }
}
