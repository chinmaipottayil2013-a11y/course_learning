import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:learning_course2/models/cart/cart_model.dart';
import 'package:learning_course2/models/checkout_page/order_response_model.dart';
import 'package:learning_course2/models/checkout_page/verify_payment_model.dart';

import 'package:learning_course2/providers/homescreen_provider.dart';

import 'package:learning_course2/services/cart_service.dart';
import 'package:learning_course2/services/checkout_service.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();
  final CheckoutService _checkoutService = CheckoutService();

  CartModel? _cartModel;

  OrderResponseModel? _orderResponseModel;
  CartModel? get cartModel => _cartModel;
  OrderResponseModel? get orderResponseModel => _orderResponseModel;

  bool isLoading = false;
  bool isDeleting = false;
  String? errorMessage;

  Future<void> getCartItems({
    required int regionId,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      _cartModel = await _cartService.getCourses(regionId, context);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart({
    required int courseId,
    required int region,
    required BuildContext context,
    required String currency,
  }) async {
    try {
      final response = await _cartService.addCourse(
        courseId: courseId,
        region: region,
        currency: currency,
      );

      // log('response in the cart provider $response');

      if (response) {
        if (context.mounted) {
          context.read<HomescreenProvider>().markCourseAsAdded(courseId);

          notifyListeners();
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteFromCart({
    required int courseId,
    required int region,
  }) async {
    try {
      isDeleting = true;
      errorMessage = null;
      notifyListeners();
      await _cartService.removeFromCart(courseId: courseId, region: region);

      _cartModel?.items.removeWhere((item) => item.course.id == courseId);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }

  Future<bool> verifyPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required int regionId,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final request = VerifyPaymentRequestModel(
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        razorpaySignature: razorpaySignature,
        regionId: regionId,
      );
      _orderResponseModel = await _checkoutService.verifyPayment(
        verify: request,
      );
      _cartModel?.items.clear();
      return true;
    } catch (e, st) {
      log('Verify payment error : $e', stackTrace: st);
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
