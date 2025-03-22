import 'dart:async';

import 'package:chat_app/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(
        seconds: 5,
      ),
      () {
        if (AuthServices.authServices.currentUser != null) {
          Get.toNamed(AppRoutes.homePage);
        } else {
          Get.toNamed(AppRoutes.loginPage);
        }
      },
      // () => Get.toNamed(GetPages.login),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          height: 300,
          image: AssetImage(
            'assets/gif/splash.gif',
          ),
        ),
      ),
    );
  }
}
