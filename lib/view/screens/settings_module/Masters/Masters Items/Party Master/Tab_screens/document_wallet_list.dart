
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import 'package:work_Force/view/widget/webview.dart';

class PartyDocumentWalletScreen extends StatelessWidget {
  final VoidCallback itemAddButton;
  String? partyId;

  final bool isEdit;

  PartyDocumentWalletScreen({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.itemAddButton,
    this.partyId,
  });

  final PartyMasterController controller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  controller.documentWalletList.length == 5
                      ? GestureDetector(
                          onTap: () {
                            customSnackbar("Error",
                                "You cannot upload more than 5 files", "error");
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Obx(() => Text(
                                    "Upload Documents - (${controller.documentWalletList.length}/5)",
                                    style: TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      color: kColorblack,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: itemAddButton,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kColorlightBlue),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Obx(() => Text(
                                    "Upload Documents - (${controller.documentWalletList.length}/5)",
                                    style: TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        color: kColorwhite),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Obx(
                      () => controller.documentWalletList.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                FadeIn(
                                    delay: const Duration(milliseconds: 300),
                                    duration: const Duration(milliseconds: 300),
                                    child: LottieBuilder.asset(
                                        "assets/lottie/empty.json",
                                        height: 15.h)),
                                SizedBox(
                                  height: 3.h,
                                ),
                                FadeIn(
                                  delay: const Duration(milliseconds: 500),
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                    "Document List is Empty",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp),
                                  ),
                                )
                              ],
                            ))
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.documentWalletList.length,
                              itemBuilder: (context, index) {
                                controller.documentWalletList[index].id
                                    .toString();

                                return SwipeActionCell(
                                  key: UniqueKey(),
                                  trailingActions: <SwipeAction>[
                                    SwipeAction(
                                        performsFirstActionWithFullSwipe: false,
                                        backgroundRadius: 6.w,
                                        widthSpace: 20.w,
                                        title: "Delete",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kColorwhite),
                                        onTap:
                                            (CompletionHandler handler) async {
                                          customDeleteAlertDialogue(
                                            context,
                                            () async {
                                              List<String> payload = [
                                                controller
                                                    .documentWalletList[index]
                                                    .name
                                                    .toString()
                                              ];

                                              controller.deleteDocument(
                                                  payload, partyId);

                                              Get.back();
                                              customSnackbar(
                                                  "Delete",
                                                  "Successfully Deleted",
                                                  "error");
                                            },
                                          );
                                        },
                                        color: Colors.red),
                                  ],
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => MyWebView(
                                            url: controller
                                                    .documentWalletList[index]
                                                    .fileURL ??
                                                "",
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.grey.shade100),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                height: 60,
                                                width: 40,
                                                child: Image.asset(
                                                    "assets/Images/pdf.png")),
                                            SizedBox(
                                                width: 70.w,
                                                child: Text(
                                                  controller
                                                      .documentWalletList[index]
                                                      .name!,
                                                  style: const TextStyle(
                                                      fontSize: 17),
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
      ),
    );
  }
}
