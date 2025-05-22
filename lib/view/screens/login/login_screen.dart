// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/controllers/Login_Controller.dart';
import 'package:work_Force/controllers/subscribtion_controller.dart';
import 'package:work_Force/view/screens/login/splash_screen.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_loading_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  SubscriptionController subcontroller = Get.put(SubscriptionController());
  @override
  void initState() {
    subcontroller.getSubscriptionDetails();
    super.initState();
  }

  double fontsize = 15;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      // backgroundColor: Colors.indigo,
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
      backgroundColor:const Color.fromARGB(255, 32, 60, 107),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(18.0.w), 
          child: Image.asset(
            logoIconwithTradeMark,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Obx(
            () => AutofillGroup(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 25.h),


                  
                    // Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                      child: Column(
                        children: [
                          FadeIn(
                            delay: const Duration(milliseconds: 1100),
                            duration: const Duration(milliseconds: 1200),
                            child: CustomTextField(
                              multilines: 1,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Username';
                                }
                                return null;
                              },
                              controller: controller.usernameController,
                              obscure: false,
                              label: "Username",
                              autofillHints: const [AutofillHints.username],
                            ),
                          ),
                          FadeIn(
                            delay: const Duration(milliseconds: 1200),
                            duration: const Duration(milliseconds: 1400),
                            child: CustomTextField(
                                multilines: 1,
                                textCapitalization: TextCapitalization.none,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [AutofillHints.password],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                controller: controller.passwordController,
                                obscure: controller.obscureText.value,
                                suffixIcon: IconButton(
                                    splashColor: kColortransparent,
                                    highlightColor: kColortransparent,
                                    icon: Icon(
                                        controller.obscureText.value == true
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                    onPressed: () {
                                      controller.obscureText.value =
                                          !controller.obscureText.value;
                                    }),
                                label: "Password"),
                          ),

                          
                          SizedBox(
                            height: 1.h,
                          ),
                          FadeIn(
                            delay: const Duration(milliseconds: 1200),
                            duration: const Duration(milliseconds: 1400),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  // onTap: () => Get.to(() => ForgotPasswordScreen(), transition: Transition.cupertinoDialog, duration: Duration(milliseconds: 1000)),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontsize.sp),
                                  ),
                                )),
                          ),
                          SizedBox(height: 5.h),
                          FadeIn(
                            delay: const Duration(milliseconds: 1300),
                            duration: const Duration(milliseconds: 1600),
                            child: CustomAnimatedButton(
                              height: 6.h,
                              width: 40.w,
                              controller: controller.btnController1,
                              name: "Sign In",
                              ontap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.loginData(
                                      controller.btnController1, context);

                                  if (controller.isSubscriptionEnded.value ==
                                      true) {
                                    susbcripionEndPopup(context, controller);
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Platform.isAndroid
                              ? FadeIn(
                                  delay: const Duration(milliseconds: 1400),
                                  duration: const Duration(milliseconds: 1800),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Fluttertoast.showToast(
                                      //   msg: "This feature is in Progress",
                                      //   toastLength: Toast.LENGTH_SHORT,
                                      //   gravity: ToastGravity.BOTTOM,
                                      //   timeInSecForIosWeb: 1,
                                      //   textColor: kColorwhite,
                                      //   backgroundColor: kColorgrey,
                                      // );
                                      Get.to(SplashScreen(),
                                          duration: Duration(
                                            milliseconds: 600,
                                          ),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "Don't Have an Account ? ",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: "Register",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "This feature is in Progress",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  textColor: kColorwhite,
                                                  backgroundColor: kColorgrey,
                                                );
                                                // Get.to(RegisterScreen(),
                                                //     duration: Duration(
                                                //       milliseconds: 600,
                                                //     ),
                                                //     transition: Transition.rightToLeftWithFade);
                                              })
                                      ]),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  susbcripionEndPopup(BuildContext context, LoginController controller) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            margin: EdgeInsets.all(2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Subscription Expired..!!!",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: kColorlightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: Lottie.asset(
                    subscriptionLottie,
                    height: MediaQuery.of(context).size.height * 0.4,
                    alignment: Alignment.centerLeft,
                    addRepaintBoundary: false,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  "To continue enjoying our premium features and benefits, please renew your subscription. We appreciate your continued support! 🚀 ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                GestureDetector(
                  onTap: () async {
                    print("Subscription Details");
                    await subcontroller.getSubscriptionDetails();
                    // Get.to(() => SunscriptionDetailsScreen(isSubscribtionEnded: controller.isSubscriptionEnded.value),
                    //     transition: Transition.leftToRightWithFade, duration: Duration(milliseconds: 1000));
                  },
                  child: Text(
                    "View Current Subscription Details",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kColorlightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomButton(
                  width: 50.w,
                  ontap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.w))),
                          title: Text('Notice!',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'This feature is not available in our Mobile Application right now',
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              SizedBox(height: 2.w),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK', style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: "Renewal",
                  color: kColorlightBlue,
                  textcolor: kColorwhite,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "No, Thanks",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
