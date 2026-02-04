import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';

class StatusSection extends StatelessWidget {
  StatusSection({super.key});

  final controller = Get.find<GetLeadController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.analytics_rounded,
                      color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 3.w),
                Text(
                  "Status Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                /// LEFT SIDE
                Expanded(
                  child: Column(
                    children: [
                      _item(
                        "Follow Up Required",
                        controller.followUpRequiredCount,
                        Colors.indigo,
                        Icons.follow_the_signs_rounded,
                        "Follow Up Required",
                      ),
                      SizedBox(height: 2.h),
                      _item(
                        "Converted",
                        controller.convertedCount,
                        Colors.green,
                        Icons.check_circle_rounded,
                        "Converted",
                      ),
                      SizedBox(height: 2.h),
                      _item(
                        "Not Converted",
                        controller.notConvertedCount,
                        Colors.red,
                        Icons.cancel_rounded,
                        "Not Converted",
                      ),
                      SizedBox(height: 2.h),
                      _item(
                        "Interested",
                        controller.interestedCount,
                        Colors.amber,
                        Icons.star_rounded,
                        "Interested",
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 4.w),

                /// RIGHT SIDE
                Expanded(
                  child: SizedBox(
                    height: 25.h,
                    child: Obx(() {
                      final sections = [
                        {
                          "label": "Follow Up",
                          "value": controller.followUpRequiredCount.value,
                          "color": Colors.indigo,
                        },
                        {
                          "label": "Converted",
                          "value": controller.convertedCount.value,
                          "color": Colors.green,
                        },
                        {
                          "label": "Not Converted",
                          "value": controller.notConvertedCount.value,
                          "color": Colors.red,
                        },
                        {
                          "label": "Interested",
                          "value": controller.interestedCount.value,
                          "color": Colors.amber,
                        },
                      ].where((e) => e["value"] as int > 0).toList();

                      if (sections.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/lottie/empty.json",
                              height: 15.w,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "No records found",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        );
                      }

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            PieChartData(
                              centerSpaceRadius: 45,
                              sectionsSpace: 2,
                              sections: sections.map((e) {
                                return PieChartSectionData(
                                  value: (e["value"] as int).toDouble(),
                                  color: e["color"] as Color,
                                  radius: 45,
                                  title: '',
                                );
                              }).toList(),
                              pieTouchData: PieTouchData(
                                touchCallback: (event, response) {
                                  if (response?.touchedSection != null) {
                                    final index = response!
                                        .touchedSection!.touchedSectionIndex;
                                    controller.centerText.value =
                                        "${sections[index]["value"]} ${sections[index]["label"]}";
                                  } else {
                                    controller.centerText.value = '';
                                  }
                                },
                              ),
                            ),
                          ),
                          Obx(() => Text(
                                controller.centerText.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    String label,
    RxInt count,
    Color color,
    IconData icon,
    String status,
  ) {
    return GestureDetector(
      onTap: () {
        controller.selectedStatus.value = status;
        Get.to(() => LeadManagementListScreen(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 600));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Obx(() => Text(
                  count.value.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
