class Language {
  final String imageUrl;
  final String languageName;
  final String languageCode;
  final String countryCode;

  Language({
    required this.imageUrl,
    required this.countryCode,
    required this.languageCode,
    required this.languageName,
  });

  static const countryCodeKey = 'Country_Code';
  static const languageCodeKey = 'Language_code';
  static List<Language> languages = [
    Language(
      imageUrl: 'fr.png',
      countryCode: 'FR',
      languageCode: 'fr',
      languageName: 'Français',
    ),
    Language(
      imageUrl: 'ar.png',
      countryCode: 'AR',
      languageCode: 'ar',
      languageName: 'العربية',
    ),
    Language(
      imageUrl: 'en.png',
      countryCode: 'US',
      languageCode: 'en',
      languageName: 'English',
    ),
    Language(
      imageUrl: 'es.png',
      countryCode: 'ES',
      languageCode: 'es',
      languageName: 'Español',
    ),
  ];
}
