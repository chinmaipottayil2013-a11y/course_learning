import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:learning_course2/models/filters_model.dart';
import 'package:learning_course2/services/course_list_service.dart';

class FilterProvider extends ChangeNotifier {
  int? selectedCategoryId;
  int? selectedLevelId;
  int? selectedLanguageId;
  int? selectedIndustryId;

  FiltersOptionsModel? _optionsModel;
  final CourseListService _courseListService = CourseListService();

  FiltersOptionsModel? get optionsModel => _optionsModel;

  void selectedCategory(int id) {
    selectedCategoryId = selectedCategoryId == id ? null : id;
    notifyListeners();
  }

  void selectedLevel(int id) {
    selectedLevelId = selectedLevelId == id ? null : id;
    notifyListeners();
  }

  void selectedLanguage(int id) {
    selectedLanguageId = selectedLanguageId == id ? null : id;
    notifyListeners();
  }

  void selectedIndustry(int id) {
    selectedIndustryId = selectedIndustryId == id ? null : id;
    notifyListeners();
  }

  void clearFilters() {
    selectedCategoryId = null;
    selectedLevelId = null;
    selectedIndustryId = null;
    selectedLanguageId = null;
    notifyListeners();
  }

  Future<void> getFilters() async {
    try {
      _optionsModel = await _courseListService.getFilters();
      notifyListeners();
    } catch (e) {
      log('Loading failed $e');
    }
  }
}
