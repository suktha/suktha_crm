
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/party_contact_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/material_list_custom_widgets.dart';

class ContactList extends StatelessWidget {
  final Widget designationDropdown;
  final Widget departmentDropdown;
  final VoidCallback itemAddButton;
  List<PartyContactDetails>? contactList;
  final bool isEdit;

  ContactList(
      {super.key,
      required this.designationDropdown,
      this.contactList,
      required this.itemAddButton,
      required this.isEdit,
      required this.controller,
      required this.departmentDropdown});

  final PartyMasterController controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                departmentDropdown,
                Row(
                  children: [
                    Expanded(flex: 3, child: designationDropdown),
                    Expanded(
                      child: GestureDetector(
                        onTap: itemAddButton,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: kElevationToShadow[3]),
                          child: CircleAvatar(
                            radius: 2.4.h,
                            backgroundColor:
                                const Color.fromARGB(255, 248, 235, 234),
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
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: controller.contactListItem.isEmpty
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
                              "Contact List is Empty",
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
                      itemCount: controller.contactListItem.length,
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
                                      controller.contactListItem
                                          .removeAt(indexs);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: MaterialListCustom(
                            amount: "",
                            name:
                                controller.contactListItem[indexs].department ??
                                    "",
                            quantity: controller
                                    .contactListItem[indexs].designation ??
                                "",
                            onlongpress: () {
                              customDeleteAlertDialogue(
                                context,
                                () {
                                  controller.contactListItem.removeAt(indexs);
                                  Get.back();
                                },
                              );
                            },
                            ontap: () {
                              controller.departmentController.text = controller
                                      .contactListItem[indexs].department ??
                                  "";
                              controller.designationController.text = controller
                                      .contactListItem[indexs].designation ??
                                  "";
                              controller.namecontactListController.text =
                                  controller.contactListItem[indexs].name ?? "";
                              controller.emailContactListController.text =
                                  controller.contactListItem[indexs].email ??
                                      "";
                              controller.primaryPhoneNumontactListController
                                  .text = controller.contactListItem[indexs]
                                      .primaryPhoneNumber ??
                                  "";
                              controller.secPhoneNumontactListController.text =
                                  controller.contactListItem[indexs]
                                          .secondaryPhoneNumber ??
                                      "";
                              controller.remarkContactController.text =
                                  controller.contactListItem[indexs].remarks
                                          ?.toString() ??
                                      "";

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Form(
                                    key: formKey,
                                    child: CustomPopup(
                                        title: 'Price Details',
                                        onCancelPressed: () {
                                          Get.back();
                                          controller.namecontactListController
                                              .clear();
                                          controller.emailContactListController
                                              .clear();
                                          controller
                                              .primaryPhoneNumontactListController
                                              .clear();
                                          controller
                                              .secPhoneNumontactListController
                                              .clear();
                                          controller.remarkContactController
                                              .clear();
                                        },
                                        onUpdatePressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.contactListItem[indexs]
                                                    .name =
                                                controller
                                                    .namecontactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .email =
                                                controller
                                                    .emailContactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .primaryPhoneNumber =
                                                controller
                                                    .primaryPhoneNumontactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .secondaryPhoneNumber =
                                                controller
                                                    .secPhoneNumontactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .remarks =
                                                controller
                                                    .remarkContactController
                                                    .text;

                                            controller.contactListItem
                                                .refresh();

                                            Get.back();
                                            controller.namecontactListController
                                                .clear();
                                            controller
                                                .emailContactListController
                                                .clear();
                                            controller
                                                .primaryPhoneNumontactListController
                                                .clear();
                                            controller
                                                .secPhoneNumontactListController
                                                .clear();
                                            controller.remarkContactController
                                                .clear();
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
                                                  .departmentController,
                                              label: "Department"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .designationController,
                                              label: "Designation"),
                                          CustomTextField(
                                              // readonly: true,
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .namecontactListController,
                                              label: "Name"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              // readonly: true,
                                              controller: controller
                                                  .emailContactListController,
                                              label: "Email"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              textInputType:
                                                  TextInputType.number,
                                              // readonly: true,
                                              controller: controller
                                                  .primaryPhoneNumontactListController,
                                              label: "Primary Number"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              textInputType:
                                                  TextInputType.number,

                                              // readonly: true,
                                              controller: controller
                                                  .secPhoneNumontactListController,
                                              label: "Sec Phone No"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .remarkContactController,
                                              label: "Remarks")
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
