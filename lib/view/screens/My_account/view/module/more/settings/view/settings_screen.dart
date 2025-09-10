import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/My_account/view/module/more/settings/view/feedback/feedback_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/more/settings/view/notification/notification_settings_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/more/settings/view/report_bug/report_bug_screen.dart';
import 'package:work_Force/view/widget/custom_settings_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorwhite,
      appBar: AppBar(
        backgroundColor: kColorwhite,
        elevation: 0,
        title: const Text(
          'Settings',
        ),
        titleTextStyle: TextStyle(
            color: kColorblack, fontSize: 19.sp, fontWeight: FontWeight.w600),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kColorblack,
            size: 18.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.w),
                  child: Image.asset("assets/Images/profile_pic.jpg",
                      height: 18.h)),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.5.w, top: 2.h, bottom: 1.h),
              child: Text(
                "General",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            MoreListCustomWidgets(
              width: 16.0,
              title: "Notification Settings",
              icon: Icons.notifications_outlined,
              ontap: () {
                Get.to(() => const NotificationSettingsScreen(),
                    duration: const Duration(milliseconds: 400),
                    transition: Transition.rightToLeft);
              },
            ),
            MoreListCustomWidgets(
              width: 16.0,
              title: "Privacy Policy",
              icon: Icons.privacy_tip_outlined,
              ontap: () {},
            ),
            MoreListCustomWidgets(
              width: 16.0,
              title: "Terms & Conditions",
              icon: Icons.article_outlined,
              ontap: () {},
            ),
            MoreListCustomWidgets(
              width: 16.0,
              title: "Financial year master",
              icon: Icons.calendar_view_month,
              ontap: () {},
            ),
            MoreListCustomWidgets(
              width: 16.0,
              title: "About Us",
              icon: Icons.info_outline,
              ontap: () {},
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.5.w, top: 2.h, bottom: 1.h),
              child: Text(
                "Feedback",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            MoreListCustomWidgets(
              width: 16.0,
              title: "Report a Bug",
              icon: Icons.bug_report_outlined,
              ontap: () {
                   Get.to(() =>  ReportBugScreen(),
                    duration: const Duration(milliseconds: 400),
                    transition: Transition.rightToLeft);
              },
            ),
            MoreListCustomWidgets(
              width: 16.0,
              title: "Send Feedback",
              icon: Icons.feedback_outlined,
              ontap: () {
                  Get.to(() =>  const FeedBackScreen(),
                    duration: const Duration(milliseconds: 400),
                    transition: Transition.rightToLeft);
              },
            ),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  // CustomButton(title: "LOGOUT", ontap: () {}, width: 50.w),
                  // SizedBox(height: 1.h,),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Delete account",
                      style: TextStyle(
                        shadows: const [
                          Shadow(
                              color: Color.fromARGB(255, 246, 89, 78),
                              offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
