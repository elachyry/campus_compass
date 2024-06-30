import 'package:get/get.dart';

import '../screens/screens.dart';

class Routes {
  static const String home = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String otherInfos = '/other-infos';
  static const String register = '/register';
  static const String profile = '/profile';
  // static const String settings = '/settings';
  static const String map = '/map';
  static const String favorites = '/favorites';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String notFound = '/not-found';
  static const String language = '/language';
  static const String onboarding = '/onboarding';
  static const String interestsSelection = '/interests-selection';
  static const String bottomNav = '/bottom-navigation';


  static List<GetPage> routes = [
    GetPage(
      name: language,
      page: () => const LanguageSelectionScreen(
      ),
    ),
    GetPage(
      name: onboarding,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: interestsSelection,
      page: () => const InterestsSelectionScreen(),
    ),
    GetPage(
      name: signin,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: signup,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: bottomNav,
      page: () => const BottomNavigationScreen(),
    ),
    GetPage(
      name: map,
      page: () => const MapScreen(),
    ),
    GetPage(
      name: favorites,
      page: () => const FavoritesScreen(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
    ),
     GetPage(
      name: otherInfos,
      page: () => const GetOtherInfosScreen(),
    ),
  ];
}
