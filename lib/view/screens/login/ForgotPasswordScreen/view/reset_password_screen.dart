// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/login/ForgotPasswordScreen/controller/forgotpassword_controller.dart';
import 'package:work_Force/view/screens/login/registration/registration_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  ForgotpasswordController controller = Get.put(ForgotpasswordController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          automaticallyImplyLeading: false,
          title: const Text('Reset password'),
          titleTextStyle: TextStyle(
            color: kColorblack,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Enter your new password below to reset it.",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // Add your reset password form here
                  // For example, TextFormField for new password input
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          buildTextField(
                              label: "New Password",
                              controller: controller.newPasswordController,
                              obscureText: controller.isPasswordVisible.value,
                              maxLength: 12,
                              bottomHeight: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a new password";
                                }
                                if (value.length < 5) {
                                  return "Password must be at least 5 characters";
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.togglePasswordVisibility();
                                  },
                                  icon: Icon(controller.isPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          SizedBox(height: 2.h),
                          buildTextField(
                              label: "Confirm Password",
                              controller: controller.confirmPasswordController,
                              obscureText: controller.isconfirmPasswordVisible.value,
                              maxLength: 12,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                }
                                if (value !=
                                    controller.newPasswordController.text) {
                                  return "Passwords do not match";
                                }

                                return null;
                              },
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.toggleconfirmPasswordVisibility();
                                  },
                                  icon: Icon(controller.isconfirmPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                                              controller.resetpassword();

                      } else {
                        Get.snackbar("Error", "Please fill in all fields correctly",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                    ),
                    child: Text("Reset", style: TextStyle(fontSize: 16.sp)),
                  ),
                  SizedBox(height: 2.h),
                ],
              )),
        ));
  }
}
