class InstructorModel {
  final int id;
  final String name;
  final String slug;
  final String? image;
  final String? profileImage;
  final String? bio;
  final String? designation;
  final String? email;
  final String? linkedinUrl;
  final int experienceYears;
  final String? location;

  InstructorModel({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    this.profileImage,
    this.bio,
    this.designation,
    this.email,
    this.linkedinUrl,
    required this.experienceYears,
    this.location,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'],
      profileImage: json['profile_image'],
      bio: json['bio'],
      designation: json['designation'],
      email: json['email'],
      linkedinUrl: json['linkedin_url'],
      experienceYears: json['experience_years'] ?? 0,
      location: json['location'],
    );
  }
}
