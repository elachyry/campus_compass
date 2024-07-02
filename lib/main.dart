import 'package:compus_map/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/controllers.dart';
import 'models/models.dart';
import 'themes/themes.dart';
import 'utils/utils.dart';
import './utils/dep.dart' as dep;

void main() async {
  await GetStorage.init();
  final Map<String, Map<String, String>> languages = await dep.init();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp(
    languages: languages,
  ));
}

class MainApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  const MainApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    final InitDataController initDataController = Get.put(InitDataController());
    return FutureBuilder(
      future: initDataController.initAllData(),
      builder: (context, snapshot) {
        return GetBuilder<LocalizationController>(
          builder: (controller) {
            return ScreenUtilInit(
              builder: (_, child) {
                return GetMaterialApp(
                  title: 'UniConnect',
                  theme: ThemeManager(controller).lightTheme,
                  darkTheme: ThemeManager(controller).darkTheme,
                  themeMode: ThemeManager(controller).getThmeMode(),
                  defaultTransition: Transition.fadeIn,
                  home: Container(),
                  locale: controller.locale,
                  // initialRoute: Routes.language,
                  getPages: Routes.routes,
                  fallbackLocale: Locale(Language.languages[0].languageCode,
                      Language.languages[0].countryCode),
                  translations: Messages(languages: languages),
                  initialBinding: BindingsBuilder(
                    () {
                      Get.put(AuthController());
                    },
                  ),
                  debugShowCheckedModeBanner: false,
                );
              },
              designSize: const Size(411, 813),
            );
          },
        );
      }
    );
  }
}
