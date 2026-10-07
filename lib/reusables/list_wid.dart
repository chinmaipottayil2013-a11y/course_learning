import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/models/course_model.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ListWid extends StatelessWidget {
  final CourseModel courseModel;
  final int number;
  final int region;
  const ListWid({
    super.key,
    required this.courseModel,
    required this.number,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    final isAdded = context.watch<CartProvider>().isAlreadyAdded(
      courseModel.id,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E8F0)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D101828),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsConstants.containerColor,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: ColorsConstants.primary,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              courseModel.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                height: 1.3,
                letterSpacing: -0.2,
                color: ColorsConstants.textColor,
              ),
            ),
          ),
          const SizedBox(width: 12),

          ElevatedButton(
            onPressed: isAdded
                ? null
                : () async {
                    context.read<CartProvider>().addToCart(
                      courseId: courseModel.id,
                      region: region,
                    );
                  },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(75, 25),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: ColorsConstants.containerColor,
              foregroundColor: ColorsConstants.primary,
              disabledBackgroundColor: Colors.black12,
              disabledForegroundColor: ColorsConstants.textColor,
            ),
            child: Text(
              isAdded ? 'Added' : 'Add to cart',
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
