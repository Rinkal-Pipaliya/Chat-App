// import 'dart:io';
// import 'package:chat_app/modals/user_modal.dart';
// import 'package:chat_app/services/auth_services.dart';
// import 'package:chat_app/services/firestore_services.dart';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
//
// class RegisterController extends GetxController {
//   RxBool isPassword = true.obs;
//   RxBool isCPassword = true.obs;
//   File? image;
//
//   bool isObscure = true;
//
//   void changeVisibilityPassword() {
//     isPassword.value = !isPassword.value;
//   }
//
//   void changeObscure() {
//     isObscure = !isObscure;
//     update();
//   }
//
//   void changeVisibilityCPassword() {
//     isCPassword.value = !isCPassword.value;
//   }
//
//   Future<void> registerNewUser({
//     required String userName,
//     required String email,
//     required String password,
//     required String image,
//   }) async {
//     String msg = await AuthServices.authServices.registerUser(
//       email: email,
//       password: password,
//     );
//
//     if (msg == 'Success') {
//       Get.back();
//
//       FirestoreServices.firestoreServices.addUser(
//         model: UserModel(
//           uid: AuthServices.authServices.currentUser?.uid ?? "",
//           name: userName,
//           email: email,
//           password: password,
//           image: AuthServices.authServices.currentUser?.photoURL ?? "",
//           token: await FirebaseMessaging.instance.getToken() ?? "",
//         ),
//       );
//
//       // toastification.show(
//       //   title: const Text("Success"),
//       //   description: const Text(
//       //     "register success.. 😪",
//       //   ),
//       //   autoCloseDuration: const Duration(
//       //     seconds: 3,
//       //   ),
//       //   type: ToastificationType.success,
//       //   style: ToastificationStyle.minimal,
//       // );
//       // } else {
//       //   toastification.show(
//       //     title: const Text("Register Failed"),
//       //     description: Text(
//       //       msg,
//       //     ),
//       //     autoCloseDuration: const Duration(
//       //       seconds: 3,
//       //     ),
//       //     type: ToastificationType.error,
//       //     style: ToastificationStyle.minimal,
//       //   );
//       // }
//     }
//
//     // Future<void> pickUserImage() async {
//     //   ImagePicker picker = ImagePicker();
//     //
//     //   XFile? xFile = await picker.pickImage(
//     //     source: ImageSource.camera,
//     //   );
//     //
//     //   if (xFile != null) {
//     //     image = File(xFile.path);
//     //   }
//     //
//     //   update();
//     // }
//   }
// }

import 'package:chat_app/modals/user_modal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import '../../../services/auth_services.dart';
import '../../../services/firestore_services.dart';
import '../utils/routes/routes.dart';

class RegisterController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  // WallpaperController wallpaperController = Get.put(WallpaperController());
  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> singUp(uName, email, password, cNumber) async {
    String msg = await AuthServices.authServices.signUp(email, password);
    if (msg == "Success") {
      toastification.show(
        title: const Text("Success"),
        description: Text(msg),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
      FirestoreServices.firestoreServices.addUser(
        model: UserModel(
          uid: AuthServices.authServices.currentUser?.uid ?? "",
          name: uName,
          email: email,
          selectedImage: "${AuthServices.authServices.currentUser?.photoURL}",
          password: password,
          cNumber: cNumber,
          image: "",
          token: await FirebaseMessaging.instance.getToken() ?? "",
        ),
      );
      Get.offNamed(AppRoutes.loginPage);
    } else {
      toastification.show(
        autoCloseDuration: const Duration(seconds: 2),
        title: const Text("Error"),
        description: Text(msg),
        type: ToastificationType.error,
      );
    }
    update();
  }

  Future<void> signUpWithGoogle() async {
    await AuthServices.authServices.signUpWithGoogle();
  }
}
