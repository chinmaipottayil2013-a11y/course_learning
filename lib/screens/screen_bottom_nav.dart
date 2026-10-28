import 'package:flutter/material.dart';

import 'package:learning_course2/providers/bottom_nav_bar_provider.dart';
import 'package:learning_course2/screens/screen_cart.dart';
import 'package:learning_course2/screens/screen_favourite.dart';
import 'package:learning_course2/screens/screen_home.dart';
import 'package:provider/provider.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [const ScreenHome(), const ScreenCart(), ScreenFavourite()];
    final bottomNavProvider = context.watch<BottomNavBarProvider>();
    return Scaffold(
      body: screens[bottomNavProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: bottomNavProvider.currentIndex,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (value) =>
            context.read<BottomNavBarProvider>().changeIndex(value),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
