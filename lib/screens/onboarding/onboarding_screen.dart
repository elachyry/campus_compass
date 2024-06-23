import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController(initialPage: 0);
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
                          margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                          width: Get.width,
                          height: Get.height / 2.5,
                          child: CustomAnimatedWidget(
                            index: index,
                            delay: 100,
                            child: Image.asset(listOfItems[index].img),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomAnimatedWidget(
                            index: index,
                            delay: 300,
                            child: Text(
                              listOfItems[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: CustomAnimatedWidget(
                            index: index,
                            delay: 500,
                            child: Text(listOfItems[index].subTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                )
                                // style: GoogleFonts.poppins(
                                //     fontSize: 17, fontWeight: FontWeight.w300),
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
                        radius: 10.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
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
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                FadeInDown(
                                  delay: const Duration(milliseconds: 200),
                                  child: PrimaryButton(
                                    onTap: () {
                                      Get.offNamed(Routes.interestsSelection);
                                    },
                                    text: 'Get Started',
                                  ),
                                ),
                                const SizedBox(height: 15),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 200),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.offNamed(Routes.signin);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        fixedSize:
                                            const Size(double.maxFinite, 53),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: const Text(
                                      'I Already Have An Account',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    const SizedBox(height: 20),
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
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.maxFinite, 53),
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          // style: GoogleFonts.poppins(
          //     color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ));
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