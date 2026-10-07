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
    required this.accreditationBody,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      email: json['email'] ?? '',
      url: json['url'] ?? '',
      accreditationBody: json['accreditation_body'],
    );
  }
}
