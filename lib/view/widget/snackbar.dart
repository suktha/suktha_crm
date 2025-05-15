import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:work_Force/Constants/colors.dart';

customSnackbar(title, message, type) {
  if (Get.isSnackbarOpen) {
  } else {
    Get.snackbar(title, message,
        snackPosition: type == "success" && type == "normal" ? SnackPosition.TOP : SnackPosition.BOTTOM,
        backgroundColor: type == "error"
            ? Colors.red
            : type == "success"
                ? Colors.green
                : kColorlightBlue,
        colorText: type == "normal" ? kColorwhite : kColorwhite,
        margin: EdgeInsets.all(10),
        boxShadows: kElevationToShadow[2],
        animationDuration: Duration(milliseconds: 700),
        duration: Duration(milliseconds: 1300));
  }
}
