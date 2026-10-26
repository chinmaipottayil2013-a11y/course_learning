import 'package:flutter/material.dart';
import 'package:learning_course2/models/courses/course_model.dart';
import 'package:learning_course2/services/favourites_service.dart';

class FavouriteScreenProvider extends ChangeNotifier {
  final FavouritesService _favouritesService = FavouritesService();

  List<CourseModel> _courseModel = [];
  List<CourseModel> get courseModel => _courseModel;
  bool isLoading = false;
  String? errorMessage;

  Future<void> showFavourites() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      _courseModel = await _favouritesService.showFavourites();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToFavourite({required CourseModel course}) async {
    notifyListeners();
    try {
      await _favouritesService.addToFavourite(courseId: course.id);
      course.isFavourite = true;
      notifyListeners();
      _courseModel = await _favouritesService.showFavourites();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();

      notifyListeners();
    }
  }

  Future<void> removeFromFavourite({required CourseModel course}) async {
    try {
      await _favouritesService.addToFavourite(courseId: course.id);
      course.isFavourite = false;
      _courseModel.removeWhere((c) => c.id == course.id);
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
