import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../screens.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PageController pageController = PageController(initialPage: 0);
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          DashboardScreen(),
          FavoritesScreen(),
          MapScreen(),
          SettingsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: DotNavigationBar(
        marginR: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        paddingR: const EdgeInsets.symmetric(vertical: 10),
        
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Colors.white70,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _bottomNavIndex,
          onTap: (index) {
            setState(() {
             _bottomNavIndex = index;
            pageController.jumpToPage(index);
            });
          },
          // dotIndicatorColor: Colors.black,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
            ),

            /// Likes
            DotNavigationBarItem(
              icon:const Icon(Icons.favorite_border),
            ),

            /// Search
            DotNavigationBarItem(
              icon: const Icon(Icons.map),
            ),
             DotNavigationBarItem(
              icon: const Icon(Icons.settings),
            ),

            /// Profile
            DotNavigationBarItem(
              icon:const Icon(Icons.person),
            ),
            
          ],
        ),
    );
      
      
      
    
  }
}
