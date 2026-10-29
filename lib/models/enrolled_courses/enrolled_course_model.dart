import 'package:learning_course2/models/enrolled_courses/enrolled_course_details_model.dart';

class EnrolledCourseModel {
  final int id;
  final EnrolledCourseCourseModel course;
  final String status;
  final DateTime? createdAt;
  final bool isBundleCourse;
  final dynamic bundle;
  final List<dynamic> bundles;
  final String? certificateId;
  final DateTime? certificateIssuedAt;
  final DateTime? certificateExpiredAt;
  final String? invoice;
  final dynamic certificate;
  final List<dynamic> selectedCertificates;
  final List<dynamic> issuedCertificates;

  EnrolledCourseModel({
    required this.id,
    required this.course,
    required this.status,
    this.createdAt,
    required this.isBundleCourse,
    this.bundle,
    required this.bundles,
    this.certificateId,
    this.certificateIssuedAt,
    this.certificateExpiredAt,
    this.invoice,
    this.certificate,
    required this.selectedCertificates,
    required this.issuedCertificates,
  });

  factory EnrolledCourseModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCourseModel(
      id: json['id'] ?? 0,
      course: EnrolledCourseCourseModel.fromJson(
        json['course'] as Map<String, dynamic>? ?? {},
      ),
      status: json['status'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      isBundleCourse: json['is_bundle_course'] ?? false,
      bundle: json['bundle'],
      bundles: json['bundles'] as List<dynamic>? ?? [],
      certificateId: json['certificate_id'],
      certificateIssuedAt: json['certificate_issued_at'] != null
          ? DateTime.tryParse(json['certificate_issued_at'])
          : null,
      certificateExpiredAt: json['certificate_expired_at'] != null
          ? DateTime.tryParse(json['certificate_expired_at'])
          : null,
      invoice: json['invoice'],
      certificate: json['certificate'],
      selectedCertificates:
          json['selected_certificates'] as List<dynamic>? ?? [],
      issuedCertificates: json['issued_certificates'] as List<dynamic>? ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course': course.toJson(),
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'is_bundle_course': isBundleCourse,
      'bundle': bundle,
      'bundles': bundles,
      'certificate_id': certificateId,
      'certificate_issued_at': certificateIssuedAt?.toIso8601String(),
      'certificate_expired_at': certificateExpiredAt?.toIso8601String(),
      'invoice': invoice,
      'certificate': certificate,
      'selected_certificates': selectedCertificates,
      'issued_certificates': issuedCertificates,
    };
  }
}
