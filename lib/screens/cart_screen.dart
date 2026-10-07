import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your Courses',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: ColorsConstants.textColor,
            fontSize: 23,
            letterSpacing: -0.5,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: ColorsConstants.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
          child: Column(
            children: [
              Text(
                'Added Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorsConstants.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
