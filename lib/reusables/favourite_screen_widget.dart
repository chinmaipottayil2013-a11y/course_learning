import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';

import 'package:learning_course2/models/courses/course_model.dart';
import 'package:learning_course2/models/courses/region_selection_model.dart';
import 'package:learning_course2/providers/favourite_screen_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreenWidget extends StatelessWidget {
  final CourseModel courseModel;
  final RegionSelectionModel? regionSelectionModel;
  final int number; // kept so existing callers don't break (no longer shown)
  const FavouriteScreenWidget({
    super.key,
    this.regionSelectionModel,
    required this.courseModel,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    final course = courseModel;
    final String imageUrl = course.image;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEAECF0)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A101828),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: SizedBox(
              width: 84,
              height: 84,
              child: imageUrl.isEmpty
                  ? _placeholder()
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : Container(
                              color: ColorsConstants.containerColor,
                              alignment: Alignment.center,
                              child: const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: ColorsConstants.primary,
                                ),
                              ),
                            ),
                      errorBuilder: (_, _, _) => _placeholder(),
                    ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 6, 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      letterSpacing: -0.2,
                      color: ColorsConstants.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsConstants.containerColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${regionSelectionModel?.currency ?? 'INR'} ${course.salePrice}',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: ColorsConstants.primary,
                          ),
                        ),
                      ),
                      const Spacer(),

                      IconButton(
                        onPressed: () async {
                          log('HEART TAPPED: ${courseModel.id}');
                          await context
                              .read<FavouriteScreenProvider>()
                              .removeFromFavourite(course: courseModel);
                        },
                        style: IconButton.styleFrom(
                          fixedSize: const Size(36, 36),
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.red.withValues(alpha: 0.08),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(
                          Icons.favorite,
                          size: 19,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(
    color: ColorsConstants.containerColor,
    alignment: Alignment.center,
    child: const Icon(
      Icons.school_outlined,
      size: 30,
      color: ColorsConstants.primary,
    ),
  );
}
