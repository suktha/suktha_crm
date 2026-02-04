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
          color: kColorblack,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        backgroundColor: kColorwhite,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kColorblack,
            size: 17.5.sp,
          ),
          onPressed: () {
            Get.to(
              () => BottomNavigationMainscreen(initialIndex: 1),
              transition: Transition.rightToLeft,
            );
            if (!controller.isClockedIn.value) {
              controller.taskTimeline.clear();
              controller.textController.clear();
              controller.selectedAction.value = "";
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => ElevatedButton(
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
                      "error",
                    );
                  }
                },
                child: Text(
                  "End Task",
                  style: TextStyle(
                    color:
                        controller.isClockedIn.value ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.currentLocation.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            /// ================= GOOGLE MAP SECTION =================
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value!,
                zoom: 15,
              ),
              markers: controller.markers.value,
              polylines: controller.polylines.value,
              onMapCreated: (map) => controller.mapController = map,
              zoomControlsEnabled: false,
            ),

            /// ================= DRAGGABLE DETAILS + TIMELINE =================
            DraggableScrollableSheet(
              initialChildSize: 0.35,
              minChildSize: 0.2,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Container(
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
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Drag handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        /// Header Section
                        SizedBox(height: 2.w),
                        Text(
                          "Kavya went meeting",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          "XYZ technolgies Private Ltd",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 1.w),
                        Text(
                          "Client Review and Feedback",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 2.h),

                        /// Dropdown + Add Event Button
                        Row(
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.add, size: 20),
                              label: const Text("Add Custom Event",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              onPressed: () {
                                Get.dialog(
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    title: const Text("Add Custom Event"),
                                    content: Container(
                                      height: 20.h,
                                      child: Column(
                                        children: [
                                          Obx(
                                            () =>
                                                DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                labelText: "Select Event",
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: .2.w,
                                                    color: kColorlightBlue,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: .2.w,
                                                    color: kColorlightBlue,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                ),
                                              ),
                                              value: controller.selectedAction
                                                      .value.isEmpty
                                                  ? null
                                                  : controller
                                                      .selectedAction.value,
                                              items: controller.textController
                                                      .text.isEmpty
                                                  ? controller.actionList
                                                      .map(
                                                        (item) =>
                                                            DropdownMenuItem(
                                                          value: item,
                                                          child: Text(item),
                                                        ),
                                                      )
                                                      .toList()
                                                  : [],
                                              onChanged: (value) {
                                                if (value != null) {
                                                  controller.selectedAction
                                                      .value = value;

                                                  // controller.textController.text =
                                                  //     value;
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.w,
                                          ),
                                          TextField(
                                            controller:
                                                controller.textController,
                                            decoration: const InputDecoration(
                                              hintText: "Custom event ",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.w,
                                          ),
                                          TextField(
                                            controller: controller
                                                .descriptionController,
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Description (optional)",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                          controller.textController.clear();
                                          controller.descriptionController
                                              .clear();
                                          controller.selectedAction.value = "";
                                        },
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
                                            controller.addTimeline(
                                              controller.textController.text
                                                  .trim(),
                                            );
                                            Get.back();
                                            controller.textController.clear();
                                            controller.descriptionController
                                                .clear();
                                            controller.selectedAction.value =
                                                "";
                                          } else if (controller.selectedAction
                                              .value.isNotEmpty) {
                                            controller.addTimeline(
                                              controller.selectedAction.value,
                                            );
                                            Get.back();
                                            controller.textController.clear();
                                            controller.descriptionController
                                                .clear();
                                            controller.selectedAction.value =
                                                "";
                                          } else {
                                            customSnackbar(
                                                "Error",
                                                "Please select/enter event name",
                                                "error");
                                          }
                                        },
                                        child: const Text("Add"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        // SizedBox(height: 2.h),

                        /// TIMELINE LIST
                        Obx(
                          () => ListView.builder(
                            itemCount: controller.taskTimeline.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
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
                                        padding: EdgeInsets.only(
                                            top: 10.w, left: 2.w),
                                        child: Column(
                                          children: [
                                            // Top Icon Circle
                                            Container(
                                              width: 30, // increased size
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: isLast
                                                      ? [
                                                          Colors.blue.shade400,
                                                          Colors.blue.shade700
                                                        ]
                                                      : [
                                                          Colors.green.shade200,
                                                          Colors.green.shade400
                                                        ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.15),
                                                    blurRadius: 6,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                isLast
                                                    ? Icons.check_circle_rounded
                                                    : Icons
                                                        .timelapse_rounded, // change icon based on event
                                                color: Colors.white,
                                                size: 20.sp,
                                              ),
                                            ),
                                            // Line connecting to next timeline
                                            if (!isLast)
                                              Container(
                                                width: 3, // slightly thicker
                                                height: 6.h, // longer connector
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.grey.shade400,
                                                      Colors.grey.shade300,
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: isLast
                                              ? [
                                                  Colors.blue.shade50,
                                                  Colors.blue.shade100
                                                      .withOpacity(0.3)
                                                ]
                                              : [
                                                  Colors.grey.shade100,
                                                  Colors.grey.shade200
                                                ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Leading Icon

                                            SizedBox(width: 10.sp),

                                            // Event Info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    controller
                                                        .taskTimeline[index],
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: isLast
                                                          ? FontWeight.bold
                                                          : FontWeight.w600,
                                                      color: isLast
                                                          ? Colors.blue[800]
                                                          : Colors.black87,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 70.w,
                                                        child: Text(
                                                          "Description of event in detail — includes notes or remarks about the task.",
                                                          style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color: Colors
                                                                .grey[700],
                                                            height: 1.3,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(height: 6),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.access_time,
                                                          size: 17.sp,
                                                          color:
                                                              Colors.grey[600]),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        "10:32 AM",
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      TextButton.icon(
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.blue[700],
                                                          padding:
                                                              EdgeInsets.zero,
                                                          minimumSize:
                                                              const Size(0, 0),
                                                        ),
                                                        onPressed: () {
                                                          // view location tap logic here
                                                        },
                                                        icon: const Icon(
                                                            Icons.location_pin,
                                                            size: 15),
                                                        label: const Text(
                                                            "View Location ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    heroTag: "zoom_in",
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      final zoomLevel =
                          await controller.mapController!.getZoomLevel();
                      controller.mapController!.animateCamera(
                        CameraUpdate.zoomTo(zoomLevel + 1),
                      );
                    },
                    child: const Icon(Icons.add, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    heroTag: "zoom_out",
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      final zoomLevel =
                          await controller.mapController!.getZoomLevel();
                      controller.mapController?.animateCamera(
                        CameraUpdate.zoomTo(zoomLevel - 1),
                      );
                    },
                    child: const Icon(Icons.remove, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
