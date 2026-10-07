import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:learning_course2/models/add_to_cart_model.dart';
import 'package:learning_course2/models/cart_model.dart';
import 'package:learning_course2/services/cart_add_service.dart';
import 'package:learning_course2/services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();
  final CartAddService _addService = CartAddService();
  CartModel? _cartModel;
  AddToCartRequestModel? _addToCartRequestModel;
  AddToCartRequestModel? get addToCartRequestModel => _addToCartRequestModel;

  CartModel? get cartModel => _cartModel;

  bool isLoading = false;
  String? errorMessage;

  Future<void> getCartItems({required int regionId}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      _cartModel = await _cartService.getCourses(regionId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart({required int courseId, required int region}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      log("add to cart button calling...");
      _addToCartRequestModel = await _addService.addCourse(
        courseId: courseId,
        region: region,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
