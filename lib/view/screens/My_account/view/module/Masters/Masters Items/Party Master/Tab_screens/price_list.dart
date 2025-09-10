
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/company_profile_model.dart';
import 'package:work_Force/Model/material_price_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/material_list_custom_widgets.dart';

class buildPriceList extends StatelessWidget {
  final Widget partyTypefield;
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;

  final bool isEdit;
  List<MaterialPriceListDTOList>? priceList;
  PartyBankMapDTOList? bankList;

  buildPriceList({
    super.key,
    required this.controller,
    required this.partyTypefield,
    required this.expenseHeaderfield,
    required this.itemAddButton,
    required this.isEdit,
    this.priceList,
    this.bankList,
  });

  final PartyMasterController controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          partyTypefield,
          Row(
            children: [
              Expanded(flex: 5, child: expenseHeaderfield),
              Expanded(
                child: GestureDetector(
                  onTap: itemAddButton,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[3]),
                    child: CircleAvatar(
                      radius: 2.4.h,
                      backgroundColor: const Color.fromARGB(255, 248, 235, 234),
                      child: Icon(
                        Icons.add,
                        size: 22.sp,
                        color: kColorblack,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => Expanded(
              child: controller.materialPriceItem.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              "Price List is Empty",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.sp),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                          child: Divider(
                        thickness: 1,
                        color: kColorgrey,
                      )),
                      shrinkWrap: true,
                      itemCount: controller.materialPriceItem.length,
                      itemBuilder: (context, indexs) {
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
                                onTap: (CompletionHandler handler) async {
                                  customDeleteAlertDialogue(
                                    context,
                                    () async {
                                      controller.materialPriceItem
                                          .removeAt(indexs);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: MaterialListCustom(
                            amount: "",
                            name: controller
                                    .materialPriceItem[indexs].materialName ??
                                "",
                            quantity: controller.materialPriceItem[indexs]
                                    .materialTypeName ??
                                "",
                            onlongpress: () {
                              customDeleteAlertDialogue(
                                context,
                                () {
                                  controller.materialPriceItem.removeAt(indexs);
                                  Get.back();
                                },
                              );
                            },
                            ontap: () {
                              controller.materialTypePriceController.text =
                                  controller.materialPriceItem[indexs]
                                      .materialTypeName!;
                              controller.materialNamePriceController.text =
                                  controller
                                      .materialPriceItem[indexs].materialName!;
                              controller.sellingPriceController.text =
                                  controller.materialPriceItem[indexs]
                                          .sellingPrice
                                          ?.toString() ??
                                      "";

                              controller.materialNumController.text = controller
                                      .materialPriceItem[indexs].partNumber ??
                                  "0.0";
                              controller.currentSellingPriceController.text =
                                  controller.materialPriceItem[indexs]
                                          .currentSellingPrice
                                          ?.toString() ??
                                      "0.0";
                              controller.commentsController.text = controller
                                      .materialPriceItem[indexs].comment ??
                                  "--";

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Form(
                                    key: formKey,
                                    child: CustomPopup(
                                        title: 'Price Details',
                                        onCancelPressed: () {
                                          Get.back();
                                          controller.sellingPriceController
                                              .clear();
                                          controller.commentsController.clear();
                                        },
                                        onUpdatePressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.materialPriceItem[indexs]
                                                .sellingPrice = controller
                                                    .sellingPriceController
                                                    .text
                                                    .isNotEmpty
                                                ? double.tryParse(controller
                                                    .sellingPriceController
                                                    .text)
                                                : 0.0;
                                            controller.materialPriceItem[indexs]
                                                    .comment =
                                                controller
                                                    .commentsController.text;

                                            controller.materialPriceItem
                                                .refresh();

                                            Get.back();
                                            controller.sellingPriceController
                                                .clear();
                                            controller.commentsController
                                                .clear();
                                            // controller.openingBalanceController.clear();
                                            // controller.branchController.clear();
                                            // controller.bankNameController.clear();
                                          } else {}
                                        },
                                        saveButtonText: "Save",
                                        children: [
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .materialTypePriceController,
                                              label: "MaterialType"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .materialNamePriceController,
                                              label: "Material-Name"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .materialNumController,
                                              label: "Material Number"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .currentSellingPriceController,
                                              label: "Current selling Price"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              textInputType:
                                                  TextInputType.number,
                                              obscure: false,
                                              controller: controller
                                                  .sellingPriceController,
                                              label: "Selling Price"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller:
                                                  controller.commentsController,
                                              label: "Comments")
                                        ]),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
