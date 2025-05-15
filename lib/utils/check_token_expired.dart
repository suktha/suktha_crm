import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';

checkTokenExpired(int? statusCode) async {
  log("checking token expiry and the status code is- $statusCode");

  final prefs = await SharedPreferences.getInstance();
  final lastLoginTimeString = prefs.getString('_lastLoginTime');

  final lastLoginTime = DateTime.parse(lastLoginTimeString ?? DateTime.now().toString());
  final difference = DateTime.now().difference(lastLoginTime);

  print(difference.inHours);

  if (difference.inHours >= 24) {
    await prefs.clear();

    prefs.setBool("onboardKey", true);

    Get.offAll(() => LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 1000));

    // customSnackbar("Session TimeOut", "Please Login Again", "error");
  }

  // if (statusCode == 401) {
  //   final prefs = await SharedPreferences.getInstance();

  //   await prefs.clear();

  //   prefs.setBool("onboardKey", true);

  //   Get.offAll(() => LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 1000));

  //   customSnackbar("Session TimeOut", "Please Login Again", "error");
  // }
  else {
    return null;
  }
}
