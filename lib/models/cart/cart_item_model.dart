import '../courses/course_model.dart';
import '../courses/certificate_model.dart';

class CartItemModel {
  final int id;
  final int cart;
  final int user;
  final CourseModel course;
  final dynamic bundle;
  final int quantity;
  final String mrp;
  final String salePrice;
  final String discountAmount;
  final String certificateUpgradeAmount;
  final String totalMrp;
  final String totalSalePrice;
  final List<CertificateModel> availableCertificateUpgrades;
  final List<dynamic> selectedCertificates;
  final DateTime createdAt;

  CartItemModel({
    required this.id,
    required this.cart,
    required this.user,
    required this.course,
    this.bundle,
    required this.quantity,
    required this.mrp,
    required this.salePrice,
    required this.discountAmount,
    required this.certificateUpgradeAmount,
    required this.totalMrp,
    required this.totalSalePrice,
    required this.availableCertificateUpgrades,
    required this.selectedCertificates,
    required this.createdAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      cart: json['cart'],
      user: json['user'],
      course: CourseModel.fromJson(json['course']),
      bundle: json['bundle'],
      quantity: json['quantity'] ?? 1,
      mrp: json['mrp'] ?? '0.00',
      salePrice: json['sale_price'] ?? '0.00',
      discountAmount: json['discount_amount'] ?? '0.00',
      certificateUpgradeAmount: json['certificate_upgrade_amount'] ?? '0.00',
      totalMrp: json['total_mrp'] ?? '0.00',
      totalSalePrice: json['total_sale_price'] ?? '0.00',
      availableCertificateUpgrades:
          (json['available_certificate_upgrades'] as List<dynamic>? ?? [])
              .map((item) => CertificateModel.fromJson(item))
              .toList(),
      selectedCertificates:
          json['selected_certificates'] as List<dynamic>? ?? [],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
