// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/controllers/initial_controller.dart';

class SplashScreen extends GetView<InitialController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 60, 107),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(logoIconwithTradeMark),
                const Spacer(),
                LoadingAnimationWidget.threeRotatingDots(
                  color: Colors.lightBlue,
                  size: 10.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
