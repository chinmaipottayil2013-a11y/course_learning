class InstitutionModel {
  final int id;
  final String name;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final String? legalName;
  final String? institutionType;
  final bool isLegallyRegistered;
  final String? registrationNumber;
  final String? registrationAuthority;
  final String? gstin;
  final String? panNumber;
  final bool hasAccreditations;
  final String? slug;
  final String? logo;
  final String? description;
  final String? contactNumber;
  final String? email;
  final String? url;
  final String? accreditationBody;
  final String? vimeoFolderUri;
  final bool isInternal;
  final String? legalEntityType;
  final int? establishedYear;
  final bool? gstRegistered;
  final String? country;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? registrationDate;
  final String? signatoryName;
  final String? signatoryRole;
  final String? signatoryEmail;
  final String? signatoryPhone;
  final String? tagline;
  final String? headquarters;
  final int experienceYears;
  final String? brochure;
  final String? bannerImage;
  final String? websiteUrl;
  final String? linkedinUrl;
  final String? youtubeUrl;
  final String? twitterUrl;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? bankAccountHolderName;
  final String? bankAccountNumber;
  final String? bankIfscCode;
  final String? bankName;
  final String? bankBranch;
  final String? bankAccountType;
  final double? commissionRate;
  final int? user;

  InstitutionModel({
    required this.id,
    required this.name,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.legalName,
    this.institutionType,
    required this.isLegallyRegistered,
    this.registrationNumber,
    this.registrationAuthority,
    this.gstin,
    this.panNumber,
    required this.hasAccreditations,
    this.slug,
    this.logo,
    this.description,
    this.contactNumber,
    this.email,
    this.url,
    this.accreditationBody,
    this.vimeoFolderUri,
    required this.isInternal,
    this.legalEntityType,
    this.establishedYear,
    this.gstRegistered,
    this.country,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.registrationDate,
    this.signatoryName,
    this.signatoryRole,
    this.signatoryEmail,
    this.signatoryPhone,
    this.tagline,
    this.headquarters,
    required this.experienceYears,
    this.brochure,
    this.bannerImage,
    this.websiteUrl,
    this.linkedinUrl,
    this.youtubeUrl,
    this.twitterUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.bankAccountHolderName,
    this.bankAccountNumber,
    this.bankIfscCode,
    this.bankName,
    this.bankBranch,
    this.bankAccountType,
    this.commissionRate,
    this.user,
  });

  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      id: json['id'],
      name: json['name'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      legalName: json['legal_name'],
      institutionType: json['institution_type'],
      isLegallyRegistered: json['is_legally_registered'] ?? false,
      registrationNumber: json['registration_number'],
      registrationAuthority: json['registration_authority'],
      gstin: json['gstin'],
      panNumber: json['pan_number'],
      hasAccreditations: json['has_accreditations'] ?? false,
      slug: json['slug'],
      logo: json['logo'],
      description: json['description'],
      contactNumber: json['contact_number'],
      email: json['email'],
      url: json['url'],
      accreditationBody: json['accreditation_body'],
      vimeoFolderUri: json['vimeo_folder_uri'],
      isInternal: json['is_internal'] ?? false,
      legalEntityType: json['legal_entity_type'],
      establishedYear: json['established_year'],
      gstRegistered: json['gst_registered'],
      country: json['country'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      registrationDate: json['registration_date'],
      signatoryName: json['signatory_name'],
      signatoryRole: json['signatory_role'],
      signatoryEmail: json['signatory_email'],
      signatoryPhone: json['signatory_phone'],
      tagline: json['tagline'],
      headquarters: json['headquarters'],
      experienceYears: json['experience_years'] ?? 0,
      brochure: json['brochure'],
      bannerImage: json['banner_image'],
      websiteUrl: json['website_url'],
      linkedinUrl: json['linkedin_url'],
      youtubeUrl: json['youtube_url'],
      twitterUrl: json['twitter_url'],
      facebookUrl: json['facebook_url'],
      instagramUrl: json['instagram_url'],
      bankAccountHolderName: json['bank_account_holder_name'],
      bankAccountNumber: json['bank_account_number'],
      bankIfscCode: json['bank_ifsc_code'],
      bankName: json['bank_name'],
      bankBranch: json['bank_branch'],
      bankAccountType: json['bank_account_type'],
      commissionRate: json['commission_rate'] == null
          ? null
          : double.tryParse(json['commission_rate'].toString()),
      user: json['user'],
    );
  }
}
