import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/models/cart/cart_item_model.dart';
import 'package:learning_course2/models/courses/region_selection_model.dart';

import 'package:learning_course2/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreenWidget extends StatelessWidget {
  final CartItemModel cartItemModel;
  final int number; // kept so existing callers don't break (no longer shown)
  final int regionId;
  final RegionSelectionModel? regionSelectionModel;

  const CartScreenWidget({
    super.key,
    required this.cartItemModel,
    required this.number,
    required this.regionId,
    this.regionSelectionModel,
  });

  @override
  Widget build(BuildContext context) {
    final course = cartItemModel.course;
    final String imageUrl = course.image;

    return Container(
      padding: const EdgeInsets.all(10),
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
          // ---- Thumbnail ----
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
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

          const SizedBox(width: 12),

          // ---- Name + price ----
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    letterSpacing: -0.2,
                    color: ColorsConstants.textColor,
                  ),
                ),
                const SizedBox(height: 8),
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
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: ColorsConstants.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          IconButton(
            onPressed: () async {
              await context.read<CartProvider>().deleteFromCart(
                courseId: course.id,
                region: regionId,
              );
            },
            tooltip: 'Remove course',
            style: IconButton.styleFrom(
              fixedSize: const Size(38, 38),
              padding: EdgeInsets.zero,
              backgroundColor: Colors.redAccent.withValues(alpha: 0.08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: Colors.redAccent,
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
