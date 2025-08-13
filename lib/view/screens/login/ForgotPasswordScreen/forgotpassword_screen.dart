import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/login/ForgotPasswordScreen/controller/forgotpassword_controller.dart';
import 'package:work_Force/view/screens/login/registration/registration_screen.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotpasswordController controller = Get.put(ForgotpasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Divider(
            color: Colors.grey.shade400,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorgreyShade500,
            size: 18.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Forgot password?'),
        titleTextStyle: TextStyle(
          color: kColorblack,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                  controller.isResetButtonEnabled.value
                      ? "Code sent! Check your email to verify."
                      : "Enter your registered username, and we’ll mail \nyou a code to reset your password.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color.fromARGB(255, 28, 28, 28),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 2.h),
            controller.isResetButtonEnabled.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" Reset Code",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: kColorblack,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2.w),
                      buildTextField(
                          label: "Enter your code",
                          controller: controller.OTPController),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" Username",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: kColorblack,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2.w),
                      buildTextField(
                          label: "Enter your username",
                          controller: controller.usernameController),
                    ],
                  ),
            SizedBox(height: 5.h),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (controller.isResetButtonEnabled.value) {
                      if (controller.OTPController.text.isEmpty) {
                        customSnackbar("Error", "Please enter the code", "error");
                      } else {
                        print("OTP entered: ${controller.OTPController.text}");
                        controller.submitOTP(
                            controller.OTPController.text);
                      }
                    } else {
                      if (controller.usernameController.text.isEmpty) {
                        customSnackbar("Error", "Please enter your username", "error");
                      } else {
                        controller.getOtpWithRegisterdUsername(
                            controller.usernameController.text);
                      }
                    }
                // Handle forgot password logic here
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w)),
              ),
              child: Text(
                  controller.isResetButtonEnabled.value
                      ? "Submit"
                      : 'Reset Password',
                  style: TextStyle(fontSize: 16.sp)),
            ),
            SizedBox(height: 3.h),
          ],
        ),)
      ),
    );
  }
}
