import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/providers/homescreen_provider.dart';
import 'package:learning_course2/reusables/course_list_widget.dart';
import 'package:learning_course2/screens/screen_login.dart';
import 'package:learning_course2/screens/screen_course_details.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _HomescreenState();
}

class _HomescreenState extends State<ScreenHome> {
  final ScrollController _controller = ScrollController();

  void getDatas() async {
    await Future.wait([
      context.read<HomescreenProvider>().getCourses(context: context),
      context.read<HomescreenProvider>().getFilters(),
      context.read<HomescreenProvider>().getRegions(),
    ]);
  }

  void scrollListener() {
    if (!_controller.hasClients || !_controller.position.hasContentDimensions) {
      return;
    }

    final homeProvider = context.read<HomescreenProvider>();

    if (_controller.position.pixels >
        _controller.position.maxScrollExtent - 300) {
      homeProvider.loadMoreCourses(context: context);
    }
  }

  Future<void> logout() async {
    await context.read<AuthenticationProvider>().logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const ScreenLogin()),
      (route) => false,
    );
  }

  // Country dropdown widget
  Widget buildCountryDropDown() {
    return Consumer<HomescreenProvider>(
      builder: (context, provider, child) {
        if (provider.isRegionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.regionSelectionModel.isEmpty) {
          return const Text('No countries available');
        }

        // Selected region (null if the id matches nothing)
        final selectedRegion = provider.regionSelectionModel
            .where((region) => region.id == provider.selectedRegionId)
            .firstOrNull;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE9EBF2)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isExpanded: true,
              value: selectedRegion?.id,
              hint: Text(selectedRegion?.name ?? 'Select Country'),
              borderRadius: BorderRadius.circular(16),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ColorsConstants.primary,
              ),
              items: provider.regionSelectionModel.map((region) {
                return DropdownMenuItem<int>(
                  value: region.id,
                  child: Text(
                    region.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorsConstants.textColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (int? id) async {
                if (id == null) return;

                await provider.applyRegion(id, context);
              },
            ),
          ),
        );
      },
    );
  }

  // Filter chips widget
  Widget buildFilterChips({
    required String heading,
    required List<dynamic> items,
    required int? selectedId,
    required Function(int) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorsConstants.textColor,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items.map((item) {
            final bool isSelected = selectedId == item.id;

            return ChoiceChip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              showCheckmark: false,
              label: Text(item.name ?? ''),
              selected: isSelected,
              onSelected: (_) {
                onSelected(item.id ?? 0);
              },
              selectedColor: ColorsConstants.containerColor,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: isSelected
                    ? ColorsConstants.primary
                    : const Color(0xFFE7E9F0),
              ),
              labelStyle: TextStyle(
                color: isSelected
                    ? ColorsConstants.primary
                    : ColorsConstants.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Filters bottom sheet
  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFFFCFCFF),
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext sheetContext) {
        return SizedBox(
          width: double.infinity,
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(sheetContext).size.height * 0.75,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: ColorsConstants.textColor,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            sheetContext
                                .read<HomescreenProvider>()
                                .clearFilters();
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: ColorsConstants.textColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Builder(
                          builder: (context) {
                            final filterProvider = context
                                .watch<HomescreenProvider>();

                            final options = filterProvider.optionsModel;

                            if (options == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildFilterChips(
                                  heading: 'Categories',
                                  items: options.category,
                                  selectedId: filterProvider.selectedCategoryId,
                                  onSelected: (id) {
                                    context
                                        .read<HomescreenProvider>()
                                        .selectedCategory(id);
                                  },
                                ),
                                const SizedBox(height: 20),
                                buildFilterChips(
                                  heading: 'Level',
                                  items: options.level,
                                  selectedId: filterProvider.selectedLevelId,
                                  onSelected: (id) {
                                    context
                                        .read<HomescreenProvider>()
                                        .selectedLevel(id);
                                  },
                                ),
                                const SizedBox(height: 20),
                                buildFilterChips(
                                  heading: 'Language',
                                  items: options.language,
                                  selectedId: filterProvider.selectedLanguageId,
                                  onSelected: (id) {
                                    context
                                        .read<HomescreenProvider>()
                                        .selectedLanguage(id);
                                  },
                                ),
                                const SizedBox(height: 20),
                                buildFilterChips(
                                  heading: 'Industry',
                                  items: options.industry,
                                  selectedId: filterProvider.selectedIndustryId,
                                  onSelected: (id) {
                                    context
                                        .read<HomescreenProvider>()
                                        .selectedIndustry(id);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          final filterProvider = sheetContext
                              .read<HomescreenProvider>();

                          final categoryId = filterProvider.selectedCategoryId;
                          final levelId = filterProvider.selectedLevelId;
                          final languageId = filterProvider.selectedLanguageId;
                          final industryId = filterProvider.selectedIndustryId;

                          log('Category: $categoryId');
                          log('Level: $levelId');
                          log('Language: $languageId');
                          log('Industry: $industryId');

                          Navigator.pop(sheetContext);

                          context.read<HomescreenProvider>().applyCategory(
                            categoryId?.toString(),
                            languageId?.toString(),
                            levelId?.toString(),
                            industryId?.toString(),
                            context,
                          );
                        },
                        style: FilledButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: ColorsConstants.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() => getDatas());
    });
  }

  @override
  void dispose() {
    _controller.removeListener(scrollListener);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: ColorsConstants.background,
        centerTitle: true,
        title: const Text(
          'Course Learning',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: ColorsConstants.textColor,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Consumer<HomescreenProvider>(
        builder: (context, homeScreenProvider, child) {
          // Declared here so the whole body, including itemBuilder, can use it
          final selectedRegion = homeScreenProvider.regionSelectionModel
              .where((r) => r.id == homeScreenProvider.selectedRegionId)
              .firstOrNull;

          return RefreshIndicator(
            color: ColorsConstants.primary,
            backgroundColor: Colors.white,
            onRefresh: () async {
              await homeScreenProvider.refreshProducts(context: context);
            },
            child: SingleChildScrollView(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar and filter button
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFE9EBF2)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x08000000),
                                blurRadius: 14,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller:
                                homeScreenProvider.textEditingController,
                            onSubmitted: (value) {
                              homeScreenProvider.getCourses(context: context);
                            },
                            style: const TextStyle(
                              fontSize: 14,
                              color: ColorsConstants.textColor,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await homeScreenProvider.getCourses(
                                    context: context,
                                  );
                                },
                                icon: const Icon(
                                  Icons.search_rounded,
                                  size: 23,
                                  color: ColorsConstants.primary,
                                ),
                              ),
                              hintText: 'Search your course...',
                              hintStyle: const TextStyle(
                                color: ColorsConstants.secondaryText,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFE9EBF2)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08000000),
                              blurRadius: 14,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            _openBottomSheet(context);
                          },
                          icon: const Icon(
                            Icons.tune_rounded,
                            size: 22,
                            color: ColorsConstants.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Country dropdown
                  buildCountryDropDown(),

                  const SizedBox(height: 24),

                  // Available courses heading and count
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Available Courses',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          color: ColorsConstants.textColor,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsConstants.containerColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${homeScreenProvider.courseResponseModel?.count ?? 0} Courses',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorsConstants.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Loading, error, empty state, or course list
                  if (homeScreenProvider.isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                        child: SpinKitFadingCircle(color: Colors.blue.shade900),
                      ),
                    )
                  else if (homeScreenProvider.errorMessage != null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'ISSUE IN HOME SCREEN '
                          '${homeScreenProvider.errorMessage!}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  else if (homeScreenProvider.courseModel.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Text(
                          'No courses found',
                          style: TextStyle(
                            color: ColorsConstants.secondaryText,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          homeScreenProvider.courseModel.length +
                          (homeScreenProvider.isLoadingMore ? 1 : 0),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        if (index == homeScreenProvider.courseModel.length) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: SpinKitThreeBounce(
                                color: Colors.blue.shade900,
                                size: 28,
                              ),
                            ),
                          );
                        }

                        final course = homeScreenProvider.courseModel[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ScreenCourseDetails(slug: course.slug),
                                ),
                              );
                            },
                            child: ListWid(
                              courseModel: course,
                              number: index + 1,
                              region: homeScreenProvider.selectedRegionId ?? 3,
                              // Fall back to INR defaults until regions load
                              currency: selectedRegion?.currency ?? 'INR',
                              exchangeRate: selectedRegion?.exchangeRate ?? 1.0,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
