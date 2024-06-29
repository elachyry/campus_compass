import 'package:compus_map/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../themes/themes.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({
    super.key,
  });

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  void initState() {
    // final getStorage = GetStorage();
    // bool isFirstTime = getStorage.read('first use') ?? true;
    // if (isFirstTime) {
    //   if (levelSelectionController.isProfileEmpty.value) {
    //     Get.offAllNamed(AppRoutes.languageSelectionScreen);
    //   } else {
    //     Get.offAllNamed(AppRoutes.tabScreen);
    //   }
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("screen height: ${MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom}");
    // print("screen width: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
          builder: (controller) {
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: GetBuilder<ThemeManager>(
                        init: ThemeManager(controller),
                        builder: (ctrl) {
                          return Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CircleAvatar(
                                backgroundImage: const AssetImage(
                                  "assets/images/logo/fav.png",
                                ),
                                radius: 50.r,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                          ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(
                                    ctrl.getThmeMode() == ThemeMode.dark
                                        ? Icons.sunny
                                        : Icons.dark_mode_rounded,
                                    size:
                                        MediaQuery.of(context).size.width * 0.075,
                                  ),
                                  onPressed: () {
                                    ThemeManager(controller).chnageTheme();
                                  },
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                   SizedBox(
                    height: 7.h
                  ),
                  Text(
                    'select_a_language'.tr,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  GridView.builder(
                    itemCount: controller.languages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          MediaQuery.of(context).size.width >= 600 ? 1.2 : 1.2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LanguageItem(
                      language: controller.languages[index],
                      localizationController: controller,
                      index: index,
                    ),
                  ),
                  PrimaryButton(
                        text: "Continue",
                        onTap: () {
                          Get.toNamed(Routes.onboarding);
                        },
                      ),
                   SizedBox(
                    height: 5.h
                  ),
                  Text(
                    'you_can_cahnge_your_language'.tr,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(
                    height: 5.h
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
