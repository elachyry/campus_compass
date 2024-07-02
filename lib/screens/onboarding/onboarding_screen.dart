import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController(initialPage: 0);
  final getStorage = GetStorage();
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: listOfItems.length,
                  onPageChanged: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                    });
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          width: Get.width,
                          height: Get.height / 2.5,
                          child: CustomAnimatedWidget(
                            index: index,
                            delay: 100,
                            child: Image.asset(listOfItems[index].img),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomAnimatedWidget(
                            index: index,
                            delay: 300,
                            child: Text(
                              listOfItems[index].title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: CustomAnimatedWidget(
                              index: index,
                              delay: 500,
                              child: Text(listOfItems[index].subTitle,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: listOfItems.length,
                      effect: ExpandingDotsEffect(
                        spacing: 6.0,
                        radius: 10.0.r,
                        dotWidth: 10.0.w,
                        dotHeight: 10.0.h,
                        expansionFactor: 3.8,
                        dotColor: Colors.grey,
                        activeDotColor: Theme.of(context).primaryColor,
                      ),
                      onDotClicked: (newIndex) {
                        setState(() {
                          currentIndex = newIndex;
                          pageController.animateToPage(newIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        });
                      },
                    ),
                    const Spacer(),
                    currentIndex == 3
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              children: [
                                FadeInDown(
                                  delay: const Duration(milliseconds: 200),
                                  child: PrimaryButton(
                                    onTap: () {
                                      getStorage.write('first use', false);

                                      Get.offNamed(Routes.interestsSelection);
                                    },
                                    text: 'Get Started',
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 200),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      getStorage.write('first use', false);

                                      Get.toNamed(Routes.signin);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      fixedSize:
                                          const Size(double.maxFinite, 53),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    child: Text(
                                      "I Already have an account",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: PrimaryButton(
                              onTap: () {
                                setState(() {
                                  pageController.animateToPage(currentIndex + 1,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      curve: Curves.fastOutSlowIn);
                                });
                              },
                              text: 'Next',
                            ),
                          ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
          if (currentIndex != listOfItems.length - 1)
            Positioned(
              top: 5,
              right: 5,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pageController.animateToPage(listOfItems.length - 1,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn);
                  });
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
        ],
      ),
    ));
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 53),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}

class CustomAnimatedWidget extends StatelessWidget {
  final int index;
  final int delay;
  final Widget child;
  const CustomAnimatedWidget(
      {super.key,
      required this.index,
      required this.delay,
      required this.child});

  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }
}

class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: ImageConstants.onboarding1,
    title: "Your ultimate guide to navigating campus life!",
    subTitle:
        "Discover departments, find events, and connect with your interests—all in one place. Let's get started!",
  ),
  Items(
    img: ImageConstants.onboarding2,
    title: "Find your way around campus effortlessly.",
    subTitle:
        "Our interactive map helps you locate all departments, buildings, and facilities. Never get lost again!",
  ),
  Items(
    img: ImageConstants.onboarding3,
    title: "Discover events that match your interests",
    subTitle:
        "Get suggestions for events, clubs, and activities based on what you love. Stay engaged and make the most of your campus life.",
  ),
  Items(
    img: ImageConstants.onboarding4,
    title: "Tell Us About You",
    subTitle:
        "Pick from a wide range of categories that match your hobbies and academic pursuits. This will help us tailor the app to your preferences.",
  ),
];
