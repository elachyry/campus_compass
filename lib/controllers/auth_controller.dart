import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compus_map/controllers/sqflite_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../exceptions/signin_with_email_and_password_exception.dart';
import '../exceptions/signup_with_email_and_password_exception.dart';
import '../models/interest.dart';
import '../utils/utils.dart';
import '../../models/user.dart' as user;
import 'controllers.dart';

class AuthController extends GetxController {
  final getStorage = GetStorage();
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final SqfliteController sqfliteController = Get.put(SqfliteController());

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<user.User?> currentUser = Rx<user.User?>(null);
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) async {
    if (user == null) {
       bool isFirstTime = getStorage.read('first use') ?? true;
      if (isFirstTime)
      {
         Get.offAllNamed(Routes.language);
      }
      else
      {
         Get.offAllNamed(Routes.signin);
      }
    } else {
      await _retrieveUserData(user.uid).then((value) => FlutterNativeSplash.remove());
      if (currentUser.value == null) {
        Get.offAllNamed(Routes.otherInfos);
      } else if (!currentUser.value!.isCompleted) {
        Get.offAllNamed(Routes.otherInfos);
      } else {
        Get.offAllNamed(Routes.bottomNav);
      }
    }
  }

  Future<void> _retrieveUserData(String uid) async {
    currentUser.value = await sqfliteController.getUserData(uid);
    // print("currentUser data: ${currentUser.value!.toJson()}");
    // if (currentUser.value == null) {
    // Fetch from Firestore if not found in local database
    currentUser.value ??= await getUserData(uid);
    

    // if (currentUser.value != null) {
    //   await sqfliteController.insertUserData(currentUser.value!);
    // }
    // }
  }

  Future<void> fetchUserDataAtStartup() async {
    User? user = auth.currentUser;
    if (user != null) {
      await _retrieveUserData(user.uid);
    }
  }

  void register(String name, String email, String password,
      List<Interest> interests) async {
    try {
      isLoading.value = true;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        user.User _user = user.User(
          id: value.user!.uid,
          email: email,
          name: name,
          interests: interests,
        );
        currentUser.value = _user;
        await createUser(_user);
        await sqfliteController.insertUserData(_user);
        isLoading.value = false;
      });
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      final exception = SignInWithEmailAndPasswordException.code(error.code);
      showSnackBarError('signup_failed'.tr, exception.toString());
      throw exception;
    } catch (e) {
      // print("error: $e");
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
      await auth.signInWithEmailAndPassword(email: email, password: password);
      User? fuser = auth.currentUser;
      if (fuser != null) {
        currentUser.value = await getUserData(fuser.uid);
        user.User? usercheck = await sqfliteController.getUserData(fuser.uid);
        if (usercheck == null && currentUser.value != null) {
          await sqfliteController.insertUserData(currentUser.value!);
        }
      }
      isLoading.value = false;
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
    currentUser.value = null;
    await auth.signOut();
  }

  Future<String?> _uploadImage(String image) async {
    try {
      Reference ref =
          _storage.ref().child('user_images/${currentUser.value!.id}');
      UploadTask uploadTask = ref.putFile(File(image));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // print('Error uploading image: $e');
      return null;
    }
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

  Future<void> updateUserData(user.User updatedUser) async {
    try {
      isLoading.value = true;

      if (updatedUser.imageUrl.isNotEmpty) {
        String? downloadUrl = await _uploadImage(updatedUser.imageUrl);
        if (downloadUrl != null) {
          updatedUser.imageUrl = downloadUrl;
        }
      }
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(updatedUser.toJson())
          .then((_) {
        currentUser.value = updatedUser;
        sqfliteController.updatetUserData(updatedUser);

        showSnackBarSuccess('Your profile has been updated successfully');
        isLoading.value = false;
      }).catchError((error) {
        showSnackBarError(
            'Error', 'An error occurred while updating your profile');
        isLoading.value = false;
      });
    } catch (e) {
      showSnackBarError(
          'Error', 'An error occurred while updating your profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<user.User?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return user.User.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      showSnackBarError('error'.tr, e.toString());
      rethrow;
    }
    return null;
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
