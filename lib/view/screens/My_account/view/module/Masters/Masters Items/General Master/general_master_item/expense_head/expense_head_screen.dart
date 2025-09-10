// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

class ExpenseHeadScreen extends StatefulWidget {
  const ExpenseHeadScreen({super.key});

  @override
  State<ExpenseHeadScreen> createState() => _ExpenseHeadScreenState();
}

class _ExpenseHeadScreenState extends State<ExpenseHeadScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: const Text("Expense Head"),
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResultExpenseHead.clear();
                    await controller.getExpenseHeadDetails();
                    // await controller.getCountryDetails("");
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: kColorblack,
                  ))
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      height: 6.h,
                      // width: 75.w,
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[4],
                        color: kColorwhite,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) => controller.search(value),
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Search Here',
                                hintStyle: TextStyle(color: kColorgrey),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            titleTextStyle: TextStyle(
                color: kColorblack,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
            centerTitle: false,
            backgroundColor: kColorwhite,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: kColorblack,
                size: 23.sp,
              ),
              onPressed: (() {
                controller.searchController.clear();
                controller.search("");
                Get.to(() => const GeneralMasterScreen(),
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 600));
                // Get.back();
              }),
            )),
      ),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, bottom: 75, right: 8, top: 8),
            child: Obx(
              () {
                return controller.searchResultExpenseHead.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: LottieBuilder.asset(
                                    "assets/lottie/empty.json")),
                            SizedBox(
                              height: 3.h,
                            ),
                            FadeIn(
                              delay: const Duration(milliseconds: 500),
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "Your Expense Head is Empty ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.searchResultExpenseHead.length,
                        physics: const BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var items = controller.searchResultExpenseHead[index];
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
                                        print(items.id);
                                        controller
                                            .deleteExpenseHeadDetails(items.id);
                                        Get.back();
                                      },
                                    );
                                  },
                                  color: Colors.red),
                            ],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  controller.expenseNameController.text =
                                      controller.expense_head_items[index].name;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Form(
                                          key: formkey,
                                          child: CustomPopup(
                                              title: "Edit Your Details",
                                              onCancelPressed: () {
                                                Get.back();
                                                controller.expenseNameController
                                                    .clear();
                                              },
                                              onUpdatePressed: () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  print(
                                                      'pressed button entering to controller');
                                                  controller.editExpenseHeadDetails(
                                                      id: controller
                                                              .expense_head_items[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      delete: controller
                                                              .expense_head_items[
                                                                  index]
                                                              .deleted ??
                                                          '');
                                                  Get.back();

                                                  controller
                                                      .expenseNameController
                                                      .clear();
                                                } else {
                                                  print("not validated");
                                                }
                                              },
                                              saveButtonText: "Edit",
                                              children: [
                                                CustomTextField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter expense name';
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: controller
                                                      .expenseNameController,
                                                  label: "Expense",
                                                ),
                                              ]));
                                    },
                                  );
                                },
                                child: Container(
                                  // height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[50],
                                    boxShadow: kElevationToShadow[1],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "Expense",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700),
                                    ),
                                    subtitle: Text(
                                      items.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: kColorblack,
                                          fontSize: 16),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: kElevationToShadow[1]),
                                          child: IconButton(
                                            onPressed: () {
                                              controller.expenseNameController
                                                      .text =
                                                  controller
                                                      .expense_head_items[index]
                                                      .name;
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Form(
                                                      key: formkey,
                                                      child: CustomPopup(
                                                          title:
                                                              "Edit Your Details",
                                                          onCancelPressed: () {
                                                            Get.back();
                                                            controller
                                                                .expenseNameController
                                                                .clear();
                                                          },
                                                          onUpdatePressed: () {
                                                            if (formkey
                                                                .currentState!
                                                                .validate()) {
                                                              print(
                                                                  'pressed button entering to controller');
                                                              controller.editExpenseHeadDetails(
                                                                  id: controller
                                                                          .expense_head_items[
                                                                              index]
                                                                          .id ??
                                                                      0,
                                                                  delete: controller
                                                                          .expense_head_items[
                                                                              index]
                                                                          .deleted ??
                                                                      '');
                                                              Get.back();

                                                              controller
                                                                  .expenseNameController
                                                                  .clear();
                                                            } else {
                                                              print(
                                                                  "not validated");
                                                            }
                                                          },
                                                          saveButtonText:
                                                              "Edit",
                                                          children: [
                                                            CustomTextField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please Enter expense name';
                                                                }
                                                                return null;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              obscure: false,
                                                              controller: controller
                                                                  .expenseNameController,
                                                              label: "Expense",
                                                            ),
                                                          ]));
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: kColorlightBlue,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        // Add some space between icons
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: kElevationToShadow[1]),
                                          child: IconButton(
                                            onPressed: () {
                                              print(items.id);
                                              customDeleteAlertDialogue(context,
                                                  () {
                                                controller
                                                    .deleteExpenseHeadDetails(
                                                        items.id);
                                                Get.back();
                                              });
                                              // controller.deleteCountryDetails(items.id);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: kColorRed,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Center(
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Form(
                                key: formkey,
                                child: CustomPopup(
                                    title: 'Add Your Expense',
                                    onCancelPressed: () {
                                      Get.back();
                                      controller.expenseNameController.clear();
                                    },
                                    onUpdatePressed: () {
                                      if (formkey.currentState!.validate()) {
                                        controller.postExpenseHeadDetails();
                                      } else {
                                        print("Not validated");
                                      }
                                    },
                                    saveButtonText: "Add",
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Expense name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              controller.expenseNameController,
                                          label: 'Expense Name'),
                                    ]));
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: kColorlightBlue),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Add Expense',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
