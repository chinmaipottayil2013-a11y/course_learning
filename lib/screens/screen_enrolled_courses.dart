import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/enrolled_course_provider.dart';
import 'package:learning_course2/reusables/enrolled_widget.dart';
import 'package:learning_course2/reusables/skeleton_enrolled.dart';
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
    final totalCount = context.watch<EnrolledCourseProvider>().totalCount;
    final inTabName = totalCount > 0
        ? 'In-Progress Courses ($totalCount)'
        : 'In-Progress Courses';
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorsConstants.background,
        appBar: AppBar(
          backgroundColor: ColorsConstants.background,
          title: Text(
            'Enrolled Courses',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.blue.shade900,
            unselectedLabelColor: Colors.grey,
            dividerColor: Colors.transparent,
            labelColor: Colors.blue.shade900,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                height: 50,

                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(inTabName, style: TextStyle(fontSize: 13)),
                ),
              ),
              Tab(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Completed Courses',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EnrolledCourses(),
            Center(child: Text('No completed courses')),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {
      context.read<EnrolledCourseProvider>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 10),
      controller: _controller,
      child: Consumer<EnrolledCourseProvider>(
        builder: (context, provider, child) {
          final enrolledCourses = provider.inProgressCourses;
          if (provider.isLoading && enrolledCourses.isEmpty) {
            return EnrolledCourseSkeletonGrid();
          }
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }
          if (enrolledCourses.isEmpty) {
            return Center(child: Text('No enrolled courses found'));
          }
          final itemCount = enrolledCourses.length;

          return Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: itemCount,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  return EnrolledWidget(
                    courseCourseModel: enrolledCourses[index].course,
                  );
                },
              ),
              if (provider.isLoadingMore)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.blue.shade900,
                      size: 20,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
