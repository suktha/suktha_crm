// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/controllers/initial_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navcontroller = Get.put(InitialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 32, 60, 107),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.w),
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
                    Image.asset(
                      logoIconwithTradeMark,
                      fit: BoxFit.cover,
                      // width: double.infinity,
                      // height: 45.w,
                    ),
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
