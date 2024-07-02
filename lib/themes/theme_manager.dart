import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager extends GetxController {
  final controller;

  ThemeManager(this.controller) {
    lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF184C92),
      fontFamily: controller.selectedIndex == 1 ? 'ElMessiri' : 'Signika',
      cardColor: const Color(0xFFf8f8f8),
      scaffoldBackgroundColor: const Color.fromARGB(255, 237, 235, 235),
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color(0xFFfcfcfe),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: const Color(0xFF184C92),
        secondary: const Color(0xFFD74728),
        background: Colors.white,
        onBackground: Colors.black87,
        onSecondary: const Color(0xFFe8eff5),
        onSurface: const Color(0xFF212a2f),
      ),
      dividerColor: Colors.black12,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          minimumSize: const Size(327, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          textStyle: GoogleFonts.poppins(),
        ),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(fontSize: 20.sp),
        titleMedium: GoogleFonts.poppins(fontSize: 16.sp),
        titleSmall: GoogleFonts.poppins(fontSize: 14.sp),
        bodyMedium: GoogleFonts.poppins(fontSize: 14.sp),
        headlineSmall: GoogleFonts.poppins(fontSize: 24.sp),
        headlineMedium: GoogleFonts.poppins(fontSize: 34.sp),
      ),
    );

    darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFea3b15),
      fontFamily: controller.selectedIndex == 1 ? 'ElMessiri' : 'Signika',
      scaffoldBackgroundColor: const Color(0xFF181c1f),
      cardColor: const Color(0xFFFFE6D7),
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color(0xFF181c1f),
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: const Color(0xFFea3b15),
        secondary: const Color(0xFFFF9800),
        background: const Color(0xFFFFAA76),
        onBackground: Colors.white,
        onSecondary: const Color(0xFF212a2f),
        onSurface: const Color(0xFF212a2f),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          minimumSize: const Size(327, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          textStyle: TextStyle(
            fontSize: 17,
            fontFamily: controller.selectedIndex == 1 ? 'ElMessiri' : 'Signika',
          ),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  ThemeData? lightTheme;
  // ThemeData? lightTheme2;

  ThemeData? darkTheme;

  final _getStorage = GetStorage();
  final _darkThemeKey = 'isDarkTheme';

  saveThemeData(bool isDark) {
    _getStorage.write(_darkThemeKey, isDark);
  }

  bool isSaveDarkMood() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThmeMode() {
    return isSaveDarkMood() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeThemeStyle(ThemeData theme) {
    Get.changeTheme(theme);
    update();
  }

  void chnageTheme() {
    Get.changeThemeMode(isSaveDarkMood() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSaveDarkMood());
    update();
  }
}
