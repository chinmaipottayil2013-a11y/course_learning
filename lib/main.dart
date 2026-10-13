import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/providers/bottom_nav_bar_provider.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:learning_course2/providers/course_details_provider.dart';

import 'package:learning_course2/providers/homescreen_provider.dart';
import 'package:learning_course2/screens/screen_splash.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseDetailsProvider()),
        ChangeNotifierProvider(create: (_) => HomescreenProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.outfitTextTheme()),
      home: ScreenSplash(),
    );
  }
}
