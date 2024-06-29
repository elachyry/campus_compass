import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      color: localizationController.selectedIndex == index
          ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
          : Theme.of(context).colorScheme.background,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () {
          localizationController.setLanguage(
            Locale(Language.languages[index].languageCode,
                Language.languages[index].countryCode),
          );
          localizationController.setSelectedIndex(index);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                  child: Image.asset(
                    'assets/images/flags/${language.imageUrl}',
                    width: 60.w,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  language.languageName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: localizationController.selectedIndex == index
                            ? Colors.white
                            : Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
