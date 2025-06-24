
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/get_party_master_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/material_list_custom_widgets.dart';

class TermsAndCondition extends StatefulWidget {
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;
  List<TermsAndConditions>? termsAndConditionList;
  final bool isEdit;

  TermsAndCondition({
    super.key,
    required this.controller,
    required this.isEdit,
    this.termsAndConditionList,
    required this.expenseHeaderfield,
    required this.itemAddButton,
  });

  final PartyMasterController controller;

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 4, child: widget.expenseHeaderfield),
              Expanded(
                child: GestureDetector(
                  onTap: widget.itemAddButton,
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
              child: widget.controller.termsNdconditionItem.isEmpty
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
                              "Terms and condition List is Empty",
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
                      itemCount: widget.controller.termsNdconditionItem.length,
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
                                      widget.controller.termsNdconditionItem
                                          .removeAt(index);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: MaterialListCustom(
                            amount: "",
                            name: widget.controller.transcationItem
                                    .firstWhere((element) =>
                                        element.id ==
                                        widget
                                            .controller
                                            .termsNdconditionItem[index]
                                            .transactionTypeId)
                                    .name ??
                                "",
                            quantity: widget
                                .controller.termsNdconditionItem[index].name
                                .toString(),
                            onlongpress: () {
                              customDeleteAlertDialogue(
                                context,
                                () {
                                  widget.controller.termsNdconditionItem
                                      .removeAt(index);
                                  Get.back();
                                },
                              );
                            },
                            ontap: () {
                              widget.controller.NametermsNdConditionController
                                  .text = widget.controller
                                      .termsNdconditionItem[index].name ??
                                  "";
                              widget.controller.termsNdConditionController
                                  .text = widget
                                      .controller
                                      .termsNdconditionItem[index]
                                      .termsAndCondition ??
                                  "";
                              // controller.transcationTypeController.text = controller.termsNdconditionItem[index].branch ?? "";
                              widget.controller.transcationTypeController.text =
                                  widget.controller.transcationItem
                                          .firstWhere((element) =>
                                              element.id ==
                                              widget
                                                  .controller
                                                  .termsNdconditionItem[index]
                                                  .transactionTypeId)
                                          .name ??
                                      "";

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Form(
                                    key: formKey,
                                    child: CustomPopup(
                                        title: 'Bank Details',
                                        onCancelPressed: () {
                                          Get.back();
                                          widget.controller
                                              .NametermsNdConditionController
                                              .clear();
                                          widget.controller
                                              .termsNdConditionController
                                              .clear();
                                          widget.controller
                                              .transcationTypeController
                                              .clear();
                                        },
                                        onUpdatePressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            widget
                                                .controller
                                                .termsNdconditionItem[index]
                                                .name = widget
                                                    .controller
                                                    .NametermsNdConditionController
                                                    .text
                                                    .isEmpty
                                                ? ""
                                                : widget
                                                    .controller
                                                    .NametermsNdConditionController
                                                    .text;
                                            widget
                                                    .controller
                                                    .termsNdconditionItem[index]
                                                    .termsAndCondition =
                                                widget
                                                    .controller
                                                    .termsNdConditionController
                                                    .text;

                                            widget
                                                .controller.termsNdconditionItem
                                                .refresh();

                                            Get.back();
                                            widget.controller
                                                .NametermsNdConditionController
                                                .clear();
                                            widget.controller
                                                .termsNdConditionController
                                                .clear();
                                            widget.controller
                                                .transcationTypeController
                                                .clear();
                                          } else {}
                                        },
                                        saveButtonText: "Save",
                                        children: [
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter transaction type";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: widget.controller
                                                  .transcationTypeController,
                                              label: "Transaction Type"),
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Name";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: widget.controller
                                                  .NametermsNdConditionController,
                                              label: "Name"),
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Terms & Condition";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: widget.controller
                                                  .termsNdConditionController,
                                              label: "Terms & Condition"),
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
          )
        ],
      ),
    );
  }
}
