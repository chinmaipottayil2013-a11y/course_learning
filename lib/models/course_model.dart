import 'package:learning_course2/models/last_viewed_model.dart';
import 'package:learning_course2/models/provider_model.dart';

class CourseModel {
  final String name;
  final String image;
  final String smallDescription;
  final String slug;
  final double salePrice;
  final double mrp;
  final String totalHour;
  final String level;
  final bool isFavourite;
  bool isCartAdded;
  final double averageReview;
  final double completedPercentage;

  final LastViewedLectureModel? lastViewedLecture;

  final bool isPurchased;

  final List<dynamic> instructors;

  final ProviderModel? provider;
  final ProviderModel? institution;

  final bool isBundle;
  final bool isCombo;

  final String? scheduleStartTime;
  final String? scheduleEndTime;
  final bool isSponsored;
  // final int sponsoredWeight;
  final bool isFeatured;
  final int id;
  // final int? region;
  final int totalReviewCount;

  CourseModel({
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
    required this.lastViewedLecture,
    required this.isPurchased,
    required this.instructors,
    required this.provider,
    required this.institution,
    required this.isBundle,
    required this.isCombo,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.isSponsored,
    // required this.sponsoredWeight,
    required this.isFeatured,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,

      name: json['name'] ?? '',

      image: json['image'] ?? '',

      smallDescription: json['small_description'] ?? '',

      slug: json['slug'] ?? '',

      salePrice: (json['sale_price'] ?? 0).toDouble(),

      mrp: (json['mrp'] ?? 0).toDouble(),

      totalHour: json['total_hour']?.toString() ?? '',

      level: json['level'] ?? '',

      isFavourite: json['is_favourite'] ?? false,

      isCartAdded: json['is_cart_added'] ?? false,

      totalReviewCount: json['total_review_count'] ?? 0,

      averageReview: (json['average_review'] ?? 0).toDouble(),

      completedPercentage: (json['completed_percentage'] ?? 0).toDouble(),

      lastViewedLecture: json['last_viewed_lecture'] != null
          ? LastViewedLectureModel.fromJson(json['last_viewed_lecture'])
          : null,

      isPurchased: json['is_purchased'] ?? false,

      instructors: json['instructors'] ?? [],

      provider: json['provider'] != null
          ? ProviderModel.fromJson(json['provider'])
          : null,

      institution: json['institution'] != null
          ? ProviderModel.fromJson(json['institution'])
          : null,

      isBundle: json['is_bundle'] ?? false,

      isCombo: json['is_combo'] ?? false,

      scheduleStartTime: json['schedule_start_time'],

      scheduleEndTime: json['schedule_end_time'],

      isSponsored: json['is_sponsored'] ?? false,

      // sponsoredWeight: json['sponsored_weight'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
    );
  }

  CourseModel copyWith({bool? isCartAdded}) {
    return CourseModel(
      id: id,
      name: name,
      image: image,
      smallDescription: smallDescription,
      slug: slug,
      salePrice: salePrice,
      mrp: mrp,
      totalHour: totalHour,
      level: level,
      isFavourite: isFavourite,
      isCartAdded: isCartAdded ?? this.isCartAdded,
      totalReviewCount: totalReviewCount,
      averageReview: averageReview,
      completedPercentage: completedPercentage,
      lastViewedLecture: lastViewedLecture,
      isPurchased: isPurchased,
      instructors: instructors,
      provider: provider,
      institution: institution,
      isBundle: isBundle,
      isCombo: isCombo,
      scheduleStartTime: scheduleStartTime,
      scheduleEndTime: scheduleEndTime,
      isSponsored: isSponsored,
      // sponsoredWeight: sponsoredWeight,
      isFeatured: isFeatured,
    );
  }
}
