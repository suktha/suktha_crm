// theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  ThemeData get currentTheme => isDarkMode.value ? darkTheme : lightTheme;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(currentTheme);
  }
}

final lightTheme = ThemeData(
  // Light theme properties
  brightness: Brightness.light,
  // ...
);

final darkTheme = ThemeData(
  // Dark theme properties
  brightness: Brightness.dark,
  // ...
);
