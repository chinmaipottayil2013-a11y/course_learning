import 'package:learning_course2/models/provider_model.dart';
import 'package:learning_course2/models/last_viewed_model.dart';
import 'package:learning_course2/models/seo_model.dart'
    hide LastViewedLectureModel, ProviderModel;

class CourseDetailsModel {
  final int? id;
  final List<dynamic> instructors;
  final String? courseStatus;
  final String? level;
  final List<CategoryModel> category;
  final List<IndustryModel> industry;
  final String? language;
  final List<LectureTitleModel> lectureTitle;
  final double? mrp;
  final double? salePrice;
  final SeoModel? seo;
  final String? description;
  final bool? isCartAdded;
  final bool? isFavourite;
  final ProviderModel? provider;
  final int? totalReviewCount;
  final double? averageReview;
  final ReviewDetailsModel? reviewDetails;
  final bool? isPurchased;
  final LastViewedLectureModel? lastViewedLecture;
  final List<RelatedCourseModel> relatedCourses;
  final String? name;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final String? image;
  final String? smallDescription;
  final String? largeDescription;
  final String? slug;
  final String? totalHour;
  final String? intendedFor;
  final String? certificationIssued;
  final int? certificationValidity;
  final String? requirements;
  final String? types;
  final int? downloadableFiles;
  final String? introductionVideoId;
  final bool? freeCourse;
  final bool? thirdPartyCourse;
  final bool? isFeatured;
  final bool? isActive;
  final int? featuredPriority;
  final String? badge;
  final bool? comingSoon;
  final String? vimeoFolderUri;
  final bool? isPromoted;
  final String? promotedAt;
  final String? promotionExpiresAt;
  final String? publishingStatus;
  final int? versionNumber;
  final String? changeLog;
  final int? tax;
  final int? parentCourse;
  final List<dynamic> region;
  final List<int> certificates;

  CourseDetailsModel({
    this.id,
    this.instructors = const [],
    this.courseStatus,
    this.level,
    this.category = const [],
    this.industry = const [],
    this.language,
    this.lectureTitle = const [],
    this.mrp,
    this.salePrice,
    this.seo,
    this.description,
    this.isCartAdded,
    this.isFavourite,
    this.provider,
    this.totalReviewCount,
    this.averageReview,
    this.reviewDetails,
    this.isPurchased,
    this.lastViewedLecture,
    this.relatedCourses = const [],
    this.name,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.image,
    this.smallDescription,
    this.largeDescription,
    this.slug,
    this.totalHour,
    this.intendedFor,
    this.certificationIssued,
    this.certificationValidity,
    this.requirements,
    this.types,
    this.downloadableFiles,
    this.introductionVideoId,
    this.freeCourse,
    this.thirdPartyCourse,
    this.isFeatured,
    this.isActive,
    this.featuredPriority,
    this.badge,
    this.comingSoon,
    this.vimeoFolderUri,
    this.isPromoted,
    this.promotedAt,
    this.promotionExpiresAt,
    this.publishingStatus,
    this.versionNumber,
    this.changeLog,
    this.tax,
    this.parentCourse,
    this.region = const [],
    this.certificates = const [],
  });

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailsModel(
      id: json['id'],
      instructors: json['instructors'] ?? [],
      courseStatus: json['course_status'],
      level: json['level'],
      category: (json['category'] as List? ?? [])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      industry: (json['industry'] as List? ?? [])
          .map((e) => IndustryModel.fromJson(e))
          .toList(),
      language: json['language'],
      lectureTitle: (json['lecture_title'] as List? ?? [])
          .map((e) => LectureTitleModel.fromJson(e))
          .toList(),
      mrp: (json['mrp'] as num?)?.toDouble(),
      salePrice: (json['sale_price'] as num?)?.toDouble(),
      seo: json['seo'] == null ? null : SeoModel.fromJson(json['seo']),
      description: json['description'],
      isCartAdded: json['is_cart_added'],
      isFavourite: json['is_favourite'],
      provider: json['provider'] == null
          ? null
          : ProviderModel.fromJson(json['provider']),
      totalReviewCount: json['total_review_count'],
      averageReview: (json['average_review'] as num?)?.toDouble(),
      reviewDetails: json['review_details'] == null
          ? null
          : ReviewDetailsModel.fromJson(json['review_details']),
      isPurchased: json['is_purchased'],
      lastViewedLecture: json['last_viewed_lecture'] == null
          ? null
          : LastViewedLectureModel.fromJson(json['last_viewed_lecture']),
      relatedCourses: (json['related_courses'] as List? ?? [])
          .map((e) => RelatedCourseModel.fromJson(e))
          .toList(),
      name: json['name'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      image: json['image'],
      smallDescription: json['small_description'],
      largeDescription: json['large_description'],
      slug: json['slug'],
      totalHour: json['total_hour']?.toString(),
      intendedFor: json['intended_for'],
      certificationIssued: json['certification_issued'],
      certificationValidity: json['certification_validity'],
      requirements: json['requirements'],
      types: json['types'],
      downloadableFiles: json['downloadable_files'],
      introductionVideoId: json['introduction_video_id']?.toString(),
      freeCourse: json['free_course'],
      thirdPartyCourse: json['third_partry_course'],
      isFeatured: json['is_featured'],
      isActive: json['is_active'],
      featuredPriority: json['featured_priority'],
      badge: json['badge'],
      comingSoon: json['comming_soon'],
      vimeoFolderUri: json['vimeo_folder_uri'],
      isPromoted: json['is_promoted'],
      promotedAt: json['promoted_at'],
      promotionExpiresAt: json['promotion_expires_at'],
      publishingStatus: json['publishing_status'],
      versionNumber: json['version_number'],
      changeLog: json['change_log'],
      tax: json['tax'],
      parentCourse: json['parent_course'],
      region: json['region'] ?? [],
      certificates: (json['certificates'] as List? ?? [])
          .map((e) => e as int)
          .toList(),
    );
  }
}

class CategoryModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? metaTitle;
  final String? metaDescription;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.metaTitle,
    this.metaDescription,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
    );
  }
}

class IndustryModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? metaTitle;
  final String? metaDescription;

  IndustryModel({
    this.id,
    this.name,
    this.slug,
    this.metaTitle,
    this.metaDescription,
  });

  factory IndustryModel.fromJson(Map<String, dynamic> json) {
    return IndustryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
    );
  }
}

class LectureTitleModel {
  final int? id;
  final List<LectureModel> lectures;
  final String? name;
  final int? orderBy;
  final String? vimeoFolderUri;
  final int? originalModuleId;
  final int? course;

  LectureTitleModel({
    this.id,
    this.lectures = const [],
    this.name,
    this.orderBy,
    this.vimeoFolderUri,
    this.originalModuleId,
    this.course,
  });

  factory LectureTitleModel.fromJson(Map<String, dynamic> json) {
    return LectureTitleModel(
      id: json['id'],
      lectures: (json['lectures'] as List? ?? [])
          .map((e) => LectureModel.fromJson(e))
          .toList(),
      name: json['name'],
      orderBy: json['order_by'],
      vimeoFolderUri: json['vimeo_folder_uri'],
      originalModuleId: json['original_module_id'],
      course: json['course'],
    );
  }
}

class LectureModel {
  final int? id;
  final int? orderBy;
  final String? name;
  final String? types;
  final String? videoSource;
  final String? vimeoUploadStatus;
  final String? liveClassDate;
  final String? liveClassTime;
  final int? overallTime;
  final int? title;
  final int? course;
  final bool? isCompleted;
  final bool? isFinalExam;
  final int? examId;

  LectureModel({
    this.id,
    this.orderBy,
    this.name,
    this.types,
    this.videoSource,
    this.vimeoUploadStatus,
    this.liveClassDate,
    this.liveClassTime,
    this.overallTime,
    this.title,
    this.course,
    this.isCompleted,
    this.isFinalExam,
    this.examId,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'],
      orderBy: json['order_by'],
      name: json['name'],
      types: json['types'],
      videoSource: json['video_source'],
      vimeoUploadStatus: json['vimeo_upload_status'],
      liveClassDate: json['live_class_date'],
      liveClassTime: json['live_class_time'],
      overallTime: json['overall_time'],
      title: json['title'],
      course: json['course'],
      isCompleted: json['is_completed'],
      isFinalExam: json['is_final_exam'],
      examId: json['exam_id'],
    );
  }
}
