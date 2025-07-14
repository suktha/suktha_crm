// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class NotificationHistoryScreen extends StatelessWidget {
  const NotificationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        titleTextStyle: TextStyle(
            color: kColorblack, fontWeight: FontWeight.bold, fontSize: 19.sp),
        // centerTitle: true,
        backgroundColor: kColorwhite,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kColorblack,
            )),
            actions: [
             IconButton(onPressed: () {
               
             }, icon: Icon(Icons.more_vert,color: kColorblack,))
            ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const[
          Center(child: Text("Notification History"))
        ],
      ),
    );
  }
}
