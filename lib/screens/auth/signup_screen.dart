import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../screens.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final AuthController authController = Get.find();
  final screenWidth = Get.width;
  List<String>? selectedInterests;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map<String, dynamic>;
      selectedInterests = args['interests'] ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppBar appBar = AppBar(
    //   backgroundColor: AppColors.kWhite,
    //   elevation: 0,
    //   leading: BackButton(
    //     color: Theme.of(context).colorScheme.primary,
    //   ),
    // );
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      // appBar: appBar,
      body: SafeArea(
        child: Obx(
          () {
            if (AuthController.instance.isLoading.value) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).primaryColor,
                  size: screenWidth >= 600 ? 90 : 60,
                ),
              );
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: const AssetImage(
                                "assets/images/logo/logo.png",
                              ),
                              radius: 50.r,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Let's create your account!",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SizedBox(height: 20.h),
                            AuthField(
                              title: "Full Name*",
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required';
                                } else if (!RegExp(r'^[a-zA-Z ]+ $')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20.h),
                            AuthField(
                              title: "Email*",
                              controller: _emailController,
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                } else if (!value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            AuthField(
                              title: "Password*",
                              controller: _passwordController,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (value.length < 8) {
                                  return 'Password should be at least 8 characters long';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            AuthField(
                              title: "Confirm Password*",
                              controller: _rePasswordController,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                               
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            PrimaryButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // print("interestsssssssssssss444: $selectedInterests");
                                  int i = 0;
                                  List<Interest> interests = selectedInterests!
                                      .map((e) => Interest(
                                            id: (i++).toString(),
                                            name: e,
                                          ))
                                      .toList();
                                  authController.register(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                    interests,
                                  );
                                }
                              },
                              text: 'Sign up',
                            ),
                            SizedBox(height: 20.h),
                            OutlinedButton(
                              onPressed: () {
                                Get.toNamed(Routes.signin);
                              },
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(double.maxFinite, 53),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              child: Text(
                                "Sign in",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      const AgreeTermsTextCard(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class TextWithDivider extends StatelessWidget {
  const TextWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            color: AppColors.kGrey60,
          ),
        ),
        SizedBox(width: 20),
        Text(
          'Or Sign In with',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.kGrey60,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Divider(color: AppColors.kGrey60),
        ),
      ],
    );
  }
}
