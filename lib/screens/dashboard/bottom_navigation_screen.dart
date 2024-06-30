import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../screens.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late PageController pageController;
  int _bottomNavIndex = 0;

  List<TabItem> items = const [
    TabItem(
      icon: Bootstrap.house_door_fill,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.favorite_rounded,
      title: 'Favorites',
    ),
    TabItem(
      icon: Bootstrap.compass_fill,
      title: 'Map',
    ),
    TabItem(
      icon: Icons.person,
      title: 'profile',
    ),
  ];
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          DashboardScreen(pageController: pageController),
          const FavoritesScreen(),
          const MapScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomBarDefault(
        items: items,
        backgroundColor: Colors.white,
        blur: 0,
        boxShadow: null,
        color: Colors.black54,
        colorSelected: Theme.of(context).colorScheme.primary,
        indexSelected: _bottomNavIndex,
        borderRadius: BorderRadius.circular(20.r),
        onTap: (int index) => setState(() {
          _bottomNavIndex = index;
          pageController.jumpToPage(index);
        }),
      ),
    );
  }
}
