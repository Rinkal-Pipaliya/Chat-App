import 'package:chat_app/screen/auth/login_screen.dart';
import 'package:chat_app/screen/auth/register_screen.dart';
import 'package:chat_app/screen/chat/chat_page.dart';
import 'package:chat_app/screen/home/home_screen.dart';
import 'package:chat_app/screen/splash/splash_screen.dart';

import 'package:get/get.dart';

class AppRoutes {
  static String splashPage = '/';
  static String loginPage = '/login';
  static String registerPage = '/register';
  static String homePage = '/home';
  static String chatPage = '/chat';

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: loginPage,
      page: () => LoginPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: registerPage,
      page: () => RegisterPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: chatPage,
      page: () => ChatPage(),
      transition: Transition.cupertino,
    ),
  ];
}
