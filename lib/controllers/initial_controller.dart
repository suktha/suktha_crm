// ignore_for_file: avoid_print, prefer_const_constructors


import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainScreen.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';
import 'package:work_Force/view/screens/login/onboarding/onboarding_screen.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class InitialController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // getAllRecentActivity();
    // fetchDashboardData();
    checkLastLoginTime();
  }

  RxList<String> carouselText = <String>[].obs;
  final dropdownvalue = '3'.obs;

  void setSelected(String value) {
    dropdownvalue.value = value;
    // getInvoicePayment();
  }

  checkLastLoginTime() async {
    print("inside the last login time check");
    final prefs = await SharedPreferences.getInstance();
    final lastLoginTimeString = prefs.getString('_lastLoginTime');
    final value = prefs.getBool('loginsuccess');
    final onboardvalue = prefs.getBool("onboardKey");

    final lastLoginTime =
        DateTime.parse(lastLoginTimeString ?? DateTime.now().toString());
    final difference = DateTime.now().difference(lastLoginTime);

    print(difference.inHours);

    if (difference.inHours >= 24) {
      await prefs.clear();

      Get.offAll(() => const LoginPage(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 1000));

      customSnackbar("Session TimeOut", "Please Login Again", "error");
    } else {
      if (value == true) {
        print("navigate to main screen");

        navToMain();
      } else if (onboardvalue == true) {
        navToLogin();
        print("navigate to login screen");
      } else {
        print("navigate to onboard screen");

        navtoOnboard();
      }
    }
  }

  void navToLogin() {
    Future.delayed(const Duration(seconds: 2), () async {
      Get.offAll(() => const LoginPage(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 700));
    });
  }

  navtoOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboardKey", true);

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const OnboardingScreen(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 700));
    });
  }

  

  void navToMain() {
    Get.put(NavigationController());
    Get.put(GlobalController());
    Get.put(SettingsController());
   Get.put(HomeController());

    Future.delayed(const Duration(seconds: 1), () async {
      Get.offAll(
          () => BottomNavigationMainscreen(initialIndex: 1,),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 700));
    });
  }
}
