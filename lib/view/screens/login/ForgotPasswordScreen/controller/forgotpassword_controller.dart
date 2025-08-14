// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/view/screens/login/ForgotPasswordScreen/view/reset_password_screen.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class ForgotpasswordController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController OTPController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isResetButtonEnabled = false.obs;
  final FocusNode focusNode = FocusNode();

  void toggleResetButton() {
    isResetButtonEnabled.value = !isResetButtonEnabled.value;
  }

  var isPasswordVisible = true.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isconfirmPasswordVisible = true.obs;

  void toggleconfirmPasswordVisibility() {
    isconfirmPasswordVisible.value = !isconfirmPasswordVisible.value;
  }

  String username = '';
  RxString showRegisteredMail = "".obs;

  Dio dio = Dio();
  getOtpWithRegisterdUsername(String username) async {
    print("Sending OTP to $username");
    this.username = username;

    var apiUrl = "$baseAuthUrl/auth/generate-otp/$username";

    try {
      print("API URL: $apiUrl");
      var response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            // Add any other headers if needed
          },
        ),
      );
      print("Response: ${response.data}");
      if (response.data['responseStatus'] == 1) {
        print("OTP sent successfully to $username");
        showRegisteredMail.value = response.data["responseString"];
        customSnackbar("Success", response.data['responseString'], "success");
        toggleResetButton();
        usernameController.clear();
        focusNode.unfocus();
      } else if (response.data['responseStatus'] == 0) {
        customSnackbar("Error", response.data['responseString'], "error");
        print("Failed to send OTP: ${response.data}");
      }
    } catch (e) {
      print("Error sending OTP: $e");
      customSnackbar("Error", "Something went wrong", "error");
    }
  }

  submitOTP(var otp) async {
    var apiUrl = "$baseAuthUrl/auth/validate-otp/$otp/$username";

    print("Submitting OTP for $username: $otp");
    print("API URL: $apiUrl");

    try {
      var response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            // Add any other headers if needed
          },
        ),
      );
      print("Response: ${response.data}");
      if (response.data['responseStatus'] == 1) {
        print("OTP verified successfully for $username");
        toggleResetButton();

        customSnackbar("Success", response.data['responseString'], "success");
        Get.to(() => ResetPasswordScreen(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 1000));
      } else if (response.data['responseStatus'] == 0) {
        customSnackbar("Error", response.data['responseString'], "error");
        print("Failed to verify OTP: ${response.data}");
      }
    } catch (e) {
      print("Error submitting OTP: $e");
      customSnackbar("Error", "Something went wrong", "error");
    }
  }

  resetpassword() async {
    var apiUrl = "$baseAuthUrl/auth/reset-password";

    print("Resetting password for $username");
    print("API URL: $apiUrl");
    try {
      var response = await dio.post(apiUrl,
          data: {
            "username": username,
            "password": confirmPasswordController.text,
          },
          options: Options(
            headers: {
              "Content-Type": "application/json",
              // Add any other headers if needed
            },
          ));
      print("Response: ${response.data}");
      if ( response.data['responseStatus'] == 1) {
        print("Password reset successfully for $username");
        Get.to(() => const LoginPage(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 1000));
        customSnackbar("Success", response.data['responseString'], "success");
      } else if(response.data['responseStatus'] == 0) {
        customSnackbar("Error", response.data['responseString'], "error");
        print("Failed to reset password: ${response.data}");
      }
    } catch (e) {
      print("Error resetting password: $e");
      customSnackbar("Error", "Something went wrong", "error");
    }
  }
}
