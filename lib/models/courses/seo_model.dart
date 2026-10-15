
class SeoModel {
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final String? ogImage;
  final String? canonicalUrl;
  final List<HreflangModel> hreflang;
  final Map<String, dynamic>? structuredData;

  SeoModel({
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.ogImage,
    this.canonicalUrl,
    this.hreflang = const [],
    this.structuredData,
  });

  factory SeoModel.fromJson(Map<String, dynamic> json) {
    return SeoModel(
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      ogImage: json['og_image'],
      canonicalUrl: json['canonical_url'],
      hreflang: (json['hreflang'] as List? ?? [])
          .map((e) => HreflangModel.fromJson(e))
          .toList(),
      structuredData: json['structured_data'] == null
          ? null
          : Map<String, dynamic>.from(json['structured_data']),
    );
  }
}

class HreflangModel {
  final String? hreflang;
  final String? href;

  HreflangModel({this.hreflang, this.href});

  factory HreflangModel.fromJson(Map<String, dynamic> json) {
    return HreflangModel(
      hreflang: json['hreflang'],
      href: json['href'],
    );
  }
}

class ProviderModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? logo;
  final String? description;
  final String? contactNumber;
  final String? email;
  final String? url;
  final String? accreditationBody;

  ProviderModel({
    this.id,
    this.name,
    this.slug,
    this.logo,
    this.description,
    this.contactNumber,
    this.email,
    this.url,
    this.accreditationBody,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      logo: json['logo'],
      description: json['description'],
      contactNumber: json['contact_number'],
      email: json['email'],
      url: json['url'],
      accreditationBody: json['accreditation_body'],
    );
  }
}

class ReviewDetailsModel {
  final int? fiveStar;
  final int? fourStar;
  final int? threeStar;
  final int? twoStar;
  final int? oneStar;

  ReviewDetailsModel({
    this.fiveStar,
    this.fourStar,
    this.threeStar,
    this.twoStar,
    this.oneStar,
  });

  factory ReviewDetailsModel.fromJson(Map<String, dynamic> json) {
    return ReviewDetailsModel(
      fiveStar: json['5_star'],
      fourStar: json['4_star'],
      threeStar: json['3_star'],
      twoStar: json['2_star'],
      oneStar: json['1_star'],
    );
  }
}

class LastViewedLectureModel {
  final int? id;
  final String? name;
  final String? types;
  final int? orderBy;
  final String? titleName;
  final String? createdAt;
  final String? videoUrl;

  LastViewedLectureModel({
    this.id,
    this.name,
    this.types,
    this.orderBy,
    this.titleName,
    this.createdAt,
    this.videoUrl,
  });

  factory LastViewedLectureModel.fromJson(Map<String, dynamic> json) {
    return LastViewedLectureModel(
      id: json['id'],
      name: json['name'],
      types: json['types'],
      orderBy: json['order_by'],
      titleName: json['title_name'],
      createdAt: json['created_at'],
      videoUrl: json['video_url']?.toString(),
    );
  }
}

class RelatedCourseModel {
  final int? id;
  final String? name;
  final String? image;
  final String? smallDescription;
  final String? slug;
  final double? salePrice;
  final double? mrp;
  final String? totalHour;
  final String? level;
  final bool? isFavourite;
  final bool? isCartAdded;
  final int? totalReviewCount;
  final double? averageReview;
  final double? completedPercentage;
  final LastViewedLectureModel? lastViewedLecture;
  final bool? isPurchased;
  final List<dynamic> instructors;
  final ProviderModel? provider;
  final dynamic institution;
  final bool? isBundle;
  final bool? isCombo;
  final String? scheduleStartTime;
  final String? scheduleEndTime;
  final bool? isSponsored;
  final int? sponsoredWeight;
  final bool? isFeatured;

  RelatedCourseModel({
    this.id,
    this.name,
    this.image,
    this.smallDescription,
    this.slug,
    this.salePrice,
    this.mrp,
    this.totalHour,
    this.level,
    this.isFavourite,
    this.isCartAdded,
    this.totalReviewCount,
    this.averageReview,
    this.completedPercentage,
    this.lastViewedLecture,
    this.isPurchased,
    this.instructors = const [],
    this.provider,
    this.institution,
    this.isBundle,
    this.isCombo,
    this.scheduleStartTime,
    this.scheduleEndTime,
    this.isSponsored,
    this.sponsoredWeight,
    this.isFeatured,
  });

  factory RelatedCourseModel.fromJson(Map<String, dynamic> json) {
    return RelatedCourseModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      smallDescription: json['small_description'],
      slug: json['slug'],
      salePrice: (json['sale_price'] as num?)?.toDouble(),
      mrp: (json['mrp'] as num?)?.toDouble(),
      totalHour: json['total_hour']?.toString(),
      level: json['level'],
      isFavourite: json['is_favourite'],
      isCartAdded: json['is_cart_added'],
      totalReviewCount: json['total_review_count'],
      averageReview: (json['average_review'] as num?)?.toDouble(),
      completedPercentage:
          (json['completed_percentage'] as num?)?.toDouble(),
      lastViewedLecture: json['last_viewed_lecture'] == null
          ? null
          : LastViewedLectureModel.fromJson(
              json['last_viewed_lecture'],
            ),
      isPurchased: json['is_purchased'],
      instructors: json['instructors'] ?? [],
      provider: json['provider'] == null
          ? null
          : ProviderModel.fromJson(json['provider']),
      institution: json['institution'],
      isBundle: json['is_bundle'],
      isCombo: json['is_combo'],
      scheduleStartTime: json['schedule_start_time'],
      scheduleEndTime: json['schedule_end_time'],
      isSponsored: json['is_sponsored'],
      sponsoredWeight: json['sponsored_weight'],
      isFeatured: json['is_featured'],
    );
  }
}
