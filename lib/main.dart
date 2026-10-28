import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/providers/bottom_nav_bar_provider.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:learning_course2/providers/course_details_provider.dart';

import 'package:learning_course2/core/navigation/navigation_service.dart';
import 'package:learning_course2/providers/favourite_screen_provider.dart';
import 'package:learning_course2/providers/homescreen_provider.dart';
import 'package:learning_course2/providers/razorpay_provider.dart';
import 'package:learning_course2/screens/screen_splash.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseDetailsProvider()),
        ChangeNotifierProvider(create: (_) => HomescreenProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteScreenProvider()),
        ChangeNotifierProvider(create: (_) => RazorpayProvider()),
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
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      home: ScreenSplash(),
    );
  }
}
