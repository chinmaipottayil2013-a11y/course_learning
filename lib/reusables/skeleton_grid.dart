import 'package:flutter/material.dart';

// Placeholder grid shown while courses load. Mirrors the ListWid card layout.
class CourseSkeletonGrid extends StatefulWidget {
  final int itemCount;

  const CourseSkeletonGrid({super.key, this.itemCount = 6});

  @override
  State<CourseSkeletonGrid> createState() => _CourseSkeletonGridState();
}

class _CourseSkeletonGridState extends State<CourseSkeletonGrid>
    with SingleTickerProviderStateMixin {
  // One controller drives the pulse for every card, so they stay in sync
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
        // Same delegate as the real grid so nothing jumps when data arrives
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 300,
        ),
        itemBuilder: (_, _) => const _SkeletonCard(),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  // Grey rounded block used for every placeholder shape
  Widget _bone({double? width, required double height, double radius = 6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE4E7EC),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          _bone(width: double.infinity, height: 100, radius: 10),
          const SizedBox(height: 10),
          // Duration
          _bone(width: 50, height: 12),
          const SizedBox(height: 8),
          // Title (two lines)
          _bone(width: double.infinity, height: 12),
          const SizedBox(height: 6),
          _bone(width: 90, height: 12),
          const SizedBox(height: 14),
          // Price
          Row(
            children: [
              _bone(width: 60, height: 20, radius: 12),
              const SizedBox(width: 8),
              _bone(width: 36, height: 8),
            ],
          ),
          const Spacer(),
          // Add + favourite buttons
          Row(
            children: [
              Expanded(child: _bone(height: 34, radius: 18)),
              const SizedBox(width: 8),
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFFE4E7EC),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
