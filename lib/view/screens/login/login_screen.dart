// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/controllers/Login_Controller.dart';
import 'package:suktha_crm/controllers/subscribtion_controller.dart';
import 'package:suktha_crm/view/widget/custom_loading_button.dart';
import 'package:suktha_crm/view/widget/custom_textfield.dart';

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
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Obx(
              () => AutofillGroup(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      FadeIn(
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1000),
                        child: SizedBox(
                          width: 70.w,
                          height: 30.h,
                          child: Column(
                            children: [
                              Image.asset(logoIconwithTradeMark, height: 18.w),
                              Image.asset(
                                logoText,
                                width: 60.w,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                icon: Icon(controller.obscureText.value == true ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  controller.obscureText.value = !controller.obscureText.value;
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
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontsize.sp),
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
                              await controller.loginData(controller.btnController1, context);

                              if (controller.isSubscriptionEnded.value == true) {
                                // susbcripionEndPopup(context, controller);
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Platform.isAndroid
                          ? FadeIn(
                              delay: const Duration(milliseconds: 1400),
                              duration: const Duration(milliseconds: 1800),
                              child: GestureDetector(
                                onTap: () {
                                  // Get.to(RegisterScreen(),
                                  //     duration: Duration(
                                  //       milliseconds: 600,
                                  //     ),
                                  //     transition: Transition.rightToLeftWithFade);
                                },
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(text: "Don't Have an Account ? ", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black)),
                                    TextSpan(
                                        text: "Register",
                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//   // susbcripionEndPopup(BuildContext context, LoginController controller) {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             // height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20.0),
//                 topRight: Radius.circular(20.0),
//               ),
//             ),
//             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
//             margin: EdgeInsets.all(2.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Subscription Expired..!!!",
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     color: kColorlightBlue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.03,
//                 ),
//                 Center(
//                   child: Lottie.asset(
//                     subscriptionLottie,
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     alignment: Alignment.centerLeft,
//                     addRepaintBoundary: false,
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.04,
//                 ),
//                 Text(
//                   "To continue enjoying our premium features and benefits, please renew your subscription. We appreciate your continued support! 🚀 ",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4.h,
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     print("Subscription Details");
//                     await subcontroller.getSubscriptionDetails();
//                     Get.to(() => SunscriptionDetailsScreen(isSubscribtionEnded: controller.isSubscriptionEnded.value),
//                         transition: Transition.leftToRightWithFade, duration: Duration(milliseconds: 1000));
//                   },
//                   child: Text(
//                     "View Current Subscription Details",
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: kColorlightBlue,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 CustomButton(
//                   width: 50.w,
//                   ontap: () async {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
//                           title: Text('Notice!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                           content: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 'This feature is not available in our Mobile Application right now',
//                                 style: TextStyle(fontSize: 13.sp),
//                               ),
//                               SizedBox(height: 2.w),
//                             ],
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text('OK', style: TextStyle(fontSize: 18)),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   title: "Renewal",
//                   color: kColorlightBlue,
//                   textcolor: kColorwhite,
//                 ),
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Text(
//                     "No, Thanks",
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
}
