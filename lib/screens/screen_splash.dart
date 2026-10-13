import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/screens/screen_login.dart';
import 'package:learning_course2/screens/screen_bottom_nav.dart';

import 'package:learning_course2/services/authentication_service.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
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
        MaterialPageRoute(builder: (_) => const ScreenLogin()),
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
              child: SpinKitThreeBounce(color: Colors.black, size: 25),
            ),
          ],
        ),
      ),
    );
  }
}
