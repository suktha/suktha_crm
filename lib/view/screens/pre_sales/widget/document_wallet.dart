import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/controllers/get_lead_controller.dart';
import 'package:suktha_crm/view/widget/deleteAlertDialogue.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

class LeadDocumentWalletScreen extends StatelessWidget {
  LeadDocumentWalletScreen({super.key, required this.controller, required this.leadValue});

  final GetLeadController controller;
  final LeadModel leadValue;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        controller.multiSelectMode.value = false;
        controller.isSelectedDocuments.fillRange(0, controller.isSelectedDocuments.length, false);
      },
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(color: kColorwhite, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Document-Lists",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Spacer(),
                    Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(100), color: kColorlightBlue),
                        child: IconButton(
                            onPressed: () {
                              controller.multiSelectMode.value = false;
                              controller.isSelectedDocuments.fillRange(0, controller.isSelectedDocuments.length, false);

                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              color: kColorwhite,
                              size: 18,
                            )))
                  ],
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  () => controller.isDocUploaded.value == true
                      ? Expanded(
                          flex: 15,
                          child: ListView.builder(
                            itemCount: controller.documentWalletList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var walletItem = controller.documentWalletList[index];
                              return FadeInRightBig(
                                duration: Duration(milliseconds: 500), // Set the duration of each animation
                                delay: Duration(milliseconds: index * 100),
                                child: Obx(() => SwipeActionCell(
                                      key: UniqueKey(),
                                      trailingActions: <SwipeAction>[
                                        SwipeAction(
                                            performsFirstActionWithFullSwipe: false,
                                            backgroundRadius: 6.w,
                                            widthSpace: 20.w,
                                            title: "Delete",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
                                            onTap: (CompletionHandler handler) async {
                                              customDeleteAlertDialogue(
                                                context,
                                                () async {
                                                  List<String> payload = [controller.documentWalletList[index].name.toString()];

                                                  controller.deleteDocument(payload, leadValue.id!);

                                                  Get.back();
                                                  customSnackbar("Delete", "Successfully Deleted", "error");
                                                },
                                              );
                                            },
                                            color: Colors.red),
                                      ],
                                      child: GestureDetector(
                                        onLongPress: () {
                                          controller.multiSelectMode.value = true;
                                          controller.isSelectedDocuments[index] = !controller.isSelectedDocuments[index];
                                          controller.multiSelectMode.value = controller.isSelectedDocuments.contains(true);
                                          HapticFeedback.vibrate();
                                        },
                                        onTap: () {
                                          if (controller.multiSelectMode.value) {
                                            controller.isSelectedDocuments[index] = !controller.isSelectedDocuments[index];
                                            controller.multiSelectMode.value = controller.isSelectedDocuments.contains(true);
                                          } else {
                                            // Get.to(PDFScreen(
                                            //   url: controller.documentWalletList[index].fileURL!,
                                            // ));
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 1.h),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: controller.isSelectedDocuments[index] ? kColorLightBlueAppBar : kColorLightGrey,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(height: 60, width: 40, child: Image.asset("assets/Images/pdf.png")),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                SizedBox(
                                                    width: 60.w,
                                                    child: Text(
                                                      walletItem.name ?? "",
                                                      style: TextStyle(fontSize: 17),
                                                    )),
                                                Spacer(),
                                                if (controller.multiSelectMode.value)
                                                  Checkbox(
                                                    value: controller.isSelectedDocuments[index],
                                                    onChanged: (bool? value) {
                                                      controller.isSelectedDocuments[index] = value!;
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                        )
                      : SizedBox(),
                ),
                Spacer(),
                Obx(
                  () => controller.multiSelectMode.value
                      ? InkWell(
                          onTap: () async {
                            customDeleteAlertDialogue(
                              context,
                              () async {
                                List<String> payload = controller.documentWalletList
                                    .asMap()
                                    .entries
                                    .where((entry) => controller.isSelectedDocuments[entry.key])
                                    .map((entry) => entry.value)
                                    .toList()
                                    .map((doc) => doc.name!)
                                    .toList();

                                controller.deleteDocument(payload, leadValue.id!);

                                Get.back();
                                customSnackbar("Delete", "Successfully Deleted", "error");

                                controller.multiSelectMode.value = false;
                                controller.isSelectedDocuments.fillRange(0, controller.isSelectedDocuments.length, false);
                              },
                            );
                          },
                          child: Center(
                            child: Container(
                              width: 50.w,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kColorRed),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Obx(() => Text(
                                      "Delete - (${controller.selectedItemCount}/${controller.documentWalletList.length})",
                                      style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorwhite),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            if (controller.documentWalletList.length >= 5) {
                              customSnackbar("Error", "You cannot upload more than 5 files", "error");
                            } else {
                              var file = await controller.pickFile(type: FileType.custom);
                              if (file != null) {
                                final fileSizeInBytes = File(file.path).lengthSync();
                                final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

                                if (fileSizeInMB > 1) {
                                  customSnackbar("Error", "File size cannot exceed 1MB", "error");
                                } else {
                                  await controller.uploadDocumentWalletPdf(file, leadValue.id!);
                                }
                              }
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kColorlightBlue),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Obx(() => Text(
                                    "Upload Documents - (${controller.documentWalletList.length}/5)",
                                    style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorwhite),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        ),
                )
              ],
            )),
      ),
    );
  }
}
