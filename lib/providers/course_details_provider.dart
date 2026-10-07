import 'package:flutter/foundation.dart';
import 'package:learning_course2/models/course_details_model.dart';
import 'package:learning_course2/services/course_details_service.dart';

class CourseDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  final CourseDetailsService _courseDetailsService = CourseDetailsService();
  CourseDetailsModel? courseDetailsModel;

  Future<void> fetchCourseDetails(String slug) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      courseDetailsModel = await _courseDetailsService.getCourseDetails(slug);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
