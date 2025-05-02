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

class CustomContactList extends StatefulWidget {
  final Widget departmentHead;
  final Widget designationHead;
  final VoidCallback itemAddButton;

  final bool isEdit;

  CustomContactList({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.departmentHead,
    required this.itemAddButton,
    required this.designationHead,
  });

  final SettingsController controller;

  @override
  State<CustomContactList> createState() => _CustomContactListState();
}

class _CustomContactListState extends State<CustomContactList> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomPopup(
                      children: [widget.departmentHead, widget.designationHead],
                      title: "Add Contact List",
                      onCancelPressed: () {
                        Get.back();
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
                  "Add Contact List",
                  style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorwhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Obx(
            () => widget.controller.partyContactItems.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 9.h,
                      ),
                      FadeIn(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 300), child: LottieBuilder.asset("assets/lottie/empty.json", height: 15.h)),
                      SizedBox(
                        height: 3.h,
                      ),
                      FadeIn(
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          "Contact List is Empty",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                        ),
                      )
                    ],
                  ))
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        return Future.delayed(
                          Duration(seconds: 1),
                          () {
                            widget.controller.partyContactItems.clear();
                            widget.controller.getPartyBankDetails();
                          },
                        );
                      },
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                            child: Divider(
                          thickness: 1,
                          color: kColorgrey,
                        )),
                        shrinkWrap: true,
                        itemCount: widget.controller.partyContactItems.length,
                        itemBuilder: (context, index) {
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
                                        widget.controller.partyContactItems.removeAt(index);
                                        Get.back();
                                      },
                                    );
                                  },
                                  color: Colors.red),
                            ],
                            child: GestureDetector(
                              onLongPress: () {
                                customDeleteAlertDialogue(
                                  context,
                                  () {
                                    widget.controller.partyContactItems.removeAt(index);
                                    Get.back();
                                  },
                                );
                              },
                              onTap: () {
                                print('clicked---');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    widget.controller.namecontactListController.text = widget.controller.partyContactItems[index].name ?? "";
                                    widget.controller.emailContactListController.text = widget.controller.partyContactItems[index].email ?? "";
                                    widget.controller.primaryPhoneNumontactListController.text = widget.controller.partyContactItems[index].primaryPhoneNumber ?? "";
                                    widget.controller.secPhoneNumontactListController.text = widget.controller.partyContactItems[index].secondaryPhoneNumber ?? "";
                                    widget.controller.remarkContactController.text = widget.controller.partyContactItems[index].remarks?.toString() ?? "";
                                    widget.controller.designationController.text = widget.controller.partyContactItems[index].designation?.toString() ?? "";
                                    widget.controller.departmentController.text = widget.controller.partyContactItems[index].department?.toString() ?? "";
                                    widget.controller.departmentId.value = widget.controller.partyContactItems[index].departmentId?.toString() ?? "";
                                    widget.controller.designationId.value = widget.controller.partyContactItems[index].designationId?.toString() ?? "";
                                    return Form(
                                      key: formKey,
                                      child: CustomPopup(
                                          children: [
                                            Obx(
                                              () => Padding(
                                                padding: const EdgeInsets.only(left: 5.0, right: 5),
                                                child: Container(
                                                    // margin: EdgeInsets.all(2.w),
                                                    height: 7.h,
                                                    // width: 30.w,
                                                    child: DropdownButton(
                                                      isExpanded: true,
                                                      underline: Divider(
                                                        color: Color.fromARGB(255, 220, 220, 220),
                                                        thickness: 1,
                                                        height: 1,
                                                      ),
                                                      value: widget.controller.departmentId.value,
                                                      items: [
                                                        DropdownMenuItem<String>(
                                                          value: "",
                                                          child: Text("Department Type*"),
                                                        ),
                                                        ...widget.controller.departmentList.map((item) => DropdownMenuItem<String>(
                                                              value: item.id.toString(),
                                                              child: Text("${item.departmentName}"),
                                                            )),
                                                      ],
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          widget.controller.departmentId.value = newValue!;

                                                          print(widget.controller.departmentId.value);

                                                          widget.controller.departmentController.text =
                                                              widget.controller.departmentList.firstWhere((item) => item.id.toString() == widget.controller.departmentId.value).departmentName!;

                                                          print(widget.controller.departmentController.text);
                                                        });
                                                      },
                                                      hint: Text('Select an item'),
                                                    )),
                                              ),
                                            ),
                                            Obx(
                                              () => Padding(
                                                padding: const EdgeInsets.only(left: 5.0, right: 5),
                                                child: Container(
                                                    // width: 30.w,
                                                    height: 7.h,
                                                    child: DropdownButton(
                                                      isExpanded: true,
                                                      underline: Divider(
                                                        color: Color.fromARGB(255, 220, 220, 220),
                                                        thickness: 1,
                                                        height: 1,
                                                      ),
                                                      value: widget.controller.designationId.value,
                                                      items: [
                                                        DropdownMenuItem<String>(
                                                          value: "",
                                                          child: Text("Designation Type*"),
                                                        ),
                                                        ...widget.controller.designationList.map((item) => DropdownMenuItem<String>(
                                                              value: item.id.toString(),
                                                              child: Text("${item.designationName}"),
                                                            )),
                                                      ],
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          widget.controller.designationId.value = newValue!;

                                                          print(widget.controller.designationId.value);

                                                          widget.controller.designationController.text =
                                                              widget.controller.designationList.firstWhere((item) => item.id.toString() == widget.controller.designationId.value).designationName;

                                                          print(widget.controller.designationController.text);
                                                        });
                                                      },
                                                      hint: Text('Select an item'),
                                                    )),
                                              ),
                                            ),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter name";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                controller: widget.controller.namecontactListController,
                                                label: "Name "),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Email";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                controller: widget.controller.emailContactListController,
                                                label: "Email"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please Primary Phone Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                controller: widget.controller.primaryPhoneNumontactListController,
                                                label: "Primary Phone Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Secondary Phone Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction: TextInputAction.next,
                                                textInputType: TextInputType.number,
                                                obscure: false,
                                                controller: widget.controller.secPhoneNumontactListController,
                                                label: "Secondary Phone Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Remarks";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                textInputType: TextInputType.number,
                                                controller: widget.controller.remarkContactController,
                                                label: "Remarks")
                                          ],
                                          title: 'Contact Details',
                                          onCancelPressed: () {
                                            Get.back();
                                            widget.controller.designationController.clear();
                                            widget.controller.departmentController.clear();
                                            widget.controller.namecontactListController.clear();
                                            widget.controller.emailContactListController.clear();
                                            widget.controller.primaryPhoneNumontactListController.clear();
                                            widget.controller.secPhoneNumontactListController.clear();
                                            widget.controller.remarkContactController.clear();
                                            widget.controller.departmentId.value = "";
                                            widget.controller.designationId.value = "";
                                          },
                                          onUpdatePressed: () {
                                            if (formKey.currentState!.validate()) {
                                              widget.controller.partyContactItems[index].name = widget.controller.nameController.text.isEmpty ? "" : widget.controller.nameController.text;
                                              widget.controller.partyContactItems[index].email = widget.controller.emailContactListController.text;
                                              widget.controller.partyContactItems[index].primaryPhoneNumber =
                                                  widget.controller.primaryPhoneNumontactListController.text.isNotEmpty ? widget.controller.primaryPhoneNumontactListController.text.toString() : "";
                                              widget.controller.partyContactItems[index].secondaryPhoneNumber = widget.controller.secPhoneNumontactListController.text;
                                              widget.controller.partyContactItems[index].remarks = widget.controller.remarkContactController.text;
                                              widget.controller.partyContactItems[index].department = widget.controller.departmentController.text;
                                              widget.controller.partyContactItems[index].designation = widget.controller.designationController.text;
                                              widget.controller.partyContactItems[index].departmentId = int.parse(widget.controller.departmentId.value);
                                              widget.controller.partyContactItems[index].designationId = int.parse(widget.controller.designationId.value);

                                              widget.controller.partyContactItems.refresh();

                                              Get.back();
                                              widget.controller.designationController.clear();
                                              widget.controller.departmentController.clear();
                                              widget.controller.namecontactListController.clear();
                                              widget.controller.emailContactListController.clear();
                                              widget.controller.primaryPhoneNumontactListController.clear();
                                              widget.controller.secPhoneNumontactListController.clear();
                                              widget.controller.remarkContactController.clear();
                                              widget.controller.departmentId.value = "";
                                              widget.controller.designationId.value = "";
                                            } else {
                                              print("not validated");
                                            }
                                          },
                                          saveButtonText: "Add"),
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(widget.controller.partyContactItems[index].department ?? ""),
                                subtitle: Text(widget.controller.partyContactItems[index].designation ?? ""),
                                trailing: Text(widget.controller.partyContactItems[index].name ?? ""),
                              ),
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
