import 'package:flutter/material.dart';

import 'package:learning_course2/core/constants/razorpay_constants.dart';
import 'package:learning_course2/models/payments/payment_response_model.dart';
import 'package:learning_course2/services/payment_api_service.dart';
import 'package:learning_course2/services/razorpay_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

enum PaymentStatus { idle, loading, success, failure }

class PaymentReceipt {
  final String paymentId;
  final String orderId;
  final String courseName;
  final int amountInPaisa;
  final DateTime paidAt;

  const PaymentReceipt({
    required this.paymentId,
    required this.orderId,
    required this.courseName,
    required this.amountInPaisa,
    required this.paidAt,
  });
}

class RazorpayProvider extends ChangeNotifier {
  late final RazorpayService _razorpayService;
  final PaymentApiService _paymentApiService = PaymentApiService();
  PaymentStatus status = PaymentStatus.idle;
  String? message;
  PaymentReceipt? receipt;

  PaymentResponseModel? _paymentResponseModel;
  int amount = 0;
  String pendingCourse = '';

  bool get isLoading => status == PaymentStatus.loading;

  RazorpayProvider() {
    paymentProvider();
  }

  void paymentProvider() {
    _razorpayService = RazorpayService(
      onSuccess: (PaymentSuccessResponse response) {
        receipt = PaymentReceipt(
          paymentId: response.paymentId ?? '-',
          orderId: _paymentResponseModel?.orderId ?? response.orderId ?? '-',
          courseName: pendingCourse,
          amountInPaisa: ((_paymentResponseModel?.amount ?? 0) * 100).round(),
          paidAt: DateTime.now(),
        );
        status = PaymentStatus.success;
        message = null;
        notifyListeners();
      },
      onFailure: (PaymentFailureResponse response) {
        status = PaymentStatus.failure;
        message = 'Payment failed';
        notifyListeners();
      },
      onExternalWallet: (ExternalWalletResponse response) {
        message = 'Selected wallet : ${response.walletName}';
        notifyListeners();
      },
    );
  }

  Future<void> pay({
    required String keyId,
    required int amountInPaisa,
    required String currency,
    required String courseName,
  }) async {
    pendingCourse = courseName;
    amount = amountInPaisa;
    status = PaymentStatus.loading;
    message = null;
    notifyListeners();
    try {
      _paymentResponseModel = await _paymentApiService.createOrder(
        currency: currency,
      );

      _razorpayService.openCheckout(
        keyId: RazorpayConstants.keyId,
        orderId: _paymentResponseModel!.orderId,
        amountInPaisa: (_paymentResponseModel!.amount * 100).round(),
        currency: _paymentResponseModel!.currency,
        courseName: courseName,
      );
    } catch (e) {
      status = PaymentStatus.failure;
      message = 'Could not open checkout $e';
      notifyListeners();
    }
  }

  void reset() {
    status = PaymentStatus.idle;
    message = null;
    receipt = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }
}
