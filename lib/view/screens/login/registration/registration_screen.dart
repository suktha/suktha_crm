// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/utils/validations/validations.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: Colors.black, size: 17.sp)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/Logos/Logo_black.png",
                  height: 6.h,
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  width: 60.w,
                  child: Text("Sign Up For Free, Right Now.",
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: 3.h,
                ),
                buildTextField(
                  label: "User Name",
                  titleController: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  }, 
                ),
                buildTextField(
                    label: "Email",
                    titleController: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (Validate().validateEmail(value) == false) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }),
                buildTextField(
                  label: "Password",
                  titleController: passwordController,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),

                // Confirm Password Field
                buildTextField(
                  label: "Confirm Password",
                  titleController: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  onChanged: (value) {
                    if (value.isNotEmpty && value != passwordController.text) {}
                  },
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),

                RichText(
                    text: TextSpan(
                  text: "By signing up, you agree to our ",
                  style: TextStyle(color: Colors.black, fontSize: 15.5.sp),
                  children: [
                    TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: kColorlightBlue,
                        color: kColorlightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.5.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Terms of Service tap
                        },
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: kColorlightBlue,
                        color: kColorlightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.5.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Privacy Policy tap
                        },
                    ),
                  ],
                )),
                SizedBox(
                  height: 1.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle successful validation
                    }
                    // Your onPressed logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorlightBlue,
                    minimumSize: Size(double.infinity, 5.0.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sign Up",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.black, fontSize: 15.5.sp),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: kColorlightBlue,
                          color: kColorlightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.5.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => LoginPage());
                          },
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(
      {required String label, required List<String> items}) {
    String? selectedValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) => selectedValue = val,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }
}
