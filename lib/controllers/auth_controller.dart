import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../exceptions/signin_with_email_and_password_exception.dart';
import '../exceptions/signup_with_email_and_password_exception.dart';
import '../utils/utils.dart';
import '../../models/user.dart' as user;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(Routes.language);
    } else {
      Get.offAllNamed(Routes.bottomNav);
    }
  }

  void register(String name, String email, String password) async {
    try {
      isLoading.value = true;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            createUser(user.User(
              id: value.user!.uid,
              email: email,
              name:name,
            ));
        isLoading.value = false;
      });
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      final exception = SignInWithEmailAndPasswordException.code(error.code);
      showSnackBarError('signup_failed'.tr, exception.toString());
      throw exception;
    } catch (e) {
      User user = auth.currentUser as User;
      await user.delete();
      isLoading.value = false;
      final exception = SignUpWithEmailAndPasswordException();
      showSnackBarError('signup_failed'.tr, exception.toString());
      throw exception;
    }
  }

  void login(String email, String password) async {
    try {
      isLoading.value = true;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => isLoading.value = false);
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      final exception = SignInWithEmailAndPasswordException.code(error.code);
      showSnackBarError('login_failed'.tr, exception.toString());
      throw exception;
    } catch (e) {
      isLoading.value = false;
      final exception = SignInWithEmailAndPasswordException();
      showSnackBarError('login_failed'.tr, exception.toString());
      throw exception;
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  Future<void> createUser(user.User user) async {
    await firestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .set(
          user.toJson(),
        )
        .whenComplete(
            () => showSnackBarSuccess('your_account_has_been_created'.tr))
        .catchError((error, stackTrace) {
      showSnackBarError(
        'error'.tr,
        'an_error_occurred_please_try_again_later'.tr,
      );
    });
  }

  void showSnackBarError(String titleText, String messageText) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 2000));
  }

  SnackbarController showSnackBarSuccess(String message) {
    return Get.snackbar(
      'success'.tr,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade500,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1500),
    );
  }
}
