import 'package:flutter/material.dart';
import 'package:learning_course2/screens/bottom_nav_bar_screen.dart';

import 'package:learning_course2/screens/login_screen.dart';
import 'package:learning_course2/services/authentication_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationService _authService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn = await _authService.loggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_sharp, size: 50),
            SizedBox(height: 10),
            Text('Course Learning', style: TextStyle(fontSize: 25)),
            SizedBox(height: 50),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(color: Colors.black, minHeight: 2),
            ),
          ],
        ),
      ),
    );
  }
}
