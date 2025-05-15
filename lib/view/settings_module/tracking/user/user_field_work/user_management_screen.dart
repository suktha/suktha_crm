// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' as lt;
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Model/lead_model.dart';
import 'package:work_Force/view/settings_module/tracking/user/user_field_work/user_management_controller.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import '../../../../../Constants/colors.dart';
import '../../../../../utils/responsive_utils.dart';

class UserManagementScreen extends StatelessWidget {
  final LeadModel leadValue;
  UserManagementScreen({super.key, required this.leadValue});

final controller = Get.find<UserManagementController>();

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);
    // double textScaleFactor = ResponsiveUtils.textScaleFactor(context);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromARGB(255, 241, 241, 241),
          appBar: AppBar(
            title: const Text("User Field Management"),
            titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: width * 0.05),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 241, 241, 241),
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: kColorblack, size: 25),
                onPressed: (() {
                  print("In the backbutton -- " + controller.isLoading.value.toString());
                  Get.back();
                })),
          ),
          body: Column(children: [
            Container(
              // height: height * 0.3,
              width: width,
              margin: EdgeInsets.all(width * 0.04),
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(width * 0.05), color: kColorwhite),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(leadValue.leadGenerationNumber!, style: TextStyle(fontSize: width * 0.04)),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            "Follow-up with ${leadValue.leadName}",
                            style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        // height: height * 0.06,
                        width: width * 0.15,
                        padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.005),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.08), boxShadow: kElevationToShadow[1], color: kColorlightBlue300),
                        child: Center(
                          child: Text(
                            // DateFormat('MMM').format(
                            //   DateTime.parse(leadValue.followUpDate!),
                            // ),
                            "Jun\n10\nSat",
                            style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.bold, color: kColorwhite),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UserContactsIcon(
                        width: width,
                        height: height,
                        onTap: () {
                          var url = Uri.parse("tel:${987654321}");
                          urlLauncher.launchUrl(url);
                        },
                        childWidget: Icon(Icons.call),
                      ),
                      UserContactsIcon(
                        width: width,
                        height: height,
                        onTap: () {},
                        childWidget: Image.asset(
                          gmailIcon,
                          height: height * 0.03,
                        ),
                      ),
                      UserContactsIcon(
                        width: width,
                        height: height,
                        onTap: () {
                          if (leadValue.leadGeoLocation != null) {
                            print("data is not available");
                            List<String> latLong = leadValue.leadGeoLocation.split(",");

                            controller.openGoogleMaps(
                              double.parse(latLong[1]),
                              double.parse(latLong[0]),
                            );
                          } else {
                            print("data is not available");
                            customSnackbar("Not Avaiaable", "Location is not Available", "error");
                          }
                        },
                        childWidget: Image.asset(
                          googleMapIcon,
                          height: height * 0.03,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Obx(() => Container(
                  constraints: BoxConstraints(maxHeight: height * 0.35),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        for (int i = 0; i < controller.timelineItems.length; i++)
                          TimelineTile(
                            alignment: TimelineAlign.start,
                            isFirst: i == 0,
                            isLast: i == controller.timelineItems.length - 1,
                            endChild: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.02,
                                horizontal: width * 0.05,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display the action and time
                                  InkWell(
                                    onTap: () => customDeleteAlertDialogue(
                                      context,
                                      () {
                                        controller.deleteTimelineItem(i);
                                      },
                                    ),
                                    child: Text(
                                      controller.timelineItems[i]['action'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.05,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "At ${DateFormat('h:mm a | dd-MM-yyyy').format(controller.timelineItems[i]['time'])}",
                                    style: TextStyle(fontSize: width * 0.035),
                                  ),
                                  SizedBox(height: 10),
                                  // Clickable location text
                                  GestureDetector(
                                    onTap: () {
                                      // Here, you can open a map or show location details
                                      // Get.snackbar(
                                      //   "Location",
                                      //   "Location: ${controller.timelineItems[i]['location']}",
                                      //   snackPosition: SnackPosition.BOTTOM,
                                      // );

                                      controller.openGoogleMaps(
                                          controller.timelineItems[i]['latitude'], controller.timelineItems[i]['longitude']);
                                    },
                                    child: Text(
                                      "View Location",
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: Colors.blue,
                                            offset: Offset(0, -5),
                                          )
                                        ],
                                        color: Colors.transparent,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.blue,
                                        decorationThickness: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            indicatorStyle: IndicatorStyle(
                              width: 30,
                              color: controller.timelineItems[i]['color'] ?? Colors.white,
                              padding: EdgeInsets.all(8),
                              iconStyle:
                                  IconStyle(color: Colors.white, iconData: controller.timelineItems[i]['icon'] ?? Icons.ac_unit_rounded),
                            ),
                          )
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: height * 0.02,
            ),

            GestureDetector(
              onTap: () => showAddItemDialog(context: context, btnController1: controller.btnController),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Text(
                    "Add Events",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  )
                ],
              ),
            ),

            // ElevatedButton(
            //   onPressed: () => showAddItemDialog(context),
            //   child: Text("Add Events"),
            // ),
            Spacer(),
            SizedBox(
              height: height * 0.12,
              // color: kColorRed,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: height * 0.1,
                        width: width,
                        margin: EdgeInsets.all(width * 0.04),
                        padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.05),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(width * 0.05), color: kColorwhite),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomButton(
                              title: "Log Out",
                              ontap: () {
                                controller.logOut("same place");
                              },
                              width: width * 0.3,
                              color: Colors.red,
                              textcolor: Colors.white,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            )
          ]),
        ),
        Obx(() => Visibility(
              visible: controller.isLoading.value,
              child: Positioned.fill(
                  child: Center(
                      child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeIn(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 300),
                      child: lt.LottieBuilder.asset("assets/lottie/geolocation.json"),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    FadeIn(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        "Updating user locations,\nHold on a second...",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14.sp, decoration: TextDecoration.none),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ))),
            )),
      ],
    );
  }

  void showAddItemDialog({required BuildContext context, required RoundedLoadingButtonController btnController1}) {
    String? selectedAction;
    String? notes;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        backgroundColor: Colors.white,
        actionsPadding: EdgeInsets.all(20),
        title: Text(
          "Add Actions",
        ),
        content: SizedBox(
          width: 100.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action Dropdown
              DropdownButtonFormField<String>(
                value: selectedAction,
                decoration: InputDecoration(
                  labelText: "Select an action",
                  labelStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100], // Light background for dropdown
                ),
                items: [
                  "Travel Starts",
                  "Travel Ends",
                  "Meeting Cancelled",
                  "Meeting Started",
                  "Meeting Ends",
                  "Task completed",
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black87),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedAction = newValue;
                },
              ),
              SizedBox(height: 15), // Adding some space between fields

              // Location Text Field
              TextField(
                maxLines: null,
                controller: controller.messageController,
                minLines: 2,
                onChanged: (value) => notes = value,
                decoration: InputDecoration(
                  labelText: 'Message',
                  labelStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ],
          ),
        ),
        actions: [
          RoundedLoadingButton(
            width: 150,
            // completionCurve: Curves.fastOutSlowIn,
            successIcon: Icons.sentiment_satisfied_alt,
            animateOnTap: false,
            color: Colors.lightBlue,
            elevation: 10,
            successColor: Color.fromARGB(255, 46, 209, 52),
            errorColor: Colors.red,
            failedIcon: Icons.sentiment_dissatisfied,
            controller: btnController1,
            onPressed: () async {
              if (selectedAction != null) {
                controller.btnController.start();
                controller.addTimelineItem(
                  leadValue: leadValue,
                  action: selectedAction!,
                );

                Timer(
                  Duration(seconds: 1),
                  () {
                    Get.back();
                  },
                );
              } else {
                Get.snackbar(
                  "Incomplete Data",
                  "Please select an action and enter a Message",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              }
            },
            child: Text("Done", style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite)),
          ),
        ],
      ),
    );
  }
}

class UserContactsIcon extends StatelessWidget {
  const UserContactsIcon({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.childWidget,
  });

  final double width;
  final double height;
  final VoidCallback onTap;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.19,
        padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.004),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.08),
            // boxShadow: kElevationToShadow[1],
            gradient: LinearGradient(colors: [
              kColorlightBlue100,
              Color.fromRGBO(201, 229, 255, 1),
            ])),
        child: Center(child: childWidget),
      ),
    );
  }
}
