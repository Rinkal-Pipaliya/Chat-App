import 'package:chat_app/modals/user_modal.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/utils/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import '../../../services/firestore_services.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = true.obs;

  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login(email, password) async {
    String msg = await AuthServices.authServices.login(email, password);
    if (msg == "Success") {
      toastification.show(
        title: const Text("Success"),
        description: const Text("Login successfully"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
      Get.offNamed(AppRoutes.homePage);
      // Get.offNamed(GetPages.otpVerification);
    } else {
      toastification.show(
        autoCloseDuration: const Duration(seconds: 2),
        title: const Text("Error"),
        description: Text(msg),
        type: ToastificationType.error,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    String msg = await AuthServices.authServices.signUpWithGoogle();
    if (msg == "Success") {
      Get.offNamed(AppRoutes.homePage);
      // Get.offNamed(GetPages.otpVerification);
      var user = AuthServices.authServices.currentUser;

      if (user != null) {
        FirestoreServices.firestoreServices.addUser(
          model: UserModel(
              uid: user.uid,
              name: user.displayName ?? "",
              email: user.email ?? "",
              password: "",
              selectedImage: "",
              image: user.photoURL ?? "",
              token: await FirebaseMessaging.instance.getToken() ?? "",
              cNumber: user.phoneNumber ?? ""),
        );
        AuthServices.authServices.sendVerificationEmail();
      }
    }
  }

  void loginWithAnonymous() async {
    User? user = await AuthServices.authServices.anonymousLogin();
    if (user != null) {
      toastification.show(
        title: const Text("Success"),
        description: const Text("Login successfully"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
      // Get.offNamed(GetPages.otpVerification);
    }
  }

  Future<void> currentUser() async {
    User? user = AuthServices.authServices.currentUser!;
    if (user != null) {
      toastification.show(
        title: const Text("Success"),
        description: const Text("Login successfully"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
      Get.offNamed(AppRoutes.homePage);
    } else {}
  }

  void signOut() {
    AuthServices.authServices.signOut();
    Get.offNamed(AppRoutes.loginPage);
  }
}
