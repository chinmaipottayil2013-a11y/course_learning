import 'package:flutter/material.dart';

class EnrolledCourseSkeletonGrid extends StatefulWidget {
  final int itemCount;

  const EnrolledCourseSkeletonGrid({super.key, this.itemCount = 6});

  @override
  State<EnrolledCourseSkeletonGrid> createState() =>
      _EnrolledCourseSkeletonGridState();
}

class _EnrolledCourseSkeletonGridState extends State<EnrolledCourseSkeletonGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  late final Animation<double> _opacity = Tween<double>(
    begin: 0.4,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 370,
        ),
        itemBuilder: (_, _) => const _EnrolledSkeletonCard(),
      ),
    );
  }
}

class _EnrolledSkeletonCard extends StatelessWidget {
  const _EnrolledSkeletonCard();

  static const Color _boneColor = Color(0xFFE4E7EC);

  Widget _bone({double? width, required double height, double radius = 6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _boneColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(5),
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
        children: [
          // Course image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _boneColor,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),

          // Course details
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Duration and level tags
                Row(
                  children: [
                    _bone(width: 38, height: 18, radius: 20),
                    const SizedBox(width: 5),
                    _bone(width: 48, height: 18, radius: 20),
                  ],
                ),

                const SizedBox(height: 8),

                // Course title: two lines
                _bone(width: double.infinity, height: 12),
                const SizedBox(height: 6),
                _bone(width: 95, height: 12),

                const SizedBox(height: 8),

                // Short description
                _bone(width: double.infinity, height: 10),

                const SizedBox(height: 12),

                // Progress label and percentage
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bone(width: 42, height: 10),
                    _bone(width: 22, height: 10),
                  ],
                ),

                const SizedBox(height: 10),

                // Progress bar
                _bone(width: double.infinity, height: 6, radius: 10),

                const SizedBox(height: 15),

                // Continue learning button
                _bone(width: double.infinity, height: 35, radius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
