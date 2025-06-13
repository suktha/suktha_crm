// ignore_for_file: sort_child_properties_last, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class BankListScreen extends StatefulWidget {
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;

  final bool isEdit;

 const BankListScreen({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.expenseHeaderfield,
    required this.itemAddButton,
  });

  final SettingsController controller;

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.controller.getPartyBankDetails();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
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
                    print("ontroller.isalreadyDefault.value${widget.controller.isalreadyDefault.value}");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomPopup(
                            children: [
                              SizedBox(
                                height: 1.5.h,
                              ),
                              widget.expenseHeaderfield
                            ],
                            title: "Add Bank List",
                            onCancelPressed: () {
                              Get.back();

                              widget.controller.bankNameController.clear();
                              widget.controller.branchController.clear();
                              widget.controller.ifscController.clear();
                              widget.controller.aCController.clear();
                              widget.controller.bankADCode.clear();
                              widget.controller.swiftCode.clear();
                              widget.controller.isDefault.value = false;
                            },
                            onUpdatePressed: widget.itemAddButton,
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
              () => widget.controller.partyBankList.isEmpty
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
                          const Duration(seconds: 1),
                          () {
                            widget.controller.partyBankList.clear();
                            widget.controller.getPartyBankDetails();
                          },
                        );
                      },
                      child: ListView.separated(
                        physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        separatorBuilder: (context, index) => SizedBox(
                            child: Divider(
                          thickness: 1,
                          color: kColorgrey,
                        )),
                        itemCount: widget.controller.partyBankList.length,
                        itemBuilder: (context, index) {
                          widget.controller.isalreadyDefault.value = widget.controller.partyBankList[index].isChecked ?? 0;
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
                                        widget.controller.partyBankList.removeAt(index);
                                        Get.back();
                                      },
                                    );
                                  },
                                  color: Colors.red),
                            ],
                            child: ListTile(
                              trailing: widget.controller.partyBankList[index].isChecked == 1
                                  ? const Text(
                                      "Default",
                                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                    )
                                  :const Text(""),
                              title: Text(widget.controller.partyBankList[index].bankname ?? ""),
                              subtitle: Text(widget.controller.partyBankList[index].ifsc ?? ""),
                              onLongPress: () {
                                customDeleteAlertDialogue(
                                  context,
                                  () {
                                    widget.controller.partyBankList.removeAt(index);
                                    Get.back();
                                  },
                                );
                              },
                              onTap: () {
                                print('clicked---');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    widget.controller.bankNameController.text = widget.controller.partyBankList[index].bankname ?? "";
                                    widget.controller.ifscController.text = widget.controller.partyBankList[index].ifsc ?? "";
                                    widget.controller.branchController.text = widget.controller.partyBankList[index].branch ?? "";
                                    widget.controller.aCController.text = widget.controller.partyBankList[index].accountNumber ?? "";
                                    widget.controller.bankADCode.text = widget.controller.partyBankList[index].bankAdCode?.toString() ?? "";
                                    widget.controller.swiftCode.text = widget.controller.partyBankList[index].swiftCode?.toString() ?? "";
                                    widget.controller.isDefault.value = widget.controller.partyBankList[index].isChecked == 1 ? true : false;

                                    return Form(
                                      key: formKey,
                                      child: CustomPopup(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: kElevationToShadow[2], color: kColorwhite),
                                              child: switchCustom(
                                                Obx(() => Switch(
                                                      value: widget.controller.isDefault.value,
                                                      onChanged: (value) {
                                                        if (value) {
                                                          widget.controller.isDefault.value = value;
                                                          for (var i = 0; i < widget.controller.partyBankList.length; i++) {
                                                            if (i != index) {
                                                              widget.controller.partyBankList[i].isChecked = 0;
                                                            }
                                                          }
                                                          widget.controller.partyBankList[index].isChecked = 1;
                                                        } else {
                                                          widget.controller.partyBankList[index].isChecked = 0;
                                                          widget.controller.isDefault.value = false;
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
                                                controller: widget.controller.bankNameController,
                                                label: "Bank"),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                maxLength: 100,
                                                controller: widget.controller.branchController,
                                                label: "Branch "),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                maxLength: 15,
                                                controller: widget.controller.ifscController,
                                                label: "IFSC Code "),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                controller: widget.controller.aCController,
                                                label: "A/C Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                maxLength: 30,
                                                textInputAction: TextInputAction.next,
                                                textInputType: TextInputType.number,
                                                obscure: false,
                                                controller: widget.controller.bankADCode,
                                                label: "Bank AD Code"),
                                            CustomTextField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                maxLength: 20,
                                                textInputType: TextInputType.number,
                                                controller: widget.controller.swiftCode,
                                                label: "Swift Code")
                                          ],
                                          title: 'Bank Details',
                                          onCancelPressed: () {
                                            Get.back();
                                            widget.controller.aCController.clear();
                                            widget.controller.ifscController.clear();
                                            widget.controller.bankADCode.clear();
                                            widget.controller.swiftCode.clear();
                                            widget.controller.branchController.clear();
                                            widget.controller.bankNameController.clear();
                                          },
                                          onUpdatePressed: () async {
                                            if (formKey.currentState!.validate()) {
                                              widget.controller.partyBankList[index].accountNumber = widget.controller.aCController.text.isEmpty ? "" : widget.controller.aCController.text;
                                              widget.controller.partyBankList[index].ifsc = widget.controller.ifscController.text;
                                              widget.controller.partyBankList[index].bankAdCode = widget.controller.bankADCode.text.isNotEmpty ? int.parse(widget.controller.bankADCode.text.toString()) : 0;
                                              widget.controller.partyBankList[index].branch = widget.controller.branchController.text;
                                              widget.controller.partyBankList[index].swiftCode = widget.controller.swiftCode.text;
                                              widget.controller.partyBankList[index].isChecked = widget.controller.isDefault.value == true ? 1 : 0;

                                              widget.controller.partyBankList.refresh();

                                              Get.back();
                                              widget.controller.aCController.clear();
                                              widget.controller.ifscController.clear();
                                              widget.controller.bankADCode.clear();
                                              widget.controller.branchController.clear();
                                              widget.controller.bankNameController.clear();
                                              widget.controller.swiftCode.clear();
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
              style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      const  Spacer(),
        switchwidget,
      ],
    );
  }
}
