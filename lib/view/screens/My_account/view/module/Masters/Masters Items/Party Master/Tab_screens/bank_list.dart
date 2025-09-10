import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/company_profile_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/Party%20Master/Add%20Party%20Master/party_master_save.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

class BuildBankList extends StatelessWidget {
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;
  List<PartyBankMapDTOList>? bankList;
  final bool isEdit;

  BuildBankList({
    super.key,
    required this.controller,
    required this.isEdit,
    this.bankList,
    required this.expenseHeaderfield,
    required this.itemAddButton,
  });

  final PartyMasterController controller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 6, child: expenseHeaderfield),
              Expanded(
                child: GestureDetector(
                  onTap: itemAddButton,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[3]),
                    child: CircleAvatar(
                      radius: 2.4.h,
                      backgroundColor: kColorlightBlue,
                      child: Icon(
                        Icons.add,
                        size: 22.sp,
                        color: kColorwhite,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => Expanded(
              child: controller.materialBankItem.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 6.h,
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
                              "Bank List is Empty",
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
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Divider(
                          thickness: 1,
                          color: kColorgrey,
                        ),
                      )),
                      shrinkWrap: true,
                      itemCount: controller.materialBankItem.length,
                      itemBuilder: (context, index) {
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
                                      controller.materialBankItem
                                          .removeAt(index);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: ListTile(
                              trailing: controller
                                          .materialBankItem[index].isChecked ==
                                      1
                                  ? const Text(
                                      "Default",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text(""),
                              title: Text(
                                  controller.materialBankItem[index].bankname ??
                                      ""),
                              subtitle: Text(
                                  controller.materialBankItem[index].ifsc ??
                                      ""),
                              onLongPress: () {
                                customDeleteAlertDialogue(
                                  context,
                                  () {
                                    controller.materialBankItem.removeAt(index);
                                    Get.back();
                                  },
                                );
                              },
                              onTap: () {
                                controller.bankNameController.text = controller
                                        .materialBankItem[index].bankname ??
                                    "";
                                controller.ifscController.text =
                                    controller.materialBankItem[index].ifsc ??
                                        "";
                                controller.branchController.text =
                                    controller.materialBankItem[index].branch ??
                                        "";
                                controller.aCController.text = controller
                                        .materialBankItem[index]
                                        .accountNumber ??
                                    "";
                                controller.openingBalanceController.text =
                                    controller.materialBankItem[index]
                                            .openingBalance
                                            ?.toString() ??
                                        "";
                                controller.isDefault.value = controller
                                            .materialBankItem[index]
                                            .isChecked ==
                                        1
                                    ? true
                                    : false;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Form(
                                      key: formKey,
                                      child: CustomPopup(
                                          title: 'Bank Details',
                                          onCancelPressed: () {
                                            Get.back();
                                            controller.aCController.clear();
                                            controller.ifscController.clear();
                                            controller.openingBalanceController
                                                .clear();
                                            controller.branchController.clear();
                                            controller.bankNameController
                                                .clear();
                                            controller.isDefault.value = false;
                                          },
                                          onUpdatePressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              controller.materialBankItem[index]
                                                  .accountNumber = controller
                                                      .aCController.text.isEmpty
                                                  ? ""
                                                  : controller
                                                      .aCController.text;
                                              controller.materialBankItem[index]
                                                      .ifsc =
                                                  controller
                                                      .ifscController.text;
                                              controller.materialBankItem[index]
                                                  .openingBalance = controller
                                                      .openingBalanceController
                                                      .text
                                                      .isNotEmpty
                                                  ? double.tryParse(controller
                                                      .openingBalanceController
                                                      .text)
                                                  : 0.0;
                                              controller.materialBankItem[index]
                                                      .branch =
                                                  controller
                                                      .branchController.text;
                                              controller.materialBankItem[index]
                                                      .isChecked =
                                                  controller.isDefault.value ==
                                                          true
                                                      ? 1
                                                      : 0;

                                              controller.materialBankItem
                                                  .refresh();

                                              Get.back();
                                              controller.aCController.clear();
                                              controller.ifscController.clear();
                                              controller
                                                  .openingBalanceController
                                                  .clear();
                                              controller.branchController
                                                  .clear();
                                              controller.bankNameController
                                                  .clear();
                                              controller.isDefault.value =
                                                  false;
                                            } else {}
                                          },
                                          saveButtonText: "Save",
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow:
                                                      kElevationToShadow[2],
                                                  color: kColorwhite),
                                              child: switchCustom(
                                                Obx(() => Switch(
                                                      value: controller
                                                          .isDefault.value,
                                                      onChanged: (value) {
                                                        controller.isDefault
                                                            .value = value;
                                                      },
                                                    )),
                                                "Is Default",
                                              ),
                                            ),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter bankname";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller: controller
                                                    .bankNameController,
                                                label: "Bank"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter branch";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller:
                                                    controller.branchController,
                                                label: "Branch "),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter IFSC CODE";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller:
                                                    controller.ifscController,
                                                label: "IFSC Code "),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter A/C Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller:
                                                    controller.aCController,
                                                label: "A/C Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Balance";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller: controller
                                                    .openingBalanceController,
                                                label: "Opening Balance")
                                          ]),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
