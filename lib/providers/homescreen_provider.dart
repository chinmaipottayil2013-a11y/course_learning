import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_course2/models/courses/course_model.dart';
import 'package:learning_course2/models/courses/course_response_model.dart';
import 'package:learning_course2/models/courses/filters_model.dart';
import 'package:learning_course2/models/courses/region_selection_model.dart';
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
  int? selectedRegionId;
  String? selectedCountryCode;

  FiltersOptionsModel? _optionsModel;
  FiltersOptionsModel? get optionsModel => _optionsModel;

  bool isLoading = false;
  String? errorMessage;
  bool isRegionLoading = false;

  int currentPage = 1;
  int pageSize = 10;
  bool isLoadingMore = false;
  bool hasMore = true;

  List<CourseModel> _courseModel = [];
  List<CourseModel> get courseModel => _courseModel;

  RegionResponseModel? _regionResponseModel;
  RegionResponseModel? get regionResponseModel => _regionResponseModel;

  List<RegionSelectionModel> get regionSelectionModel =>
      _regionResponseModel?.results ?? [];

  String query = '';
  String? _categoryId;
  String? _levelId;
  String? _languageId;
  String? _industryId;

  Future<void> getCourses({required BuildContext context}) async {
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
        region: selectedRegionId?.toString(),
        context: context,
      );
      _courseResponseModel = courses;
      if (courseResponseModel != null) {
        _courseModel = courseResponseModel!.results;
        // log('Course details : ${courseResponseModel!.results}');

        // log("course length is ${courses.length}");
        // log("courseResponseModel!.count is ${courseResponseModel!.count}");
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

  Future<void> loadMoreCourses({required BuildContext context}) async {
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
        region: selectedRegionId?.toString(),
        context: context,
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

  Future<void> refreshProducts({required BuildContext context}) async {
    await getCourses(context: context);
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
    } catch (e, st) {
      log('Loading failed $e', stackTrace: st);
    }
  }

  Future<void> applyCategory(
    String? categoryId,
    String? levelId,
    String? languageId,
    String? industryId,
    BuildContext context,
  ) async {
    _categoryId = categoryId;
    _levelId = levelId;
    _languageId = languageId;
    _industryId = industryId;
    await getCourses(context: context);
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

  Future<void> getRegions() async {
    try {
      isRegionLoading = true;
      errorMessage = null;
      notifyListeners();
      _regionResponseModel =
          (await _courseListService.getListByRegion()) as RegionResponseModel?;
    } catch (e) {
      log(e.toString());
    } finally {
      isRegionLoading = false;
      notifyListeners();
    }
  }

  void selectedRegion(int id) {
    selectedCategoryId = id;
    final region = regionSelectionModel.firstWhere((item) => item.id == id);
    selectedCountryCode = region.countryCode;
    notifyListeners();
  }

  Future<void> applyRegion(int id, BuildContext context) async {
    selectedRegionId = id;
    selectedCountryCode = regionSelectionModel
        .where((r) => r.id == id)
        .firstOrNull
        ?.countryCode;
    notifyListeners();
    await getCourses(context: context);
  }
}
