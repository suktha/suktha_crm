// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/controllers/settings_controller.dart';
import 'package:suktha_crm/view/Account%20Settings/widgets/pdfviewScreen.dart';
import 'package:suktha_crm/view/widget/deleteAlertDialogue.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

class DocumentWalletScreen extends StatelessWidget {
  final VoidCallback itemAddButton;
  String documentwallertId;

  final bool isEdit;

  DocumentWalletScreen({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.itemAddButton,
    required this.documentwallertId,
  });

  final SettingsController controller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: itemAddButton,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kColorlightBlue),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Obx(() => Text(
                            "Upload Documents - (${controller.documentWalletList.length}/5)",
                            style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorwhite),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Obx(
                    () => controller.documentWalletList.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 9.h,
                              ),
                              FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: LottieBuilder.asset("assets/lottie/empty.json", height: 15.h),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              FadeIn(
                                delay: const Duration(milliseconds: 500),
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  "Document List is Empty",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                                ),
                              )
                            ],
                          ))
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.documentWalletList.length,
                            itemBuilder: (context, index) {
                              documentwallertId = controller.documentWalletList[index].id.toString();
                              return SwipeActionCell(
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

                                            controller.deleteDocument(payload);

                                            Get.back();
                                            customSnackbar("Delete", "Successfully Deleted", "error");
                                          },
                                        );
                                      },
                                      color: Colors.red),
                                ],
                                child: GestureDetector(
                                  onTap: () {
                                    print("object");
                                    print(controller.documentWalletList[index].fileURL!);
                                    Get.to(PDFScreen(
                                      url: controller.documentWalletList[index].fileURL!,
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade100),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(height: 60, width: 40, child: Image.asset("assets/Images/pdf.png")),
                                          SizedBox(
                                              width: 70.w,
                                              child: Text(
                                                controller.documentWalletList[index].name!,
                                                style: TextStyle(fontSize: 17),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
