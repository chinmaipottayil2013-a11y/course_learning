import 'package:learning_course2/models/checkout_page/order_response_model.dart';
import 'package:learning_course2/models/enrolled_courses/course_instructor_model.dart';
import 'package:learning_course2/models/enrolled_courses/course_organization_model.dart';

class EnrolledCourseCourseModel {
  final int id;
  final String name;
  final String image;
  final String smallDescription;
  final String slug;
  final double salePrice;
  final double mrp;
  final String totalHour;
  final String level;
  final bool isFavourite;
  final bool isCartAdded;
  final int totalReviewCount;
  final double averageReview;
  final double completedPercentage;
  final LastViewedLectureModel? lastViewedLecture;
  final bool isPurchased;
  final List<CourseInstructorModel> instructors;
  final CourseOrganizationModel? provider;
  final CourseOrganizationModel? institution;
  final bool isBundle;
  final bool isCombo;
  final DateTime? scheduleStartTime;
  final DateTime? scheduleEndTime;
  final bool isSponsored;
  final int sponsoredWeight;
  final bool isFeatured;
  final bool freeCourse;
  final bool isTestEligible;

  EnrolledCourseCourseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.smallDescription,
    required this.slug,
    required this.salePrice,
    required this.mrp,
    required this.totalHour,
    required this.level,
    required this.isFavourite,
    required this.isCartAdded,
    required this.totalReviewCount,
    required this.averageReview,
    required this.completedPercentage,
    this.lastViewedLecture,
    required this.isPurchased,
    required this.instructors,
    this.provider,
    this.institution,
    required this.isBundle,
    required this.isCombo,
    this.scheduleStartTime,
    this.scheduleEndTime,
    required this.isSponsored,
    required this.sponsoredWeight,
    required this.isFeatured,
    required this.freeCourse,
    required this.isTestEligible,
  });

  factory EnrolledCourseCourseModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCourseCourseModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      smallDescription: json['small_description'] ?? '',
      slug: json['slug'] ?? '',
      salePrice: (json['sale_price'] as num?)?.toDouble() ?? 0.0,
      mrp: (json['mrp'] as num?)?.toDouble() ?? 0.0,
      totalHour: json['total_hour']?.toString() ?? '',
      level: json['level'] ?? '',
      isFavourite: json['is_favourite'] ?? false,
      isCartAdded: json['is_cart_added'] ?? false,
      totalReviewCount: json['total_review_count'] ?? 0,
      averageReview: (json['average_review'] as num?)?.toDouble() ?? 0.0,
      completedPercentage:
          (json['completed_percentage'] as num?)?.toDouble() ?? 0.0,
      lastViewedLecture: json['last_viewed_lecture'] != null
          ? LastViewedLectureModel.fromJson(
              json['last_viewed_lecture'] as Map<String, dynamic>,
            )
          : null,
      isPurchased: json['is_purchased'] ?? false,
      instructors: (json['instructors'] as List<dynamic>? ?? [])
          .map((e) => CourseInstructorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      provider: json['provider'] != null
          ? CourseOrganizationModel.fromJson(
              json['provider'] as Map<String, dynamic>,
            )
          : null,
      institution: json['institution'] != null
          ? CourseOrganizationModel.fromJson(
              json['institution'] as Map<String, dynamic>,
            )
          : null,
      isBundle: json['is_bundle'] ?? false,
      isCombo: json['is_combo'] ?? false,
      scheduleStartTime: json['schedule_start_time'] != null
          ? DateTime.tryParse(json['schedule_start_time'])
          : null,
      scheduleEndTime: json['schedule_end_time'] != null
          ? DateTime.tryParse(json['schedule_end_time'])
          : null,
      isSponsored: json['is_sponsored'] ?? false,
      sponsoredWeight: json['sponsored_weight'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      freeCourse: json['free_course'] ?? false,
      isTestEligible: json['is_test_eligible'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'small_description': smallDescription,
      'slug': slug,
      'sale_price': salePrice,
      'mrp': mrp,
      'total_hour': totalHour,
      'level': level,
      'is_favourite': isFavourite,
      'is_cart_added': isCartAdded,
      'total_review_count': totalReviewCount,
      'average_review': averageReview,
      'completed_percentage': completedPercentage,
      'last_viewed_lecture': lastViewedLecture?.toJson(),
      'is_purchased': isPurchased,
      'instructors': instructors.map((e) => e.toJson()).toList(),
      'provider': provider?.toJson(),
      'institution': institution?.toJson(),
      'is_bundle': isBundle,
      'is_combo': isCombo,
      'schedule_start_time': scheduleStartTime?.toIso8601String(),
      'schedule_end_time': scheduleEndTime?.toIso8601String(),
      'is_sponsored': isSponsored,
      'sponsored_weight': sponsoredWeight,
      'is_featured': isFeatured,
      'free_course': freeCourse,
      'is_test_eligible': isTestEligible,
    };
  }
}
