import 'package:flutter/material.dart';
import 'package:learning_course2/screens/screen_login.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void navigateToLogin() {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const ScreenLogin()),
      (route) => false,
    );
  }
}
