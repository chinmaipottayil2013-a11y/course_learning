import 'package:learning_course2/models/enrolled_courses/enrolled_course_model.dart';

class EnrolledCoursesResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<EnrolledCourseModel> inProgress;
  final List<EnrolledCourseModel> completed;

  EnrolledCoursesResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.inProgress,
    required this.completed,
  });

  factory EnrolledCoursesResponseModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCoursesResponseModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      inProgress: (json['in_progress'] as List<dynamic>? ?? [])
          .map((e) => EnrolledCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      completed: (json['completed'] as List<dynamic>? ?? [])
          .map((e) => EnrolledCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'in_progress': inProgress.map((e) => e.toJson()).toList(),
      'completed': completed.map((e) => e.toJson()).toList(),
    };
  }
}
