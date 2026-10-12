import 'package:flutter/material.dart';
import 'package:learning_course2/models/cart/add_to_cart_model.dart';
import 'package:learning_course2/models/cart/cart_model.dart';
import 'package:learning_course2/models/cart/remove_from_cart_model.dart';
import 'package:learning_course2/providers/homescreen_provider.dart';

import 'package:learning_course2/services/cart_service.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();

  CartModel? _cartModel;
  AddToCartRequestModel? _addToCartRequestModel;
  AddToCartRequestModel? get addToCartRequestModel => _addToCartRequestModel;

  RemoveFromCartRequestModel? _removeFromCartRequestModel;
  RemoveFromCartRequestModel? get removeFromCartRequestModel =>
      _removeFromCartRequestModel;

  CartModel? get cartModel => _cartModel;

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
  }) async {
    try {
      final response = await _cartService.addCourse(
        courseId: courseId,
        region: region,
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
}
