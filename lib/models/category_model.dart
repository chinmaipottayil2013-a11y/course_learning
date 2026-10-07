class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String? metaTitle;
  final String? metaDescription;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
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
