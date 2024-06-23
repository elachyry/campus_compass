import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: AppColors.kWhite,
      elevation: 0,
      leading: BackButton(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: appBar,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstants.cover),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(height: 30),
              const Text('Create Account',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 5),
              const Text(
                  'Please enter your email & password to create an account',
                  style: TextStyle(fontSize: 14, color: AppColors.kGrey60)),
              const SizedBox(height: 30),
              // FullName.
              AuthField(
                title: 'Full Name',
                hintText: 'Enter your name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  } else if (!RegExp(r'^[a-zA-Z ]+ $').hasMatch(value)) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
              // Email Field.
              AuthField(
                title: 'E-mail',
                hintText: 'Enter your email address',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!value.contains('@') || !value.contains('.')) {
                    return 'Invalid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
              // Password Field.
              AuthField(
                title: 'Password',
                hintText: 'Enter your password',
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 8) {
                    return 'Password should be at least 8 characters long';
                  }
                  return null;
                },
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  PrimaryButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    text: 'Create An Account',
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kGrey70),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAllNamed(Routes.signin);
                            },
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.kPrimary),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const AgreeTermsTextCard(),
                ],
              ),
            ],
          ),
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
