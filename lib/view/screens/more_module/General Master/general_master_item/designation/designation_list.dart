// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/more_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/more_module/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

// ignore: must_be_immutable
class DesignationScreen extends StatefulWidget {
  DesignationScreen({super.key});

  @override
  State<DesignationScreen> createState() => _DesignationScreenState();
}

class _DesignationScreenState extends State<DesignationScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: const Text("Designation"),
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResultDesignstion.clear();
                    await controller.getDesignationDetails();
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
                Icons.keyboard_arrow_left,
                color: kColorblack,
                size: 25.sp,
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
                return controller.searchResultDesignstion.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: LottieBuilder.asset(
                                  "assets/lottie/empty.json",
                                  height: 15.h,
                                )),
                            SizedBox(
                              height: 3.h,
                            ),
                            FadeIn(
                              delay: const Duration(milliseconds: 500),
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "Your Designation is Empty ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.searchResultDesignstion.length,
                        physics: const BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var items = controller.searchResultDesignstion[index];
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
                                            .deleteDesignationDetails(items.id);
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
                                  controller.designationNameController.text =
                                      controller.designation_items[index]
                                          .designationName;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Form(
                                          key: formkey,
                                          child: CustomPopup(
                                              title: 'Edit Your Designation',
                                              onCancelPressed: () {
                                                Get.back();
                                                controller
                                                    .designationNameController
                                                    .clear();
                                              },
                                              onUpdatePressed: () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  print(
                                                      'pressed button entering to controller');
                                                  controller.editDesignationDetails(
                                                      id: controller
                                                              .designation_items[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      delete: controller
                                                              .designation_items[
                                                                  index]
                                                              .deleted ??
                                                          '');
                                                  Get.back();

                                                  controller
                                                      .designationNameController
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
                                                        return 'Please Enter designation name';
                                                      }
                                                      return null;
                                                    },
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    obscure: false,
                                                    controller: controller
                                                        .designationNameController,
                                                    label: "Designation name"),
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
                                      "Designation",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700),
                                    ),
                                    subtitle: Text(
                                      items.designationName,
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
                                              controller
                                                      .designationNameController
                                                      .text =
                                                  controller
                                                      .designation_items[index]
                                                      .designationName;
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Form(
                                                      key: formkey,
                                                      child: CustomPopup(
                                                          title:
                                                              'Edit Your Designation',
                                                          onCancelPressed: () {
                                                            Get.back();
                                                            controller
                                                                .designationNameController
                                                                .clear();
                                                          },
                                                          onUpdatePressed: () {
                                                            if (formkey
                                                                .currentState!
                                                                .validate()) {
                                                              print(
                                                                  'pressed button entering to controller');
                                                              controller.editDesignationDetails(
                                                                  id: controller
                                                                          .designation_items[
                                                                              index]
                                                                          .id ??
                                                                      0,
                                                                  delete: controller
                                                                          .designation_items[
                                                                              index]
                                                                          .deleted ??
                                                                      '');
                                                              Get.back();

                                                              controller
                                                                  .designationNameController
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
                                                                    return 'Please Enter designation name';
                                                                  }
                                                                  return null;
                                                                },
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                obscure: false,
                                                                controller:
                                                                    controller
                                                                        .designationNameController,
                                                                label:
                                                                    "Designation name"),
                                                          ]));
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: kColorlightBlue,
                                            ),
                                          ),
                                        ),
                                        // Add some space between icons
                                        const SizedBox(
                                          width: 10,
                                        ),
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
                                                    .deleteDesignationDetails(
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
                                    title: "Add Your Designation",
                                    onCancelPressed: () {
                                      Get.back();
                                      controller.designationNameController
                                          .clear();
                                    },
                                    onUpdatePressed: () {
                                      if (formkey.currentState!.validate()) {
                                        controller.postDesignationDetails();
                                      } else {
                                        print("Not validated");
                                      }
                                    },
                                    saveButtonText: "Add",
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter designation name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: controller
                                              .designationNameController,
                                          label: 'Designation Name'),
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
                              'Add Designation',
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
