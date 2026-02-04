import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/open_lead_management.dart';

class FollowUpSection extends StatelessWidget {
  FollowUpSection({super.key});

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
            /// HEADER
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
                  child: Icon(
                    Icons.event_note_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Obx(() {
                    String title = "Today's Follow Up";

                    if (controller.isSelectedyesterday.value) {
                      title = "Yesterday's Follow Up";
                    } else if (controller.isSelectedTomorrow.value) {
                      title = "Tomorrow's Follow Up";
                    } else if (controller.isSelectedNextWeek.value) {
                      title = "Next Week's Follow Up";
                    } else if (controller.isSelectedThisWeek.value) {
                      title = "This Week's Follow Up";
                    } else if (controller.isSelectedLastWeek.value) {
                      title = "Last Week's Follow Up";
                    } else if (controller.isSelectedThisMonth.value) {
                      title = "This Month's Follow Up";
                    } else if (controller.isSelectedCustom.value) {
                      title = "Custom Follow Up";
                    }

                    return Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: Colors.black87,
                      ),
                    );
                  }),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            /// MONTH TEXT
            Obx(() => Text(
                  controller.currentMonth.value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                )),

            SizedBox(height: 2.h),

            /// LIST / EMPTY STATE
            Obx(() {
              if (controller.filteredLeadList.isEmpty) {
                return Center(
                  child: SizedBox(
                    height: 20.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/lottie/empty.json",
                          height: 20.w,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "No Follow Up pending ${controller.dataForSelectedDate.value}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 25.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.filteredLeadList.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredLeadList[index];
                    final amt =
                        item.amount == null ? "0" : item.amount.toString();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2.0, top: 8.0),
                      child: FadeInRight(
                        delay: Duration(milliseconds: 100 + (index * 50)),
                        duration: const Duration(milliseconds: 400),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => OpenLeadManagementScreen(
                                leadValue: item,
                                materialList: controller.materialLists,
                                serviceList: controller.serviceLists,
                                index: index,
                              ),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF667eea).withOpacity(0.05),
                                  const Color(0xFF764ba2).withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(0xFF667eea).withOpacity(0.2),
                              ),
                            ),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xFF667eea),
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text(
                                item.leadName.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                              subtitle: Text(
                                DateClass().showDate(
                                  item.followUpDate.toString(),
                                ),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              trailing: Text(
                                "₹$amt",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: const Color(0xFF667eea),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
