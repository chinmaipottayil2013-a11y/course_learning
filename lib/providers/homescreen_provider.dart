import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_course2/models/course_model.dart';
import 'package:learning_course2/models/course_response_mode.dart';
import 'package:learning_course2/services/course_list_service.dart';

class HomescreenProvider extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  final CourseListService _courseListService = CourseListService();
  CourseResponseModel? courseResponseModel;

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
      courseResponseModel = courses;
      if (courseResponseModel != null) {
        _courseModel = courseResponseModel!.results;
        // log("course length is ${courses.length}");
        log("courseResponseModel!.count is ${courseResponseModel!.count}");
        if (courseResponseModel!.count < pageSize) {
          hasMore = false;
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCourses() async {
    log("has more is $hasMore and isLoadingMore is $isLoadingMore");
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
}
