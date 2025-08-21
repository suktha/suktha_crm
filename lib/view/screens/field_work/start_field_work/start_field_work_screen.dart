import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/screens/field_work/controller/checkInOut_controller.dart';

class TaskMapScreen extends StatefulWidget {
  const TaskMapScreen({super.key});

  @override
  State<TaskMapScreen> createState() => _TaskMapScreenState();
}

class _TaskMapScreenState extends State<TaskMapScreen> {
  final CheckInOutController controller = Get.find<CheckInOutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          },
        ),
        actions: [
          TextButton(
            onPressed: controller.endTask,
            child: const Text("End Task",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body:Obx(() {
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
                onMapCreated: (mapCtrl) => controller.mapController = mapCtrl,
              ),
            ),
             Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2.w),
                    Text("Company: XYZ Pvt Ltd",
                        style: TextStyle(fontSize: 15.sp, color: Colors.grey[700])),
                    Text("Title: Client Discussion",
                        style: TextStyle(fontSize: 15.sp, color: Colors.grey[700])),

                    SizedBox(height: 2.h),

                    /// Timeline
                    Flexible(
                      child: Obx(() => Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: ListView.builder(
                              itemCount: controller.taskTimeline.length,
                              itemBuilder: (context, index) {
                                final isLast = index == controller.taskTimeline.length - 1;
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Dots + Line
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 12.sp,
                                          height: 12.sp,
                                          decoration: BoxDecoration(
                                            color: isLast ? Colors.blue : Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        if (!isLast)
                                          Container(
                                            width: 2,
                                            height: 30,
                                            color: Colors.grey.shade400,
                                          ),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    /// Event Text
                                    Expanded(
                                      child: Text(
                                        controller.taskTimeline[index],
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: isLast ? FontWeight.bold : FontWeight.w500,
                                          color: isLast ? Colors.blue : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                      )),
                    ),

                    /// Actions
                     /// Dropdown + Add
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "Select Event",
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.w)),
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
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: kColorlightBlue, size: 25.sp),
                          onPressed: () {
                            final textController = TextEditingController();
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: const Text("Add Custom Event"),
                                content: TextField(
                                  controller: textController,
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
                                    onPressed: () {
                                      if (textController.text.trim().isNotEmpty) {
                                        controller.addTimeline(textController.text.trim());
                                        Get.back();
                                      }
                                    },
                                    child: const Text("Add"),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    )
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
