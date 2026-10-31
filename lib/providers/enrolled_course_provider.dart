import 'package:flutter/widgets.dart';
import 'package:learning_course2/models/enrolled_courses/enrolled_course_model.dart';
import 'package:learning_course2/models/enrolled_courses/enrolled_response_model.dart';

import 'package:learning_course2/services/enrolled_course_service.dart';

class EnrolledCourseProvider extends ChangeNotifier {
  final EnrolledCourseService _enrolledCourseService = EnrolledCourseService();
  EnrolledCoursesResponseModel? _enrolledCoursesResponseModel;

  int get totalCount => _enrolledCoursesResponseModel?.count ?? 0;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;
  String? errorMessage;

  int _page = 1;
  final int _pageSize = 10;
  String? _status;
  String? _search;

  List<EnrolledCourseModel> inProgressCourses = [];
  List<EnrolledCourseModel> completedCourses = [];

  // void addCourses(
  //   List<EnrolledCourseModel> existing,
  //   List<EnrolledCourseModel> newCourses,
  // ) {
  //   final existingIds = existing.map((course) => course.id).toSet();

  //   for (final course in newCourses) {
  //     if (existingIds.add(course.id)) {
  //       existing.add(course);
  //     }
  //   }
  // }

  Future<void> getEnrolledCourses({String? status, String? search}) async {
    _status = status;
    _search = search;
    _page = 1;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _enrolledCourseService.getEnrolledCourses(
        status: status,
        search: search,
        page: _page,
        pageSize: _pageSize,
      );

      _enrolledCoursesResponseModel = response;
      inProgressCourses = response.inProgress;
      completedCourses = response.completed;

      if (response.next != null) {
        hasMore = true;
      } else {
        hasMore = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (isLoading == true) {
      return;
    }
    if (isLoadingMore == true) {
      return;
    }
    if (hasMore == false) {
      return;
    }
    isLoadingMore = true;
    notifyListeners();

    try {
      int nextPage = _page + 1;
      final response = await _enrolledCourseService.getEnrolledCourses(
        status: _status,
        search: _search,
        page: nextPage,
        pageSize: _pageSize,
      );
      _page = nextPage;

      _enrolledCoursesResponseModel = response;
      inProgressCourses.addAll(response.inProgress);
      completedCourses.addAll(response.completed);

      if (response.next != null) {
        hasMore = true;
      } else {
        hasMore = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  // Future<void> searchEnrolledCourse(String query) async {
  //   await getEnrolledCourses(status: _status, search: query);
  // }

  // Future<void> filterByStatus(String? newStatus) async {
  //   await getEnrolledCourses(search: _search, status: newStatus);
  // }

  // Future<void> changePage(int page) async {
  //   await getEnrolledCourses(search: _search, status: _status);
  // }

  // Future<void> refreshEnrolledCourse() async {
  //   await getEnrolledCourses(status: _status, search: _search);
  // }
}
