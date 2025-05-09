// ignore_for_file: sort_child_properties_last, prefer_const_constructors, avoid_print

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

class BranchListScreen extends StatefulWidget {
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;
  final bool isEdit;
  final SettingsController controller;

  const BranchListScreen({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.expenseHeaderfield,
    required this.itemAddButton,
  });

  @override
  State<BranchListScreen> createState() => _BranchListScreenState();
}

class _BranchListScreenState extends State<BranchListScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                    print(
                        "ontroller.isalreadyDefault.value${widget.controller.isalreadyDefault.value}");
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
                            title: "Add Branch List",
                            onCancelPressed: () {
                              Get.back();

                              widget.controller.branchAdminController.clear();
                              widget.controller.branchId.value = "";
                              widget.controller.branchController.clear();
                            },
                            onUpdatePressed: widget.itemAddButton,
                            saveButtonText: "Add");
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kColorlightBlue),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Add Branch List",
                        style: TextStyle(
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: kColorwhite),
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
              () => widget.controller.partyBranchItems.isEmpty
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
                            "Branch List is Empty",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15.sp),
                          ),
                        )
                      ],
                    ))
                  : RefreshIndicator(
                      onRefresh: () async {
                        return Future.delayed(
                          Duration(seconds: 1),
                          () {
                            widget.controller.deletedbranchIds.value = [];
                            widget.controller.partyBranchItems.clear();
                            widget.controller.getPartyBankDetails();
                            print(
                                "id-deleted-${widget.controller.deletedbranchIds}");
                          },
                        );
                      },
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        separatorBuilder: (context, index) => SizedBox(
                            child: Divider(
                          thickness: 1,
                          color: kColorgrey,
                        )),
                        itemCount: widget.controller.partyBranchItems.length,
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
                                    print(
                                        "id--${widget.controller.partyBranchItems[index].id}");
                                    customDeleteAlertDialogue(
                                      context,
                                      () async {
                                        final idToDelete = widget.controller
                                            .partyBranchItems[index].id!;
                                        widget.controller.deletedbranchIds
                                            .add(idToDelete);
                                        print(
                                            "deleted branch ids--${widget.controller.deletedbranchIds}");
                                        widget.controller.partyBranchItems
                                            .removeAt(index);
                                        Get.back();
                                      },
                                    );
                                  },
                                  color: Colors.red),
                            ],
                            child: ListTile(
                              title: Text(widget.controller
                                      .partyBranchItems[index].name ??
                                  ""),
                              subtitle: Text(widget.controller
                                      .partyBranchItems[index].branchAdminName
                                      ?.toString() ??
                                  ""),
                              onLongPress: () {
                                customDeleteAlertDialogue(
                                  context,
                                  () {
                                    final idToDelete = widget
                                        .controller.partyBranchItems[index].id!;
                                    widget.controller.deletedbranchIds
                                        .add(idToDelete);
                                    print(
                                        "deleted branch ids--${widget.controller.deletedbranchIds}");
                                    widget.controller.partyBranchItems
                                        .removeAt(index);
                                    Get.back();
                                  },
                                );
                              },
                              onTap: () {
                                print('clicked---');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    widget.controller.branchAdminController
                                        .text = widget
                                            .controller
                                            .partyBranchItems[index]
                                            .branchAdminName ??
                                        "";
                                    widget.controller.branchController.text =
                                        widget.controller
                                                .partyBranchItems[index].name ??
                                            "";

                                    widget.controller.branchId.value = widget
                                            .controller
                                            .partyBranchItems[index]
                                            .branchAdminName ??
                                        "";

                                    return Form(
                                      key: formKey,
                                      child: CustomPopup(
                                          children: [
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5),
                                              child: Container(
                                                  // margin: EdgeInsets.all(2.w),
                                                  height: 7.h,
                                                  // width: 30.w,
                                                  child: DropdownButton(
                                                    isExpanded: true,
                                                    underline: Divider(
                                                      color: Color.fromARGB(
                                                          255, 220, 220, 220),
                                                      thickness: 1,
                                                      height: 1,
                                                    ),
                                                    value: widget.controller
                                                        .branchId.value,
                                                    items: [
                                                      DropdownMenuItem<String>(
                                                        value: "",
                                                        child: Text(
                                                            "Branch Admin*"),
                                                      ),
                                                      ...widget
                                                          .controller.userList
                                                          .map((item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item.name
                                                                    .toString(),
                                                                child: Text(
                                                                    "${item.name}"),
                                                              )),
                                                    ],
                                                    onChanged: (newValue) {
                                                      customSnackbar(
                                                          "Can't Edit",
                                                          "This branch admin is already assigned you can't edit.",
                                                          "error");
                                                    },
                                                    hint:
                                                        Text('Select an item'),
                                                  )),
                                            ),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Branch Name";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                textInputType:
                                                    TextInputType.name,
                                                controller: widget.controller
                                                    .branchController,
                                                label: "Branch Name"),
                                          ],
                                          title: 'Edit Branch Details',
                                          onCancelPressed: () {
                                            Get.back();
                                            widget.controller
                                                .branchAdminController
                                                .clear();
                                            widget.controller.branchId.value =
                                                "";
                                            widget.controller.branchController
                                                .clear();
                                          },
                                          onUpdatePressed: () async {
                                            //   id: null,
                                            // branchAdminId: int.parse(controller.selectedBranchId.value),
                                            // branchAdminName: controller.branchAdminController.text,
                                            // deleted: "N",
                                            // name: controller.branchController.text,
                                            if (formKey.currentState!
                                                .validate()) {
                                              widget.controller.deletedbranchIds
                                                  .value = [];
                                              widget
                                                  .controller
                                                  .partyBranchItems[index]
                                                  .branchAdminName = widget
                                                      .controller
                                                      .branchAdminController
                                                      .text
                                                      .isEmpty
                                                  ? ""
                                                  : widget
                                                      .controller
                                                      .branchAdminController
                                                      .text;
                                              widget
                                                      .controller
                                                      .partyBranchItems[index]
                                                      .branchAdminId =
                                                  int.parse(widget.controller
                                                      .selectedBranchId.value);
                                              widget
                                                  .controller
                                                  .partyBranchItems[index]
                                                  .name = widget
                                                      .controller
                                                      .branchController
                                                      .text
                                                      .isNotEmpty
                                                  ? widget.controller
                                                      .branchController.text
                                                      .toString()
                                                  : "";
                                              widget.controller.partyBranchItems
                                                  .refresh();

                                              Get.back();
                                              widget.controller
                                                  .branchAdminController
                                                  .clear();
                                              widget.controller.branchId.value =
                                                  "";
                                              widget.controller.branchController
                                                  .clear();
                                            } else {
                                              customSnackbar(
                                                  "Error", "message", "error");
                                            }
                                          },
                                          saveButtonText: "Edit"),
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
}
