class UserProfileModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String? profilePicture;
  final String? certificateProfileImage;
  final String bio;
  final String designation;
  final String facebookLink;
  final String xLink;
  final String linkedinLink;
  final String youtubeLink;
  final bool profileEdit;
  final String mobileNumber;
  final String userType;
  final bool isInstructor;
  final bool isInstitution;
  final bool isInstitutionMember;
  final bool isInstitutionOwner;
  final bool isOwner;
  final String role;
  final List<dynamic> institutionMemberships;
  final bool hasActiveSubscription;
  final dynamic activeSubscriptionPlan;
  final String? certificateName;
  final bool certificateNameLocked;
  final bool canEditCertificateName;
  final bool isFullProfileCompleted;
  final bool requiresProfileCompletion;
  final bool isIndependentInstructor;
  final bool hasDualRole;

  UserProfileModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.profilePicture,
    this.certificateProfileImage,
    required this.bio,
    required this.designation,
    required this.facebookLink,
    required this.xLink,
    required this.linkedinLink,
    required this.youtubeLink,
    required this.profileEdit,
    required this.mobileNumber,
    required this.userType,
    required this.isInstructor,
    required this.isInstitution,
    required this.isInstitutionMember,
    required this.isInstitutionOwner,
    required this.isOwner,
    required this.role,
    required this.institutionMemberships,
    required this.hasActiveSubscription,
    this.activeSubscriptionPlan,
    this.certificateName,
    required this.certificateNameLocked,
    required this.canEditCertificateName,
    required this.isFullProfileCompleted,
    required this.requiresProfileCompletion,
    required this.isIndependentInstructor,
    required this.hasDualRole,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profilePicture: json['profile_picture'],
      certificateProfileImage: json['certificate_profile_image'],
      bio: json['bio'] ?? '',
      designation: json['designation'] ?? '',
      facebookLink: json['facebook_link'] ?? '',
      xLink: json['x_link'] ?? '',
      linkedinLink: json['linkedin_link'] ?? '',
      youtubeLink: json['youtube_link'] ?? '',
      profileEdit: json['profile_edit'] ?? false,
      mobileNumber: json['mobile_number'] ?? '',
      userType: json['user_type'] ?? '',
      isInstructor: json['is_instructor'] ?? false,
      isInstitution: json['is_institution'] ?? false,
      isInstitutionMember: json['is_institution_member'] ?? false,
      isInstitutionOwner: json['is_institution_owner'] ?? false,
      isOwner: json['is_owner'] ?? false,
      role: json['role'] ?? '',
      institutionMemberships: json['institution_memberships'] ?? [],
      hasActiveSubscription: json['has_active_subscription'] ?? false,
      activeSubscriptionPlan: json['active_subscription_plan'],
      certificateName: json['certificate_name'],
      certificateNameLocked: json['certificate_name_locked'] ?? false,
      canEditCertificateName: json['can_edit_certificate_name'] ?? false,
      isFullProfileCompleted: json['is_full_profile_completed'] ?? false,
      requiresProfileCompletion: json['requires_profile_completion'] ?? false,
      isIndependentInstructor: json['is_independent_instructor'] ?? false,
      hasDualRole: json['has_dual_role'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'profile_picture': profilePicture,
      'certificate_profile_image': certificateProfileImage,
      'bio': bio,
      'designation': designation,
      'facebook_link': facebookLink,
      'x_link': xLink,
      'linkedin_link': linkedinLink,
      'youtube_link': youtubeLink,
      'profile_edit': profileEdit,
      'mobile_number': mobileNumber,
      'user_type': userType,
      'is_instructor': isInstructor,
      'is_institution': isInstitution,
      'is_institution_member': isInstitutionMember,
      'is_institution_owner': isInstitutionOwner,
      'is_owner': isOwner,
      'role': role,
      'institution_memberships': institutionMemberships,
      'has_active_subscription': hasActiveSubscription,
      'active_subscription_plan': activeSubscriptionPlan,
      'certificate_name': certificateName,
      'certificate_name_locked': certificateNameLocked,
      'can_edit_certificate_name': canEditCertificateName,
      'is_full_profile_completed': isFullProfileCompleted,
      'requires_profile_completion': requiresProfileCompletion,
      'is_independent_instructor': isIndependentInstructor,
      'has_dual_role': hasDualRole,
    };
  }
}
