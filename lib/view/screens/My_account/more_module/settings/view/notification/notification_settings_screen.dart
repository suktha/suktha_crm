import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool allNotifications = true;
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool inAppNotifications = true;
  bool reminders = true;
  bool summaryReports = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorwhite,
      appBar: AppBar(
        backgroundColor: kColorwhite,
        elevation: 0,
        title: const Text(
          'Notification Settings',
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
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.w),
            boxShadow:  [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 1,
                spreadRadius: 10,
              ),
            ],
          ),
          child: ListView(
            children: [
              SwitchListTile(
                title:  Text("All Notifications",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                subtitle: const Text("Turn on/off all notifications"),
                value: allNotifications,
                onChanged: (val) {
                  setState(() {
                    allNotifications = val;
                    emailNotifications = val;
                    pushNotifications = val;
                    inAppNotifications = val;
                    reminders = val;
                    summaryReports = val;
                  });
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text("Email Notifications"),
                value: emailNotifications,
                onChanged: allNotifications
                    ? (val) => setState(() => emailNotifications = val)
                    : null,
              ),
              SwitchListTile(
                title: const Text("Push Notifications"),
                value: pushNotifications,
                onChanged: allNotifications
                    ? (val) => setState(() => pushNotifications = val)
                    : null,
              ),
              SwitchListTile(
                title: const Text("In-App Notifications"),
                value: inAppNotifications,
                onChanged: allNotifications
                    ? (val) => setState(() => inAppNotifications = val)
                    : null,
              ),
              SwitchListTile(
                title: const Text("Reminders"),
                value: reminders,
                onChanged: allNotifications
                    ? (val) => setState(() => reminders = val)
                    : null,
              ),
              SwitchListTile(
                title: const Text("Daily/Weekly Summary"),
                value: summaryReports,
                onChanged: allNotifications
                    ? (val) => setState(() => summaryReports = val)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
