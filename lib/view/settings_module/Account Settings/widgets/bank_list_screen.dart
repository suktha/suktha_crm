// ignore_for_file: sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/controllers/settings_controller.dart';
import 'package:suktha_crm/view/widget/custom_popup_with_widget.dart';
import 'package:suktha_crm/view/widget/custom_textfield.dart';
import 'package:suktha_crm/view/widget/deleteAlertDialogue.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

class BankListScreen extends StatelessWidget {
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;

  final bool isEdit;

  BankListScreen({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.expenseHeaderfield,
    required this.itemAddButton,
  });

  final SettingsController controller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // Row(
          //   children: [
          //     Expanded(flex: 5, child: expenseHeaderfield),
          //     Expanded(
          //       child: GestureDetector(
          //         onTap: itemAddButton,
          //         child: CircleAvatar(
          //           radius: 2.5.h,
          //           backgroundColor: kColorlightBlue,
          //           child: Icon(
          //             Icons.add,
          //             size: 20.sp,
          //             color: kColorwhite,
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("ontroller.isalreadyDefault.value${controller.isalreadyDefault.value}");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomPopup(
                            children: [
                              SizedBox(
                                height: 1.5.h,
                              ),
                              expenseHeaderfield
                            ],
                            title: "Add Bank List",
                            onCancelPressed: () {
                              Get.back();

                              controller.bankNameController.clear();
                              controller.branchController.clear();
                              controller.ifscController.clear();
                              controller.aCController.clear();
                              controller.bankADCode.clear();
                              controller.swiftCode.clear();
                              controller.isDefault.value = false;
                            },
                            onUpdatePressed: itemAddButton,
                            saveButtonText: "Add");
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kColorlightBlue),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Add Bank List",
                        style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorwhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Obx(
              () => controller.partyBankList.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 300), child: LottieBuilder.asset("assets/lottie/empty.json", height: 15.h)),
                        SizedBox(
                          height: 3.h,
                        ),
                        FadeIn(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            "Bank List is Empty",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                          ),
                        )
                      ],
                    ))
                  : RefreshIndicator(
                      onRefresh: () async {
                        return Future.delayed(
                          Duration(seconds: 1),
                          () {
                            controller.partyBankList.clear();
                            controller.getPartyBankDetails();
                          },
                        );
                      },
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        separatorBuilder: (context, index) => SizedBox(
                            child: Divider(
                          thickness: 1,
                          color: kColorgrey,
                        )),
                        itemCount: controller.partyBankList.length,
                        itemBuilder: (context, index) {
                          controller.isalreadyDefault.value = controller.partyBankList[index].isChecked ?? 0;
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
                                        controller.partyBankList.removeAt(index);
                                        Get.back();
                                      },
                                    );
                                  },
                                  color: Colors.red),
                            ],
                            child: ListTile(
                              trailing: controller.partyBankList[index].isChecked == 1
                                  ? Text(
                                      "Default",
                                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                    )
                                  : Text(""),
                              title: Text(controller.partyBankList[index].bankname ?? ""),
                              subtitle: Text(controller.partyBankList[index].ifsc ?? ""),
                              onLongPress: () {
                                customDeleteAlertDialogue(
                                  context,
                                  () {
                                    controller.partyBankList.removeAt(index);
                                    Get.back();
                                  },
                                );
                              },
                              onTap: () {
                                print('clicked---');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    controller.bankNameController.text = controller.partyBankList[index].bankname ?? "";
                                    controller.ifscController.text = controller.partyBankList[index].ifsc ?? "";
                                    controller.branchController.text = controller.partyBankList[index].branch ?? "";
                                    controller.aCController.text = controller.partyBankList[index].accountNumber ?? "";
                                    controller.bankADCode.text = controller.partyBankList[index].bankAdCode?.toString() ?? "";
                                    controller.swiftCode.text = controller.partyBankList[index].swiftCode?.toString() ?? "";
                                    controller.isDefault.value = controller.partyBankList[index].isChecked == 1 ? true : false;

                                    return Form(
                                      key: formKey,
                                      child: CustomPopup(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: kElevationToShadow[2], color: kColorwhite),
                                              child: switchCustom(
                                                Obx(() => Switch(
                                                      value: controller.isDefault.value,
                                                      onChanged: (value) {
                                                        if (value) {
                                                          controller.isDefault.value = value;
                                                          for (var i = 0; i < controller.partyBankList.length; i++) {
                                                            if (i != index) {
                                                              controller.partyBankList[i].isChecked = 0;
                                                            }
                                                          }
                                                          controller.partyBankList[index].isChecked = 1;
                                                        } else {
                                                          controller.partyBankList[index].isChecked = 0;
                                                          controller.isDefault.value = false;
                                                        }
                                                      },
                                                    )),
                                                "Is Default",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter bankname";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                readonly: true,
                                                maxLength: 100,
                                                controller: controller.bankNameController,
                                                label: "Bank"),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                maxLength: 100,
                                                controller: controller.branchController,
                                                label: "Branch "),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                maxLength: 15,
                                                controller: controller.ifscController,
                                                label: "IFSC Code "),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                controller: controller.aCController,
                                                label: "A/C Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                maxLength: 30,
                                                textInputAction: TextInputAction.next,
                                                textInputType: TextInputType.number,
                                                obscure: false,
                                                controller: controller.bankADCode,
                                                label: "Bank AD Code"),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                maxLength: 20,
                                                textInputType: TextInputType.number,
                                                controller: controller.swiftCode,
                                                label: "Swift Code")
                                          ],
                                          title: 'Bank Details',
                                          onCancelPressed: () {
                                            Get.back();
                                            controller.aCController.clear();
                                            controller.ifscController.clear();
                                            controller.bankADCode.clear();
                                            controller.swiftCode.clear();
                                            controller.branchController.clear();
                                            controller.bankNameController.clear();
                                          },
                                          onUpdatePressed: () async {
                                            if (formKey.currentState!.validate()) {
                                              controller.partyBankList[index].accountNumber = controller.aCController.text.isEmpty ? "" : controller.aCController.text;
                                              controller.partyBankList[index].ifsc = controller.ifscController.text;
                                              controller.partyBankList[index].bankAdCode = controller.bankADCode.text.isNotEmpty ? int.parse(controller.bankADCode.text.toString()) : 0;
                                              controller.partyBankList[index].branch = controller.branchController.text;
                                              controller.partyBankList[index].swiftCode = controller.swiftCode.text;
                                              controller.partyBankList[index].isChecked = controller.isDefault.value == true ? 1 : 0;

                                              controller.partyBankList.refresh();

                                              Get.back();
                                              controller.aCController.clear();
                                              controller.ifscController.clear();
                                              controller.bankADCode.clear();
                                              controller.branchController.clear();
                                              controller.bankNameController.clear();
                                              controller.swiftCode.clear();
                                            } else {
                                              customSnackbar("Error", "message", "error");
                                            }
                                          },
                                          saveButtonText: "Save"),
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
          ),
        ],
      ),
    );
  }

  Row switchCustom(Widget switchwidget, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            width: 50.w,
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Spacer(),
        switchwidget,
      ],
    );
  }
}
