import 'package:learning_course2/models/cart_item_model.dart';

class CartModel {
  final int id;
  final int user;
  final int region;
  final String totalAmount;
  final String courseTotal;
  final String certificateUpgradeTotal;
  final String payableAmount;
  final String originalPrice;
  final String discount;
  final String certificateUpgrades;
  final List<CartItemModel> items;
  final DateTime createdAt;

  CartModel({
    required this.id,
    required this.user,
    required this.region,
    required this.totalAmount,
    required this.courseTotal,
    required this.certificateUpgradeTotal,
    required this.payableAmount,
    required this.originalPrice,
    required this.discount,
    required this.certificateUpgrades,
    required this.items,
    required this.createdAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      user: json['user'],
      region: json['region'],
      totalAmount: json['total_amount'] ?? '0.00',
      courseTotal: json['course_total'] ?? '0.00',
      certificateUpgradeTotal: json['certificate_upgrade_total'] ?? '0.00',
      payableAmount: json['payable_amount'] ?? '0.00',
      originalPrice: json['original_price'] ?? '0.00',
      discount: json['discount'] ?? '0.00',
      certificateUpgrades: json['certificate_upgrades'] ?? '0.00',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
