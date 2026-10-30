import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';

import 'package:learning_course2/models/enrolled_courses/enrolled_coursecourse_model.dart';

class EnrolledWidget extends StatelessWidget {
  final EnrolledCourseCourseModel courseCourseModel;
  const EnrolledWidget({super.key, required this.courseCourseModel});

  Widget _placeholder(Widget child) => Container(
    color: const Color(0xFFF2F4F7),
    alignment: Alignment.center,
    child: child,
  );

  Widget buildTag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: ColorsConstants.containerColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: ColorsConstants.primary,
        fontWeight: FontWeight.w600,
        fontSize: 9,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final course = courseCourseModel;

    return Container(
      padding: EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(18),
              child: Image.network(
                course.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _placeholder(
                  const Icon(
                    Icons.menu_book,
                    size: 28,
                    color: Color(0xFF98A2B3),
                  ),
                ),
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : _placeholder(
                        const SpinKitCircle(color: Colors.blue, size: 20),
                      ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    buildTag('${course.totalHour}hr'),
                    buildTag(courseCourseModel.level),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 40,
                  child: Text(
                    course.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                      color: Color(0xFF101828),
                      height: 1.3,
                    ),
                  ),
                ),

                Flexible(
                  child: Text(
                    course.smallDescription,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ),
                SizedBox(height: 6),

                Row(
                  children: [
                    Text(
                      'Progress',
                      style: TextStyle(color: Colors.black87, fontSize: 10),
                    ),
                    const Spacer(),
                    Text(
                      '0 %',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: 0.0,
                  backgroundColor: Colors.grey.shade200,

                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black12),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Continue learning',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
