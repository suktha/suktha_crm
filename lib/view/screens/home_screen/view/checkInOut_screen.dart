import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class CheckInOutController extends GetxController {
  var isCheckedIn = false.obs;

  void toggleCheck() {
    isCheckedIn.value = !isCheckedIn.value;
  }
}

class CheckInOutCard extends StatelessWidget {
  final CheckInOutController controller = Get.put(CheckInOutController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color:
              controller.isCheckedIn.value ? Colors.green[50] : Colors.red[50],
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
                      controller.isCheckedIn.value
                          ? "You are Checked In"
                          : "You are Checked Out",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: controller.isCheckedIn.value
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: controller.toggleCheck,
                      icon: Icon(controller.isCheckedIn.value
                          ? Icons.logout
                          : Icons.login),
                      label: Text(controller.isCheckedIn.value
                          ? "Check Out"
                          : "Check In"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isCheckedIn.value
                            ? Colors.red
                            : Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                LottieBuilder.asset(
                  "assets/lottie/checkIn.json",
                )
              ],
            ),
          ),
        ));
  }
}
