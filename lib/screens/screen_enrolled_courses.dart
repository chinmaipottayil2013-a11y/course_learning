import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';

class ScreenEnrolledCourses extends StatefulWidget {
  const ScreenEnrolledCourses({super.key});

  @override
  State<ScreenEnrolledCourses> createState() => _ScreenEnrolledCoursesState();
}

class _ScreenEnrolledCoursesState extends State<ScreenEnrolledCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.background,
      appBar: AppBar(
        backgroundColor: ColorsConstants.background,
        title: const Text(
          'Enrolled courses',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
      ),
    );
  }
}
