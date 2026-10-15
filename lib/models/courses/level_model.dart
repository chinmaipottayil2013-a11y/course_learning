class LevelModel {
  final int id;
  final String name;
  final String? image;

  LevelModel({required this.id, required this.name, this.image});

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(id: json['id'], name: json['name'], image: json['image']);
  }
}
