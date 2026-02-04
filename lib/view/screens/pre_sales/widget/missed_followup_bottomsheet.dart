
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';

missedFollowUpBottomSheet(
    {required BuildContext context, required GetLeadController controller}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.w), topRight: Radius.circular(5.w))),
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF5F7FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFfa709a), Color(0xFFfee140)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.warning_amber_rounded,
                        color: Colors.white, size: 20.sp),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    "Missed Follow Up",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 4.5.w,
                          child: const Icon(Icons.close, color: Colors.black87)))
                ],
              ),
            ),
            Obx(() => controller.missedFollowUpList.isEmpty
                ? Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(emptyLottie),
                        SizedBox(height: 3.h),
                        Text(
                          "Your List is Empty",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp),
                        )
                      ],
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.missedFollowUpList.length,
                      itemBuilder: (context, index) {
                        var item = controller.missedFollowUpList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 1.0, top: 8, left: 8, right: 8),
                          child: FadeInRight(
                            duration: const Duration(milliseconds: 500),
                            child: GestureDetector(
                              onTap: () async {
                                controller.isCalledGetAllLeads.value = true;
                                Get.off(
                                    () => LeadManagementListScreen(
                                          missedUpId: item.leadId,
                                        ),
                                    transition: Transition.fade,
                                    duration: const Duration(milliseconds: 600));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFfa709a).withValues(alpha: 0.05),
                                      const Color(0xFFfee140).withValues(alpha: 0.05)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: const Color(0xFFfa709a)
                                          .withValues(alpha: 0.3),
                                      width: 1),
                                ),
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Color(0xFFfa709a),
                                    child:
                                        Icon(Icons.person, color: Colors.white),
                                  ),
                                  title: Text(
                                    item.leadName ?? "",
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(item.phone ?? ""),
                                  trailing: Text(
                                    DateClass().showDate(item.followUpDate),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFfa709a)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ))
          ],
        ),
      );
    },
  );
}
