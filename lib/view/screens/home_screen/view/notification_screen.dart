// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/home_screen/widget/notification_card.dart';

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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: kColorblack,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.h,
              ),
              NotificationCard(
                title: "Check-in reminder",
                subTitle: "Check-in to track your location",
                time: "now",
              ),
              SizedBox(
                height: 1.h,
              ),
              NotificationCard(
                title: "New Task Assigned",
                subTitle: "You’ve been assigned a new task. Check details now.",
                time: "11:15",
              ),
              SizedBox(
                height: 1.h,
              ),
              NotificationCard(
                title: "Upcoming Deadline",
                subTitle: "Your task ‘Prepare Quotation’ is due in 1 hour.",
                time: "10:30",
              ),  SizedBox(
                height: 1.h,
              ),
              NotificationCard(
                title: "New Comment on Task",
                subTitle: "Admin commented on ‘Client Meeting Follow-up’.",
                time: "10:00",
              ),  SizedBox(
                height: 1.h,
              ),
              NotificationCard(
                title: "Task Completed",
                subTitle: "‘Send Proposal to Client’ marked as completed.",
                time: "9:45",
              ),  SizedBox(
                height: 1.h,
              ),
              NotificationCard(
                title: "New Lead Assigned",
                subTitle: "You’ve been assigned a lead: John Mathew (IT Sector)",
                time: "9:00",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
