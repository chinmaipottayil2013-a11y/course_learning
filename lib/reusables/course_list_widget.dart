import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/models/courses/course_model.dart';
import 'package:learning_course2/models/courses/region_selection_model.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:learning_course2/providers/favourite_screen_provider.dart';
import 'package:provider/provider.dart';

class ListWid extends StatelessWidget {
  final CourseModel courseModel;
  final int number;
  final int region;
  final RegionSelectionModel? regionSelectionModel;

  const ListWid({
    super.key,
    required this.courseModel,
    required this.number,
    required this.region,
    this.regionSelectionModel,
  });

  @override
  Widget build(BuildContext context) {
    context.watch<FavouriteScreenProvider>();

    final bool isAdded = courseModel.isCartAdded;
    final bool isFavourite = courseModel.isFavourite;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAECF0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 88,
              height: 92,
              child: Image.network(
                courseModel.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF2F4F7),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.menu_book_rounded,
                      size: 30,
                      color: Color(0xFF98A2B3),
                    ),
                  );
                },
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;

                  return Container(
                    color: const Color(0xFFF2F4F7),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SpinKitCircle(color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  courseModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                    letterSpacing: -0.25,
                    color: Color(0xFF101828),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsConstants.containerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${regionSelectionModel?.currency ?? 'INR'} ${courseModel.salePrice}',
                        style: TextStyle(
                          fontSize: 11,
                          color: ColorsConstants.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: isFavourite
                          ? null
                          : () async {
                              await context
                                  .read<FavouriteScreenProvider>()
                                  .addToFavourite(course: courseModel);
                            },
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton.icon(
                          onPressed: isAdded
                              ? null
                              : () async {
                                  await context.read<CartProvider>().addToCart(
                                    courseId: courseModel.id,
                                    region: region,
                                    context: context,
                                    currency:
                                        regionSelectionModel?.currency ?? 'INR',
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 0,
                            backgroundColor: isAdded
                                ? const Color(0xFFE8F7EE)
                                : ColorsConstants.primary,
                            foregroundColor: isAdded
                                ? const Color(0xFF16834A)
                                : Colors.white,
                            disabledBackgroundColor: const Color(0xFFE8F7EE),
                            disabledForegroundColor: const Color(0xFF16834A),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: isAdded
                                    ? const Color(0xFFC5EBD3)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isAdded
                                    ? Icons.check_circle_rounded
                                    : Icons.add_shopping_cart_rounded,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isAdded ? 'Added' : 'Add to cart',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
