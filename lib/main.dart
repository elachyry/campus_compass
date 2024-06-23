import 'package:flutter/material.dart';
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

  runApp(MainApp(
    languages: languages,
  ));
}

class MainApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  const MainApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    // final levelSelectionController = Get.put(LevelSelectionController());
    return GetBuilder<LocalizationController>(builder: (controller) {
      return GetMaterialApp(
        title: 'Campus Compass',
        theme: ThemeManager(controller).lightTheme,
        darkTheme: ThemeManager(controller).darkTheme,
        themeMode: ThemeManager(controller).getThmeMode(),
        defaultTransition: Transition.fadeIn,
        home: Container(),
        locale: controller.locale,
        initialRoute: Routes.bottomNav,
        getPages: Routes.routes,
        fallbackLocale: Locale(Language.languages[0].languageCode,
            Language.languages[0].countryCode),
        translations: Messages(languages: languages),
      );
    });
  }
}
