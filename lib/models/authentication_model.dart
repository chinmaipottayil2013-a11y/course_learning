class AuthenticationModel {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserData userData;

  AuthenticationModel({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.userData,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      message: json['message'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      userData: UserData.fromJson(json['user_data'] ?? {}),
    );
  }
}

class UserData {
  final int id;
  final String? password;
  final String? lastLogin;
  final bool isSuperuser;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final bool isStaff;
  final String? dateJoined;
  final String name;
  final String? mobileNumber;
  final String countryCode;
  final String? profilePicture;
  final String isActive;
  final String userType;
  final String? fcmToken;
  final String? dateOfBirth;
  final String? gender;
  final String status;
  final bool mustChangePassword;
  final String? country;
  final dynamic industry;
  final dynamic scope;
  final dynamic transactionId;
  final dynamic paymentPlatform;
  final dynamic qualification;
  final dynamic sex;
  final dynamic otp;
  final bool notifications;
  final String? businessName;
  final String? businessType;
  final String? businessAddress;
  final String? businessPincode;
  final String? gst;
  final String? pan;
  final String? bankName;
  final String? bankBranch;
  final String? bankAccountNo;
  final String? bankAccountName;
  final String? ifsc;
  final String? pancard1;
  final String? pancard2;
  final String? companyIncorporationCertificate1;
  final String? companyIncorporationCertificate2;
  final String? moa1;
  final String? moa2;
  final String? utilityBill1;
  final String? utilityBill2;
  final String? aadharCard1;
  final String? aadharCard2;
  final String? createdAt;
  final String? updatedAt;
  final String? shopLogo;
  final bool agreedToSellerAgreement;
  final bool agreedToPrivacyPolicy;
  final bool agreedToMarketplaceTerms;
  final double responseRate;
  final String? complianceScore;
  final String? supplierId;
  final bool isFullProfileCompleted;
  final bool isInstructor;
  final bool isInstitution;
  final String? bio;
  final String? facebookLink;
  final String? xLink;
  final String? linkedinLink;
  final String? youtubeLink;
  final bool profileEdit;
  final String? headline;
  final dynamic qhseExpertise;
  final String? websiteUrl;
  final dynamic accreditations;
  final String? certificateName;
  final bool certificateNameLocked;
  final String? state;
  final String? region;
  final List<dynamic> groups;
  final List<dynamic> userPermissions;
  final List<dynamic> operatingCategories;
  final String role;

  UserData({
    required this.id,
    this.password,
    this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    this.dateJoined,
    required this.name,
    this.mobileNumber,
    required this.countryCode,
    this.profilePicture,
    required this.isActive,
    required this.userType,
    this.fcmToken,
    this.dateOfBirth,
    this.gender,
    required this.status,
    required this.mustChangePassword,
    this.country,
    this.industry,
    this.scope,
    this.transactionId,
    this.paymentPlatform,
    this.qualification,
    this.sex,
    this.otp,
    required this.notifications,
    this.businessName,
    this.businessType,
    this.businessAddress,
    this.businessPincode,
    this.gst,
    this.pan,
    this.bankName,
    this.bankBranch,
    this.bankAccountNo,
    this.bankAccountName,
    this.ifsc,
    this.pancard1,
    this.pancard2,
    this.companyIncorporationCertificate1,
    this.companyIncorporationCertificate2,
    this.moa1,
    this.moa2,
    this.utilityBill1,
    this.utilityBill2,
    this.aadharCard1,
    this.aadharCard2,
    this.createdAt,
    this.updatedAt,
    this.shopLogo,
    required this.agreedToSellerAgreement,
    required this.agreedToPrivacyPolicy,
    required this.agreedToMarketplaceTerms,
    required this.responseRate,
    this.complianceScore,
    this.supplierId,
    required this.isFullProfileCompleted,
    required this.isInstructor,
    required this.isInstitution,
    this.bio,
    this.facebookLink,
    this.xLink,
    this.linkedinLink,
    this.youtubeLink,
    required this.profileEdit,
    this.headline,
    this.qhseExpertise,
    this.websiteUrl,
    this.accreditations,
    this.certificateName,
    required this.certificateNameLocked,
    this.state,
    this.region,
    required this.groups,
    required this.userPermissions,
    required this.operatingCategories,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      password: json['password'],
      lastLogin: json['last_login'],
      isSuperuser: json['is_superuser'] ?? false,
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      isStaff: json['is_staff'] ?? false,
      dateJoined: json['date_joined'],
      name: json['name'] ?? '',
      mobileNumber: json['mobile_number'],
      countryCode: json['country_code'] ?? '',
      profilePicture: json['profile_picture'],
      isActive: json['is_active']?.toString() ?? '',
      userType: json['user_type'] ?? '',
      fcmToken: json['fcm_token'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      status: json['status'] ?? '',
      mustChangePassword: json['must_change_password'] ?? false,
      country: json['country'],
      industry: json['industry'],
      scope: json['scope'],
      transactionId: json['transaction_id'],
      paymentPlatform: json['payment_platform'],
      qualification: json['qualification'],
      sex: json['sex'],
      otp: json['otp'],
      notifications: json['notifications'] ?? false,
      businessName: json['business_name'],
      businessType: json['business_type'],
      businessAddress: json['business_address'],
      businessPincode: json['business_pincode'],
      gst: json['gst'],
      pan: json['pan'],
      bankName: json['bank_name'],
      bankBranch: json['bank_branch'],
      bankAccountNo: json['bank_account_no'],
      bankAccountName: json['bank_account_name'],
      ifsc: json['ifsc'],
      pancard1: json['pancard_1'],
      pancard2: json['pancard_2'],
      companyIncorporationCertificate1:
          json['company_incorporation_certificate_1'],
      companyIncorporationCertificate2:
          json['company_incorporation_certificate_2'],
      moa1: json['moa_1'],
      moa2: json['moa_2'],
      utilityBill1: json['utitlity_bill_1'],
      utilityBill2: json['utitlity_bill_2'],
      aadharCard1: json['aadhar_card_1'],
      aadharCard2: json['aadhar_card_2'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      shopLogo: json['shop_logo'],
      agreedToSellerAgreement: json['agreed_to_seller_agreement'] ?? false,
      agreedToPrivacyPolicy: json['agreed_to_privacy_policy'] ?? false,
      agreedToMarketplaceTerms: json['agreed_to_marketplace_terms'] ?? false,
      responseRate: (json['response_rate'] as num?)?.toDouble() ?? 0.0,
      complianceScore: json['compliance_score'],
      supplierId: json['supplier_id']?.toString(),
      isFullProfileCompleted: json['is_full_profile_completed'] ?? false,
      isInstructor: json['is_instructor'] ?? false,
      isInstitution: json['is_institution'] ?? false,
      bio: json['bio'],
      facebookLink: json['facebook_link'],
      xLink: json['x_link'],
      linkedinLink: json['linkedin_link'],
      youtubeLink: json['youtube_link'],
      profileEdit: json['profile_edit'] ?? false,
      headline: json['headline'],
      qhseExpertise: json['qhse_expertise'],
      websiteUrl: json['website_url'],
      accreditations: json['accreditations'],
      certificateName: json['certificate_name'],
      certificateNameLocked: json['certificate_name_locked'] ?? false,
      state: json['state'],
      region: json['region'],
      groups: json['groups'] ?? [],
      userPermissions: json['user_permissions'] ?? [],
      operatingCategories: json['operating_categories'] ?? [],
      role: json['role'] ?? '',
    );
  }
}
