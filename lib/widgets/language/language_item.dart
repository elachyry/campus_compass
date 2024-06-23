import 'package:flutter/material.dart';

import '../../controllers/controllers.dart';
import '../../models/models.dart';

class LanguageItem extends StatelessWidget {
  final Language language;
  final LocalizationController localizationController;
  final int index;

  const LanguageItem({
    super.key,
    required this.language,
    required this.localizationController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(
          Locale(Language.languages[index].languageCode,
              Language.languages[index].countryCode),
        );
        localizationController.setSelectedIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: localizationController.selectedIndex == index
              ? Theme.of(context).colorScheme.background
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200] as Color,
                blurRadius: 0.5,
                spreadRadius: 1),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(9),
                child: Image.asset(
                  'assets/images/flags/${language.imageUrl}',
                  width: 60,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                language.languageName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: language.languageName == 'العربية'
                      ? 'ElMessiri'
                      : 'Signika',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
