import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';

import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/screens/screen_enrolled_courses.dart';
import 'package:learning_course2/screens/screen_login.dart';
import 'package:provider/provider.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final List<Map<String, dynamic>> learningTiles = [
    {
      'title': 'Learning Streaks',
      'subtitle': 'Track daily progress, XP multipliers & shields',
      'icon': Icons.local_fire_department,
      'color': Colors.red,
    },
    {
      'title': 'Enrolled Courses',
      'subtitle': 'View and resume your active courses',
      'icon': Icons.menu_book,
      'color': Colors.blue,
    },
    {
      'title': 'Favourite Courses',
      'subtitle': 'Courses saved to your wishlist',
      'icon': Icons.favorite, // icons were swapped with Certificates
      'color': Colors.pink,
    },
    {
      'title': 'My Certificates',
      'subtitle': 'Download and share your earned credentials',
      'icon': Icons.workspace_premium,
      'color': Colors.orange,
    },
    {
      'title': 'Submitted Assignments',
      'subtitle': 'Track grades and instructor feedbacks',
      'icon': Icons.assignment_turned_in,
      'color': Colors.teal,
    },
  ];

  final List<Map<String, dynamic>> invoiceTile = [
    {
      'title': 'Purchase History',
      'subtitle': 'Orders,receipts and course invoices',
      'icon': Icons.payment,
      'color': Colors.brown,
    },
    {
      'title': 'Ads report',
      'subtitle': 'Promotional performance & statistics',
      'icon': Icons.restart_alt_rounded,
      'color': Colors.blue,
    },
  ];

  void navigateToScreen(String title) {
    switch (title) {
      case 'Enrolled Courses':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenEnrolledCourses(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.background,
      appBar: AppBar(
        backgroundColor: ColorsConstants.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ColorsConstants.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.black.withValues(alpha: 0.06),
                        child: const Icon(Icons.person, color: Colors.black54),
                      ),
                      title: const Text(
                        'Chinmai Pottayil',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'chinmaipottayil2013@gmail.com',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ),
                    ),
                    const Divider(thickness: 0.6, endIndent: 6, indent: 6),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('View & Edit Profile'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  'LEARNING & PROGRESS',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: learningTiles.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 0.6,
                    endIndent: 20,
                    indent: 20,
                  ),
                  itemBuilder: (context, index) {
                    final tile = learningTiles[index];
                    return buildTile(
                      tile['title'] as String,
                      tile['subtitle'] as String,
                      tile['icon'] as IconData,
                      tile['color'] as Color,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 4),

                child: Text(
                  'ACTIVITY & INVOICES',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: invoiceTile.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 0.5,
                    endIndent: 20,
                    indent: 20,
                  ),
                  itemBuilder: (context, index) {
                    final secondTile = invoiceTile[index];
                    return buildTile(
                      secondTile['title'] as String,
                      secondTile['subtitle'] as String,
                      secondTile['icon'] as IconData,
                      secondTile['color'] as Color,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.transparent,
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await context.read<AuthenticationProvider>().logout();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenLogin(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTile(String title, String subtitle, IconData icon, Color color) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => navigateToScreen(title),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            minVerticalPadding: 4,
            minTileHeight: 65,
            tileColor: Colors.transparent,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: color.withValues(alpha: 0.12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }
}
