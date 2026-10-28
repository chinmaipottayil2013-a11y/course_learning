class OrderResponseModel {
  final String message;
  final OrderModel order;

  OrderResponseModel({required this.message, required this.order});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      message: json['message'] ?? '',
      order: OrderModel.fromJson(json['order'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'order': order.toJson(),
  };
}

class OrderModel {
  final int id;
  final List<OrderItemModel> items;
  final String orderId;
  final double totalAmount;
  final double payableAmount;
  final double taxableAmount;
  final double cgstRate;
  final double cgstAmount;
  final double sgstRate;
  final double sgstAmount;
  final double igstRate;
  final double igstAmount;
  final double totalTaxAmount;
  final String placeOfSupply;
  final String placeOfSupplyCode;
  final bool isExport;
  final String? lutNumber;
  final String? buyerGstin;
  final String? buyerLegalName;
  final String? buyerState;
  final String? buyerCountry;
  final String status;
  final String? razorpayOrderId;
  final String? paymentMode;
  final DateTime? createdAt;
  final int? user;
  final int? cart;
  final int? region;

  OrderModel({
    required this.id,
    required this.items,
    required this.orderId,
    required this.totalAmount,
    required this.payableAmount,
    required this.taxableAmount,
    required this.cgstRate,
    required this.cgstAmount,
    required this.sgstRate,
    required this.sgstAmount,
    required this.igstRate,
    required this.igstAmount,
    required this.totalTaxAmount,
    required this.placeOfSupply,
    required this.placeOfSupplyCode,
    required this.isExport,
    this.lutNumber,
    this.buyerGstin,
    this.buyerLegalName,
    this.buyerState,
    this.buyerCountry,
    required this.status,
    this.razorpayOrderId,
    this.paymentMode,
    this.createdAt,
    this.user,
    this.cart,
    this.region,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      items: (json['items'] as List? ?? [])
          .map((e) => OrderItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      orderId: json['order_id'] ?? '',
      totalAmount: double.parse('${json['total_amount'] ?? 0}'),
      payableAmount: double.parse('${json['payable_amount'] ?? 0}'),
      taxableAmount: double.parse('${json['taxable_amount'] ?? 0}'),
      cgstRate: double.parse('${json['cgst_rate'] ?? 0}'),
      cgstAmount: double.parse('${json['cgst_amount'] ?? 0}'),
      sgstRate: double.parse('${json['sgst_rate'] ?? 0}'),
      sgstAmount: double.parse('${json['sgst_amount'] ?? 0}'),
      igstRate: double.parse('${json['igst_rate'] ?? 0}'),
      igstAmount: double.parse('${json['igst_amount'] ?? 0}'),
      totalTaxAmount: double.parse('${json['total_tax_amount'] ?? 0}'),
      placeOfSupply: json['place_of_supply'] ?? '',
      placeOfSupplyCode: '${json['place_of_supply_code'] ?? ''}',
      isExport: json['is_export'] ?? false,
      lutNumber: json['lut_number']?.toString(),
      buyerGstin: json['buyer_gstin']?.toString(),
      buyerLegalName: json['buyer_legal_name']?.toString(),
      buyerState: json['buyer_state']?.toString(),
      buyerCountry: json['buyer_country']?.toString(),
      status: json['status'] ?? '',
      razorpayOrderId: json['razorpay_order_id']?.toString(),
      paymentMode: json['payment_mode']?.toString(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at']),
      user: json['user'],
      cart: json['cart'],
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'items': items.map((e) => e.toJson()).toList(),
    'order_id': orderId,
    'total_amount': totalAmount,
    'payable_amount': payableAmount,
    'taxable_amount': taxableAmount,
    'cgst_rate': cgstRate,
    'cgst_amount': cgstAmount,
    'sgst_rate': sgstRate,
    'sgst_amount': sgstAmount,
    'igst_rate': igstRate,
    'igst_amount': igstAmount,
    'total_tax_amount': totalTaxAmount,
    'place_of_supply': placeOfSupply,
    'place_of_supply_code': placeOfSupplyCode,
    'is_export': isExport,
    'lut_number': lutNumber,
    'buyer_gstin': buyerGstin,
    'buyer_legal_name': buyerLegalName,
    'buyer_state': buyerState,
    'buyer_country': buyerCountry,
    'status': status,
    'razorpay_order_id': razorpayOrderId,
    'payment_mode': paymentMode,
    'created_at': createdAt?.toIso8601String(),
    'user': user,
    'cart': cart,
    'region': region,
  };
}

class OrderItemModel {
  final int id;
  final CourseModel course;
  final dynamic bundle;
  final List<dynamic> selectedCertificates;
  final List<dynamic> issuedCertificates;
  final int courseVersionNumber;
  final double certificateUpgradeAmount;
  final int quantity;
  final double mrp;
  final double salePrice;
  final double discountAmount;
  final double totalMrp;
  final double totalSalePrice;
  final String sacCode;
  final double taxRate;
  final double taxableAmount;
  final double cgstAmount;
  final double sgstAmount;
  final double igstAmount;
  final double totalTaxAmount;
  final DateTime? createdAt;
  final String status;
  final String certificateId;
  final DateTime? certificateIssuedAt;
  final DateTime? certificateExpiredAt;
  final String? invoice;
  final String? certificate;
  final int? order;

  OrderItemModel({
    required this.id,
    required this.course,
    this.bundle,
    this.selectedCertificates = const [],
    this.issuedCertificates = const [],
    required this.courseVersionNumber,
    required this.certificateUpgradeAmount,
    required this.quantity,
    required this.mrp,
    required this.salePrice,
    required this.discountAmount,
    required this.totalMrp,
    required this.totalSalePrice,
    required this.sacCode,
    required this.taxRate,
    required this.taxableAmount,
    required this.cgstAmount,
    required this.sgstAmount,
    required this.igstAmount,
    required this.totalTaxAmount,
    this.createdAt,
    required this.status,
    required this.certificateId,
    this.certificateIssuedAt,
    this.certificateExpiredAt,
    this.invoice,
    this.certificate,
    this.order,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? 0,
      course: CourseModel.fromJson(json['course'] ?? {}),
      bundle: json['bundle'],
      selectedCertificates: json['selected_certificates'] ?? [],
      issuedCertificates: json['issued_certificates'] ?? [],
      courseVersionNumber: json['course_version_number'] ?? 0,
      certificateUpgradeAmount: double.parse(
        '${json['certificate_upgrade_amount'] ?? 0}',
      ),
      quantity: json['quantity'] ?? 0,
      mrp: double.parse('${json['mrp'] ?? 0}'),
      salePrice: double.parse('${json['sale_price'] ?? 0}'),
      discountAmount: double.parse('${json['discount_amount'] ?? 0}'),
      totalMrp: double.parse('${json['total_mrp'] ?? 0}'),
      totalSalePrice: double.parse('${json['total_sale_price'] ?? 0}'),
      sacCode: '${json['sac_code'] ?? ''}',
      taxRate: double.parse('${json['tax_rate'] ?? 0}'),
      taxableAmount: double.parse('${json['taxable_amount'] ?? 0}'),
      cgstAmount: double.parse('${json['cgst_amount'] ?? 0}'),
      sgstAmount: double.parse('${json['sgst_amount'] ?? 0}'),
      igstAmount: double.parse('${json['igst_amount'] ?? 0}'),
      totalTaxAmount: double.parse('${json['total_tax_amount'] ?? 0}'),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at']),
      status: json['status'] ?? '',
      certificateId: json['certificate_id'] ?? '',
      certificateIssuedAt: json['certificate_issued_at'] == null
          ? null
          : DateTime.tryParse(json['certificate_issued_at']),
      certificateExpiredAt: json['certificate_expired_at'] == null
          ? null
          : DateTime.tryParse(json['certificate_expired_at']),
      invoice: json['invoice']?.toString(),
      certificate: json['certificate']?.toString(),
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'course': course.toJson(),
    'bundle': bundle,
    'selected_certificates': selectedCertificates,
    'issued_certificates': issuedCertificates,
    'course_version_number': courseVersionNumber,
    'certificate_upgrade_amount': certificateUpgradeAmount,
    'quantity': quantity,
    'mrp': mrp,
    'sale_price': salePrice,
    'discount_amount': discountAmount,
    'total_mrp': totalMrp,
    'total_sale_price': totalSalePrice,
    'sac_code': sacCode,
    'tax_rate': taxRate,
    'taxable_amount': taxableAmount,
    'cgst_amount': cgstAmount,
    'sgst_amount': sgstAmount,
    'igst_amount': igstAmount,
    'total_tax_amount': totalTaxAmount,
    'created_at': createdAt?.toIso8601String(),
    'status': status,
    'certificate_id': certificateId,
    'certificate_issued_at': certificateIssuedAt?.toIso8601String(),
    'certificate_expired_at': certificateExpiredAt?.toIso8601String(),
    'invoice': invoice,
    'certificate': certificate,
    'order': order,
  };
}

class CourseModel {
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
  final List<dynamic> instructors;
  final ProviderModel? provider;
  final ProviderModel? institution;
  final bool isBundle;
  final bool isCombo;
  final DateTime? scheduleStartTime;
  final DateTime? scheduleEndTime;
  final bool isSponsored;
  final int sponsoredWeight;
  final bool isFeatured;
  final bool freeCourse;
  final bool isTestEligible;

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
    this.lastViewedLecture,
    required this.isPurchased,
    this.instructors = const [],
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

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      smallDescription: json['small_description'] ?? '',
      slug: json['slug'] ?? '',
      salePrice: double.parse('${json['sale_price'] ?? 0}'),
      mrp: double.parse('${json['mrp'] ?? 0}'),
      totalHour: '${json['total_hour'] ?? ''}',
      level: json['level'] ?? '',
      isFavourite: json['is_favourite'] ?? false,
      isCartAdded: json['is_cart_added'] ?? false,
      totalReviewCount: json['total_review_count'] ?? 0,
      averageReview: double.parse('${json['average_review'] ?? 0}'),
      completedPercentage: double.parse('${json['completed_percentage'] ?? 0}'),
      lastViewedLecture: json['last_viewed_lecture'] == null
          ? null
          : LastViewedLectureModel.fromJson(json['last_viewed_lecture']),
      isPurchased: json['is_purchased'] ?? false,
      instructors: json['instructors'] ?? [],
      provider: json['provider'] == null
          ? null
          : ProviderModel.fromJson(json['provider']),
      institution: json['institution'] == null
          ? null
          : ProviderModel.fromJson(json['institution']),
      isBundle: json['is_bundle'] ?? false,
      isCombo: json['is_combo'] ?? false,
      scheduleStartTime: json['schedule_start_time'] == null
          ? null
          : DateTime.tryParse(json['schedule_start_time']),
      scheduleEndTime: json['schedule_end_time'] == null
          ? null
          : DateTime.tryParse(json['schedule_end_time']),
      isSponsored: json['is_sponsored'] ?? false,
      sponsoredWeight: json['sponsored_weight'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      freeCourse: json['free_course'] ?? false,
      isTestEligible: json['is_test_eligible'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
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
    'instructors': instructors,
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

class ProviderModel {
  final int id;
  final String name;
  final String slug;
  final String logo;
  final String description;
  final String contactNumber;
  final String email;
  final String url;
  final String? accreditationBody;

  ProviderModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.logo,
    required this.description,
    required this.contactNumber,
    required this.email,
    required this.url,
    this.accreditationBody,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      contactNumber: '${json['contact_number'] ?? ''}',
      email: json['email'] ?? '',
      url: json['url'] ?? '',
      accreditationBody: json['accreditation_body']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'logo': logo,
    'description': description,
    'contact_number': contactNumber,
    'email': email,
    'url': url,
    'accreditation_body': accreditationBody,
  };
}

class LastViewedLectureModel {
  final int id;
  final String name;
  final String types;
  final int orderBy;
  final String titleName;
  final DateTime? createdAt;
  final String? videoUrl;

  LastViewedLectureModel({
    required this.id,
    required this.name,
    required this.types,
    required this.orderBy,
    required this.titleName,
    this.createdAt,
    this.videoUrl,
  });

  factory LastViewedLectureModel.fromJson(Map<String, dynamic> json) {
    return LastViewedLectureModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      types: json['types'] ?? '',
      orderBy: json['order_by'] ?? 0,
      titleName: json['title_name'] ?? '',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at']),
      videoUrl: json['video_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'types': types,
    'order_by': orderBy,
    'title_name': titleName,
    'created_at': createdAt?.toIso8601String(),
    'video_url': videoUrl,
  };
}
