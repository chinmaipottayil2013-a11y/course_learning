import 'package:learning_course2/models/courses/course_model.dart';

class CourseResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<CourseModel> results;

  CourseResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseResponseModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],

      results: (json['results'] as List? ?? [])
          .map((item) => CourseModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
