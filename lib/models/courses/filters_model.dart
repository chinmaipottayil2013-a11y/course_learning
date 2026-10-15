import 'package:learning_course2/models/courses/course_details_model.dart';
import 'package:learning_course2/models/courses/institution_model.dart';
import 'package:learning_course2/models/courses/instructor_model.dart';
import 'package:learning_course2/models/courses/language_model.dart';
import 'package:learning_course2/models/courses/level_model.dart';

class FiltersOptionsModel {
  final List<CategoryModel> category;
  final List<IndustryModel> industry;
  final List<LevelModel> level;
  final List<LanguageModel> language;
  final List<InstructorModel> instructors;
  final List<InstitutionModel> institutions;

  FiltersOptionsModel({
    required this.category,
    required this.industry,
    required this.level,
    required this.language,
    required this.instructors,
    required this.institutions,
  });

  factory FiltersOptionsModel.fromJson(Map<String, dynamic> json) {
    return FiltersOptionsModel(
      category: (json['category'] as List? ?? [])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),

      industry: (json['industry'] as List? ?? [])
          .map((e) => IndustryModel.fromJson(e))
          .toList(),

      level: (json['level'] as List? ?? [])
          .map((e) => LevelModel.fromJson(e))
          .toList(),

      language: (json['language'] as List? ?? [])
          .map((e) => LanguageModel.fromJson(e))
          .toList(),

      instructors: (json['instructors'] as List? ?? [])
          .map((e) => InstructorModel.fromJson(e))
          .toList(),

      institutions: (json['institutions'] as List? ?? [])
          .map((e) => InstitutionModel.fromJson(e))
          .toList(),
    );
  }
}
