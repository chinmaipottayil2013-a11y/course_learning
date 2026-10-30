import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/enrolled_course_provider.dart';
import 'package:provider/provider.dart';

class ScreenEnrolledCourses extends StatefulWidget {
  const ScreenEnrolledCourses({super.key});

  @override
  State<ScreenEnrolledCourses> createState() => _ScreenEnrolledCoursesState();
}

class _ScreenEnrolledCoursesState extends State<ScreenEnrolledCourses> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDatas();
    });
  }

  void getDatas() {
    context.read<EnrolledCourseProvider>().getEnrolledCourses(
      status: 'in_progress',
    );
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<EnrolledCourseProvider>();
    String inTabName = 'In-Progress Courses';

    if (progressProvider.totalCount > 0) {
      inTabName = 'In-Progress Courses (${progressProvider.totalCount})';
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorsConstants.background,
        appBar: AppBar(
          backgroundColor: ColorsConstants.background,
          title: const Text(
            'Enrolled courses',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
          ),
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.w700),
            tabs: [
              Tab(text: inTabName),
              Tab(text: 'Completed Courses'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EnrolledCourses(),
            Center(child: Text('Completed Courses')),
          ],
        ),
      ),
    );
  }
}

class EnrolledCourses extends StatefulWidget {
  const EnrolledCourses({super.key});

  @override
  State<EnrolledCourses> createState() => _EnrolledCoursesState();
}

class _EnrolledCoursesState extends State<EnrolledCourses> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {
      context.read<EnrolledCourseProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer<EnrolledCourseProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage!));
              }
              final enrolledCourses = provider.inProgressCourses;
              if (enrolledCourses.isEmpty) {
                return const Center(child: Text('No Enrolled courses found'));
              }
              int itemCount = enrolledCourses.length;
              if (provider.hasMore) {
                itemCount = itemCount + 1;
              }
              return Expanded(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: enrolledCourses.length,
                  itemBuilder: (context, index) {
                    if (index == enrolledCourses.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final enrolled = enrolledCourses[index];
                    final course = enrolled.course;

                    return ListTile(
                      leading: Image.network(
                        course.image,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                      title: Text(course.name),
                      subtitle: Text(enrolled.status),
                      trailing: Text('${course.completedPercentage}%'),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
