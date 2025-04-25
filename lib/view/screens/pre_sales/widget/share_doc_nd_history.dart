import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/controllers/get_lead_controller.dart';
import 'package:suktha_crm/utils/Date.dart';
import 'package:suktha_crm/view/widget/custom_button.dart';
import 'package:suktha_crm/view/widget/custom_rounded_textfiled.dart';

class ShareDocNdHistory extends StatelessWidget {
  const ShareDocNdHistory({super.key, required this.controller, required this.leadValue});

  final GetLeadController controller;
  final LeadModel leadValue;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Durations.extralong2,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 1.5.h),
              FadeIn(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Text(
                      "Share Docs / History",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(boxShadow: kElevationToShadow[1], borderRadius: BorderRadius.circular(16)),
                        child: CircleAvatar(
                          radius: 17,
                          child: Icon(
                            Icons.refresh,
                            size: 20,
                            color: kColorwhite,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        controller.isFileAttached.value = false;
                        controller.sharedDocFile = null;
                      },
                      child: Container(
                        decoration: BoxDecoration(boxShadow: kElevationToShadow[1], borderRadius: BorderRadius.circular(16)),
                        child: CircleAvatar(
                          radius: 17,
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: kColorwhite,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(2.w),
                child: Column(
                  children: [
                    Obx(
                      () => !controller.isFileAttached.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LottieBuilder.asset(
                                  width: 50.w,
                                  uploadLottie,
                                ),
                                CustomButton(
                                  title: "Attach",
                                  ontap: () async {
                                    controller.sharedDocFile = await controller.pickFile(type: FileType.any);

                                    controller.sharedDocFile != null ? controller.isFileAttached.value = true : false;

                                    controller.sharedDocName.value = controller.sharedDocFile!.path.split('/').last;
                                    print("Filename: ${controller.sharedDocName.value}");
                                  },
                                  width: 30.w,
                                  color: kColorlightBlue,
                                  textcolor: kColorwhite,
                                )
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.only(bottom: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kColorLightGrey,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(height: 60, width: 40, child: Image.asset(controller.getFileIcon(controller.sharedDocName.value))),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SizedBox(
                                        width: 60.w,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          controller.sharedDocName.value,
                                          style: TextStyle(fontSize: 17),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          controller.isFileAttached.value = false;
                                          controller.sharedDocFile = null;
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 2.h),
                    CustomRoundedTextField(
                      validator: (value) {
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      obscure: false,
                      controller: controller.subjectController,
                      label: "Subject",
                    ),
                    SizedBox(height: 1.h),
                    CustomRoundedTextField(
                      validator: (value) {
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      obscure: false,
                      multilines: 4,
                      controller: controller.contentController,
                      label: "Content",
                    ),
                    SizedBox(height: 1.h),
                    Obx(() => CustomButton(
                          title: "Send Mail",
                          ontap: () async {
                            if (controller.isFileAttached.value) {
                              print(controller.sharedDocFile);
                              await controller.sendLeadMail(controller.sharedDocFile!, leadValue.id!);
                            }
                          },
                          width: 100.w,
                          color: controller.isFileAttached.value ? kColorlightBlue : kColorgrey,
                          textcolor: kColorwhite,
                        )),
                    SizedBox(height: 2.h),
                    Obx(
                      () => controller.sharedDocHistoryList.isNotEmpty
                          ? Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "History",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(height: 1.h),
                    Obx(() => Container(
                          constraints: BoxConstraints(maxHeight: 30.h),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.sharedDocHistoryList.length,
                            itemBuilder: (context, index) {
                              var item = controller.sharedDocHistoryList[index];
                              return ListTile(
                                title: Text(item.documentName ?? "", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp), overflow: TextOverflow.ellipsis),
                                leading: CircleAvatar(radius: 4.5.w, child: Text("${index + 1}")),
                                trailing: Text(DateClass().showDate(item.createdDate)),
                              );
                            },
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
