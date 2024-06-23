import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../themes/themes.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class LanguageSelectionScreen extends StatefulWidget {
  var firstTime = true;
  LanguageSelectionScreen({
    super.key,
    required this.firstTime,
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
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(
                  child: GetBuilder<ThemeManager>(
                      init: ThemeManager(controller),
                      builder: (ctrl) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Image.asset(
                                ctrl.getThmeMode() == ThemeMode.dark
                                    ? ImageConstants.coverDark
                                    : ImageConstants.cover,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Positioned(
                              left: 3,
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

                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'select_a_language'.tr,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontFamily: controller.selectedIndex == 1
                              ? 'ElMessiri'
                              : 'Signika',
                        ),
                  ),
                ),
                // const SizedBox(
                //   height: 7,
                // ),
                GridView.builder(
                  itemCount: controller.languages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        MediaQuery.of(context).size.width >= 600 ? 1.2 : 1.2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true, // This makes the GridView non-scrollable
                  itemBuilder: (context, index) => LanguageItem(
                    language: controller.languages[index],
                    localizationController: controller,
                    index: index,
                  ),
                ),
                !widget.firstTime
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.onboarding);
                          },
                          child: Text('continue'.tr),
                        ),
                      ),
                const SizedBox(
                  height: 5,
                ),
                !widget.firstTime
                    ? Container()
                    : Text(
                        'you_can_cahnge_your_language'.tr,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(
                  height: 5,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
