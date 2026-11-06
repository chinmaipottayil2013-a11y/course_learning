import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_course2/firebase_options.dart';
import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/providers/bottom_nav_bar_provider.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:learning_course2/providers/course_details_provider.dart';

import 'package:learning_course2/core/navigation/navigation_service.dart';
import 'package:learning_course2/providers/enrolled_course_provider.dart';
import 'package:learning_course2/providers/favourite_screen_provider.dart';
import 'package:learning_course2/providers/homescreen_provider.dart';
import 'package:learning_course2/providers/notification_provider.dart';
import 'package:learning_course2/providers/profile_screen_provider.dart';
import 'package:learning_course2/providers/razorpay_provider.dart';
import 'package:learning_course2/screens/screen_splash.dart';
import 'package:learning_course2/services/push_notifications_service.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(fireBaseBackgroundHandler);
  await dotenv.load(fileName: '.env');

  await PushNotificationsService.instance.init();

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
        ChangeNotifierProvider(create: (_) => EnrolledCourseProvider()),
        ChangeNotifierProvider(create: (_) => ProfileScreenProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
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
