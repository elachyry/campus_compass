import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({
    required this.sharedPreferences,
  }) {
    loadCurrentLanguages();
  }

  Locale _locale = Locale(
    Language.languages[0].languageCode,
    Language.languages[0].countryCode,
  );

  int _selectedIndex = 0;

  List<Language> _languages = [];

  int get selectedIndex {
    return _selectedIndex;
  }

  Locale get locale {
    return _locale;
  }

  List<Language> get languages {
    return _languages;
  }

  void loadCurrentLanguages() async {
    _locale = Locale(
      sharedPreferences.getString(Language.languageCodeKey) ??
          Language.languages[0].languageCode,
      sharedPreferences.getString(Language.countryCodeKey) ??
          Language.languages[0].countryCode,
    );

    for (int i = 0; i < Language.languages.length; i++) {
      if (Language.languages[i].languageCode == _locale.languageCode) {
        _selectedIndex = i;
        break;
      }
    }
    _languages = [];
    _languages.addAll(Language.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(Language.languageCodeKey, locale.languageCode);
    sharedPreferences.setString(Language.countryCodeKey, locale.countryCode!);
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
