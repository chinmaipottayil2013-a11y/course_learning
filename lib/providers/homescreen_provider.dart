import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_course2/models/course_model.dart';
import 'package:learning_course2/models/course_response_mode.dart';
import 'package:learning_course2/models/filters_model.dart';
import 'package:learning_course2/services/course_list_service.dart';

class HomescreenProvider extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  final CourseListService _courseListService = CourseListService();
  CourseResponseModel? _courseResponseModel;
  CourseResponseModel? get courseResponseModel => _courseResponseModel;

  int? selectedCategoryId;
  int? selectedLevelId;
  int? selectedLanguageId;
  int? selectedIndustryId;

  FiltersOptionsModel? _optionsModel;
  FiltersOptionsModel? get optionsModel => _optionsModel;

  bool isLoading = false;
  String? errorMessage;

  int currentPage = 1;
  int pageSize = 10;
  bool isLoadingMore = false;
  bool hasMore = true;

  List<CourseModel> _courseModel = [];
  List<CourseModel> get courseModel => _courseModel;

  String query = '';
  String? _categoryId;
  String? _levelId;
  String? _languageId;
  String? _industryId;

  Future<void> getCourses() async {
    try {
      isLoading = true;
      errorMessage = null;
      hasMore = true;
      _courseModel.clear();
      currentPage = 1;
      notifyListeners();
      final courses = await _courseListService.getCourseList(
        page: currentPage,
        pageSize: pageSize,
        searchQuery: textEditingController.text.trim(),
        categoryId: _categoryId,
        levelId: _levelId,
        languageId: _languageId,
        industryId: _industryId,
      );
      _courseResponseModel = courses;
      if (courseResponseModel != null) {
        _courseModel = courseResponseModel!.results;
        // log('Course details : ${courseResponseModel!.results}');

        // log("course length is ${courses.length}");
        log("courseResponseModel!.count is ${courseResponseModel!.count}");
        if (courseResponseModel!.count < pageSize) {
          hasMore = false;
        }
      }
    } catch (e) {
      log("error in the provider is ${e.toString()}");
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCourses() async {
    if (!hasMore || isLoadingMore) return;
    try {
      isLoadingMore = true;
      errorMessage = null;
      notifyListeners();
      final nextPage = currentPage + 1;
      final newCourses = await _courseListService.getCourseList(
        page: nextPage,
        pageSize: pageSize,
        categoryId: _categoryId,
        levelId: _levelId,
        languageId: _languageId,
        industryId: _industryId,
      );
      _courseModel.addAll(newCourses.results);
      currentPage = nextPage;
      if (newCourses.count < pageSize) {
        hasMore = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> refreshProducts() async {
    await getCourses();
  }

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

  Future<void> applyCategory(
    String? categoryId,
    String? levelId,
    String? languageId,
    String? industryId,
  ) async {
    _categoryId = categoryId;
    _levelId = levelId;
    _languageId = languageId;
    _industryId = industryId;
    await getCourses();
  }

  void markCourseAsAdded(int courseId) {
    final index = _courseModel.indexWhere((course) => courseId == course.id);
    // log('markCourseAsAdded: id=$courseId index=$index');

    if (index != -1) {
      _courseModel[index] = _courseModel[index].copyWith(isCartAdded: true);
      // log('after update: ${_courseModel[index].isCartAdded}');
      notifyListeners();
    }
  }
}
