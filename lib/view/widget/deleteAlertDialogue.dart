import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

Future<dynamic> customDeleteAlertDialogue(BuildContext context, VoidCallback ontap) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: EdgeInsets.symmetric(horizontal: 5.w),
        alignment: Alignment.center,
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 5.h,
                    width: 22.w,
                    decoration: BoxDecoration(color: kColorwhite, boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(10.w)),
                    child: Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp, color: kColorblack),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: Container(
                    height: 5.h,
                    width: 22.w,
                    decoration: BoxDecoration(color: Colors.red, boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(10.w)),
                    child: Center(
                        child: Text(
                      "Confirm",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp, color: kColorwhite),
                    )),
                  ),
                )
              ],
            ),
          )
        ],
        content: SizedBox(
          height: 29.h,
          child: Column(
            children: [
              LottieBuilder.asset(
                "assets/lottie/deleteDialogue.json",
                height: 50.w,
              ),
              Text(
                "Do you want to delete it??",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
  );
}

Future<dynamic> customCancelAlertDialogue(BuildContext context, VoidCallback ontap) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: EdgeInsets.symmetric(horizontal: 5.w),
        alignment: Alignment.center,
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 5.h,
                    width: 22.w,
                    decoration: BoxDecoration(color: kColorwhite, boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(10.w)),
                    child: Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp, color: kColorblack),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: Container(
                    height: 5.h,
                    width: 22.w,
                    decoration: BoxDecoration(color: Colors.red, boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(10.w)),
                    child: Center(
                        child: Text(
                      "Confirm",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp, color: kColorwhite),
                    )),
                  ),
                )
              ],
            ),
          )
        ],
        content: SizedBox(
          height: 33.h,
          child: Column(
            children: [
              LottieBuilder.asset(
                "assets/lottie/sad.json",
                height: 50.w,
              ),
              SizedBox(
                width: 60.w,
                child: Text(
                  "Transaction cannot be reverted once it is cancelled. Are you sure you want to cancel?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )),
  );
}
