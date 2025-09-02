// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/screens/field_work/controller/checkInOut_controller.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class TaskMapScreen extends StatelessWidget {
   TaskMapScreen({super.key});

  final CheckInOutController controller = Get.find<CheckInOutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorLightGrey,
      appBar: AppBar(
        title: const Text("Task Live"),
        elevation: 1,
        titleTextStyle: TextStyle(
            color: kColorblack, fontWeight: FontWeight.bold, fontSize: 18),
        backgroundColor: kColorwhite,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kColorblack,
            size: 17.5.sp,
          ),
          onPressed: () {
            Get.to(
              () => BottomNavigationMainscreen(
                initialIndex: 1,
              ),
              transition: Transition.rightToLeft,
            );
            if (controller.isClockedIn.value) {
            } else {
              controller.taskTimeline.clear();
              controller.textController.clear();
              controller.selectedAction.value = "";
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.3.w),
                      side: BorderSide(
                        color: controller.isClockedIn.value
                            ? kColorlightBlue
                            : Colors.grey,
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (controller.isClockedIn.value) {
                      controller.endTask();
                    } else {
                      customSnackbar(
                          "Error",
                          "Your previous task has ended. Please clock in to start a new one",
                          "error");
                    }
                  },
                  child: Text("End Task",
                      style: TextStyle(
                          color: controller.isClockedIn.value
                              ? Colors.red
                              : Colors.grey,
                          fontWeight: FontWeight.bold)),
                )),
          )
        ],
      ),
      body: Obx(() {
        if (controller.currentLocation.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Flexible(
              flex: 1,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.currentLocation.value!,
                  zoom: 15,
                ),
                markers: controller.markers.value,
                polylines: controller.polylines.value,
                onMapCreated: (map) => controller.mapController = map,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header Section
                    SizedBox(height: 2.w),
                    Text("Kavya went meeting",
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2.w),
                    Text("Company: XYZ Pvt Ltd",
                        style: TextStyle(
                            fontSize: 15.sp, color: Colors.grey[700])),
                    Text("Title: Client Discussion",
                        style: TextStyle(
                            fontSize: 15.sp, color: Colors.grey[700])),

                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "Select Event",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: .2.w, color: kColorlightBlue),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: .2.w, color: kColorlightBlue),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: .2.w, color: kColorlightBlue),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: .2.w, color: kColorlightBlue),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: .2.w, color: kColorlightBlue),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                ),
                                value: controller.selectedAction.value.isEmpty
                                    ? null
                                    : controller.selectedAction.value,
                                items: controller.actionList
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedAction.value = value;
                                    controller.addTimeline(value);
                                  }
                                },
                              )),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: IconButton(
                            icon: Icon(Icons.add_circle,
                                color: kColorlightBlue, size: 25.sp),
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: const Text(" Add Custom Event"),
                                  content: TextField(
                                    controller: controller.textController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter event name",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kColorlightBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.w),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (controller.textController.text
                                            .trim()
                                            .isNotEmpty) {
                                          controller.addTimeline(controller
                                              .textController.text
                                              .trim());
                                          Get.back();
                                        }
                                      },
                                      child: const Text("Add"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 1.h),

                    Flexible(
                      child: Obx(() => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListView.builder(
                              itemCount: controller.taskTimeline.length,
                              itemBuilder: (context, index) {
                                final isLast =
                                    index == controller.taskTimeline.length - 1;
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.w),
                                          child: Container(
                                            width: 14.sp,
                                            height: 14.sp,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: isLast
                                                    ? Colors.blue
                                                    : Colors.green,
                                                width: 2,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        if (!isLast)
                                          Container(
                                            width: 2,
                                            height: 5.h,
                                            color: Colors.grey.shade400,
                                          ),
                                      ],
                                    ),
                                    const SizedBox(width: 8),

                                    /// Event Text
                                    Expanded(
                                      child: Container(
                                        // height: 6.h,
                                        decoration: BoxDecoration(
                                          color: isLast
                                              ? Colors.blue.shade50
                                              : Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller.taskTimeline[index],
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: isLast
                                                      ? FontWeight.bold
                                                      : FontWeight.w500,
                                                  color: isLast
                                                      ? Colors.blue
                                                      : Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "Description of event in detail",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: isLast
                                                      ? Colors.blue
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
