class CourseInstructorModel {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String profileImage;
  final String bio;
  final String designation;
  final String email;
  final String linkedinUrl;
  final int experienceYears;
  final String location;

  CourseInstructorModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.profileImage,
    required this.bio,
    required this.designation,
    required this.email,
    required this.linkedinUrl,
    required this.experienceYears,
    required this.location,
  });

  factory CourseInstructorModel.fromJson(Map<String, dynamic> json) {
    return CourseInstructorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      profileImage: json['profile_image'] ?? '',
      bio: json['bio'] ?? '',
      designation: json['designation'] ?? '',
      email: json['email'] ?? '',
      linkedinUrl: json['linkedin_url'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'profile_image': profileImage,
      'bio': bio,
      'designation': designation,
      'email': email,
      'linkedin_url': linkedinUrl,
      'experience_years': experienceYears,
      'location': location,
    };
  }
}
