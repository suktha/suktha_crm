import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/controllers/initial_controller.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navcontroller = Get.put(InitialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom:5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                // width: 70.w,
                // height: 30.h,
                child: Column(
                  children: [
                    FadeIn(
                        delay: const Duration(microseconds: 1000),
                        duration: const Duration(microseconds: 1000),
                        child: Image.asset(
                          logoIconwithTradeMark,
                          fit: BoxFit.cover,
                          // width: double.infinity,
                          // height: 45.w,
                        )),
                    // FadeIn(delay: const Duration(microseconds: 1500), duration: const Duration(microseconds: 1500), child: Image.asset(logoText)),
                  ],
                ),
              ),
              const Spacer(),
              LoadingAnimationWidget.threeRotatingDots(
                color: Colors.lightBlue,
                size: 10.w,
              )
            ],
          ),
        ),
      )),
    );
  }
}
