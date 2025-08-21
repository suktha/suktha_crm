// ignore_for_file: deprecated_member_use, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/view/screens/field_work/start_field_work/start_field_work_screen.dart';
import 'package:work_Force/view/screens/field_work/controller/checkInOut_controller.dart';
import 'package:work_Force/view/screens/field_work/start_field_work/clockedInTask_screen.dart';

class CheckInOutCard extends StatelessWidget {
  HomeController homeController;
  final CheckInOutController controller = Get.put(CheckInOutController());

  CheckInOutCard({super.key, required this.homeController});

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final h = twoDigits(duration.inHours);
    final m = twoDigits(duration.inMinutes.remainder(60));
    final s = twoDigits(duration.inSeconds.remainder(60));
    return "$h:$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color:
              controller.isClockedIn.value ? Colors.green[50] : Colors.red[50],
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: kColorwhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome ${homeController.username.value}..!!",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      controller.isClockedIn.value
                          ? "You are Clocked In"
                          : "You are Clocked Out",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: controller.isClockedIn.value
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 7),

                    // 🔴 Show Timer or Worked Duration
                    Obx(() {
                      final duration = controller.isClockedIn.value
                          ? controller.elapsedTime.value
                          : controller.workedDuration.value;

                      return Text(
                        controller.isClockedIn.value
                            ? "Working: ${formatDuration(duration)}"
                            : "Worked: ${formatDuration(duration)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      );
                    }),

                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            controller.isClockedIn.value
                                ? controller.toggleCheck()
                                : Get.to(() => ClockedintaskScreen());
                          },
                          label: Text(controller.isClockedIn.value
                              ? "Clock Out"
                              : "Clock In"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isClockedIn.value
                                ? Colors.red
                                : Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        controller.isClockedIn.value
                            ? CircleAvatar(
                                backgroundColor: kColorLightGrey,
                                child: IconButton(
                                    tooltip: "View Clocked In Tasks",
                                    onPressed: () {
                                      Get.to(() =>  TaskMapScreen());
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18.sp,
                                      color: kColorgrey,
                                    )),
                              )
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
                const Spacer(),
                controller.isClockedIn.value
                    ? Lottie.asset(
                        "assets/lottie/checkIn.json",
                        // repeat: false,
                        height: 100,
                        width: 100,
                      )
                    : Lottie.asset(
                        "assets/lottie/clockout.json",
                        // repeat: false,
                        height: 100,
                        width: 100,
                      )
              ],
            ),
          ),
        ));
  }
}
