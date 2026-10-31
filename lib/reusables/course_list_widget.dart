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
  final int region;
  final RegionSelectionModel? regionSelectionModel;

  const ListWid({
    super.key,
    required this.courseModel,
    required this.region,
    this.regionSelectionModel,
  });

  @override
  Widget build(BuildContext context) {
    context.watch<FavouriteScreenProvider>();

    final bool isAdded = courseModel.isCartAdded;
    final bool isFavourite = courseModel.isFavourite;
    final String currency = regionSelectionModel?.currency ?? 'INR';
    final bool isPurchased = courseModel.isPurchased;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAECF0)),
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
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  courseModel.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: const Color(0xFFF2F4F7),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.menu_book_rounded,
                      size: 28,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: const Color(0xFFF2F4F7),
                      alignment: Alignment.center,
                      child: const SpinKitCircle(color: Colors.blue, size: 20),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.access_time_sharp, size: 12),
              const SizedBox(width: 2),
              Text(
                '${courseModel.totalHour} hr',
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 5),

          SizedBox(
            height: 40,
            child: Text(
              courseModel.name,
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

          const SizedBox(height: 6),

          const Divider(thickness: 0.8, indent: 8, endIndent: 8),

          const SizedBox(height: 3),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: ColorsConstants.containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$currency ${courseModel.salePrice}',
                  style: TextStyle(
                    fontSize: 10,
                    color: ColorsConstants.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$currency ${courseModel.mrp.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.black54,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 34,
                  child: ElevatedButton.icon(
                    onPressed: isPurchased
                        ? null
                        : isAdded
                        ? null
                        : () => context.read<CartProvider>().addToCart(
                            courseId: courseModel.id,
                            region: region,
                            context: context,
                            currency: currency,
                          ),
                    icon: Icon(
                      isPurchased
                          ? Icons.my_library_books_outlined
                          : isAdded
                          ? Icons.check_circle_rounded
                          : Icons.add_shopping_cart_rounded,
                      size: 14,
                    ),
                    label: Text(
                      isPurchased
                          ? 'Go to course'
                          : isAdded
                          ? 'Added'
                          : 'Add',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: ColorsConstants.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: isPurchased
                          ? Colors.yellow.shade300
                          : const Color(0xFFE8F7EE),
                      disabledForegroundColor: isPurchased
                          ? Colors.brown
                          : const Color(0xFF16834A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              SizedBox(
                width: 34,
                height: 34,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: isFavourite
                        ? null
                        : () => context
                              .read<FavouriteScreenProvider>()
                              .addToFavourite(course: courseModel),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.expand(),
                    iconSize: 16,
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
