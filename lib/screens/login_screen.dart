import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/screens/homescreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();

    return Scaffold(
      backgroundColor: ColorsConstants.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    size: 40,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Welcome back',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Sign in to pickup right where you left off',
                style: TextStyle(
                  color: ColorsConstants.secondaryText,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: authProvider.emailController,
                decoration: decoration.copyWith(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email_outlined, size: 20),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: authProvider.passwordController,
                obscureText: authProvider.isObscure,
                decoration: decoration.copyWith(
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<AuthenticationProvider>().showPassword();
                    },
                    icon: Icon(
                      size: 20,
                      authProvider.isObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.password, size: 20),
                ),
              ),
              SizedBox(height: 20),
              if (authProvider.errorMessage != null)
                (Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    authProvider.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                )),

              FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(360, 45),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                onPressed: authProvider.isLoading
                    ? null
                    : () async {
                        final email = authProvider.emailController.text.trim();
                        final password = authProvider.passwordController.text
                            .trim();

                        log('SCREEN EMAIL: $email');
                        log('SCREEN PASSWORD: $password');

                        if (email.isEmpty) {
                          context.read<AuthenticationProvider>().setError(
                            'Please enter your email',
                          );
                          return;
                        }
                        if (password.isEmpty) {
                          context.read<AuthenticationProvider>().setError(
                            'Please enter your password',
                          );
                          return;
                        }

                        final success = await context
                            .read<AuthenticationProvider>()
                            .login();
                        if (!context.mounted) return;
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Homescreen(),
                            ),
                          );
                        }
                      },
                child: authProvider.isLoading
                    ? const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Text('Sign In', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  static final InputDecoration decoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintStyle: TextStyle(color: ColorsConstants.secondaryText, fontSize: 13),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.black12),
    ),
  );
}
