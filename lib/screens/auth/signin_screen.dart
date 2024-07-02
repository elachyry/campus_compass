import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/controllers.dart';
import '../../utils/utils.dart';
import '../screens.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController authController = Get.find();
  final screenWidth = Get.width;
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            if (AuthController.instance.isLoading.value) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).primaryColor,
                  size: 60.r,
                ),
              );
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 20,
                        top: Get.height * 0.1,
                      ),
                child: Column(
                  children: [
                    Form(
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
                                FittedBox(
                                  child: Text(
                                    "Let's Sign you in",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 25.h),
                                AuthField(
                                  title: "Email",
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
                                  title: "Password",
                                  controller: _passwordController,
                                  isPassword: true,
                                  isAutoValidate: false,
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
                                SizedBox(height: 5.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Forgot password?'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                PrimaryButton(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.login(
                                          _emailController.text,
                                          _passwordController.text);
                                    }
                                  },
                                  text: 'Sign In',
                                ),
                                SizedBox(height: 20.h),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.interestsSelection);
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
                                    "Sign up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                     Align(
                     alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                        child:const Text("UniCennect"),
                      ),
                    ),
                  ],
                ),
                
              );
            }
          },
        ),
      ),
    );
  }
}

class AgreeTermsTextCard extends StatelessWidget {
  const AgreeTermsTextCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: RichText(
        text: TextSpan(
          text: 'By signing up you agree to our ',
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.kGrey70),
          children: [
            TextSpan(
                text: 'Terms',
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.kGrey100)),
            TextSpan(
                text: ' and ',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.kGrey70)),
            TextSpan(
                text: 'Conditions of Use',
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.kGrey100)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.red,
          fontSize: fontSize ?? 14.sp,
        ),
      ),
    );
  }
}

class RememberMeCard extends StatefulWidget {
  final Function(bool isChecked) onChanged;
  const RememberMeCard({required this.onChanged, super.key});

  @override
  State<RememberMeCard> createState() => _RememberMeCardState();
}

class _RememberMeCardState extends State<RememberMeCard> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
            widget.onChanged(_isChecked);
          },
          child: Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isChecked
                    ? const Color(0xFFD1A661)
                    : const Color(0xFFE3E9ED),
                width: 2.w,
              ),
            ),
            child: _isChecked
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Color(0xFFD1A661),
                  )
                : null,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          'Remember me',
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF78828A)),
        ),
      ],
    );
  }
}

class AuthField extends StatefulWidget {
  final String title;
  final Color? titleColor;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool isAutoValidate;
  const AuthField({
    required this.title,
    required this.controller,
    this.validator,
    this.titleColor,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
    this.isPassword = false,
    this.isAutoValidate = true,
    super.key,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      autovalidateMode: widget.isAutoValidate ? AutovalidateMode.onUserInteraction : null,
      obscureText: widget.isPassword ? isObscure : false,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        labelText: widget.title,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF171725)),
              )
            : null,
      ),
    );
  }
}

class AppColors {
  static const Color kPrimary = Color(0xFFD1A661);
  static const Color kWhite = Color(0xFFFEFEFE);
  static const Color kGrey60 = Color(0xFF9CA4AB);
  static const Color kGrey70 = Color(0xFF78828A);
  static const Color kGrey100 = Color(0xFF171725);
}
