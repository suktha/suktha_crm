// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/login/ForgotPasswordScreen/controller/forgotpassword_controller.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
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
          child: Obx(
            () => Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                        controller.isResetButtonEnabled.value
                            ? "✅ ${controller.showRegisteredMail.value}"
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
                                key: const ValueKey("otpField"),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.length > 4) {
                                    return "Enter 4 digit code";
                                  }
                                  return null;
                                },
                                titleController: controller.OTPController),
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
                              key: const ValueKey("usernameField"),
                              maxLengthCount: 50,
                              titleController: controller.usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                if (value.length < 5) {
                                  return "username should be minimum 5 characters";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                  SizedBox(height: 5.h),
                  const Spacer(),
                  CustomButton(
                      title: controller.isResetButtonEnabled.value
                          ? "Submit"
                          : 'Reset Password',
                      ontap: () {
                        if (controller.isResetButtonEnabled.value) {
                          if (controller.OTPController.text.isEmpty) {
                            customSnackbar(
                                "Error", "Please enter the code", "error");
                          } else {
                            print(
                                "OTP entered: ${controller.OTPController.text}");
                            controller.submitOTP(controller.OTPController.text);
                          }
                        } else {
                          if (controller.usernameController.text.isEmpty) {
                            customSnackbar(
                                "Error", "Please enter your username", "error");
                          } else {
                            controller.getOtpWithRegisterdUsername(
                                controller.usernameController.text);
                          }
                        }
                      },
                      width: double.infinity),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
          )),
    );
  }
}
