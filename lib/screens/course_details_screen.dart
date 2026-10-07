import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/course_details_provider.dart';
import 'package:provider/provider.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String slug;

  const CourseDetailsScreen({super.key, required this.slug});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.microtask(() => getDetails()),
    );
  }

  void getDetails() {
    context.read<CourseDetailsProvider>().fetchCourseDetails(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseDetailsProvider>();
    final course = provider.courseDetailsModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          course?.name ?? 'Course Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(CourseDetailsProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Text(provider.errorMessage!, textAlign: TextAlign.center),
      );
    }

    final course = provider.courseDetailsModel;

    if (course == null) {
      return const Center(child: Text('Course not found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (course.image != null && course.image!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                course.image!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),

          const SizedBox(height: 20),

          Text(
            course.name!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            '₹${course.salePrice}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF16A34A),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              buildChip('${course.level}', Icons.bar_chart_rounded),
              buildChip("${course.language}", Icons.language_rounded),
              buildChip('${course.totalHour} hours', Icons.schedule),
            ],
          ),

          const SizedBox(height: 20),

          if (course.smallDescription?.isNotEmpty == true)
            Text(course.smallDescription!),

          const SizedBox(height: 20),

          if (course.intendedFor?.isNotEmpty == true) ...[
            const Text(
              'Intended For',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(course.intendedFor!),
            const SizedBox(height: 20),
          ],

          if (course.requirements?.isNotEmpty == true) ...[
            const Text(
              'Requirements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(course.requirements!),
          ],
        ],
      ),
    );
  }

  Widget buildChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorsConstants.containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: ColorsConstants.primary),
          SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(color: ColorsConstants.primary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
