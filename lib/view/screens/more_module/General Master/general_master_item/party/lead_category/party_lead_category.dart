// ignore_for_file: must_be_immutable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/customer_classification_model.dart';
import 'package:work_Force/view/screens/more_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/more_module/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

class LeadCategoryMasterScreen extends StatefulWidget {
  LeadCategoryMasterScreen({super.key});

  @override
  State<LeadCategoryMasterScreen> createState() =>
      _LeadCategoryMasterScreenState();
}

class _LeadCategoryMasterScreenState extends State<LeadCategoryMasterScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // controller.getLeadCategoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: Text("Party/Lead Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResultCustomerClass.clear();
                    await controller.getLeadCategoryDetails();
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
                fontSize: 16.sp),
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

                setState(() {
                  Get.to(() => const GeneralMasterScreen(),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 600));
                });
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
                return controller.searchResultCustomerClass.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: LottieBuilder.asset(
                                    "assets/lottie/empty.json",height: 15.h,)),
                            SizedBox(
                              height: 3.h,
                            ),
                            FadeIn(
                              delay: const Duration(milliseconds: 500),
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "Your Party/Lead Category is Empty ",
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
                        itemCount: controller.searchResultCustomerClass.length,
                        physics: const BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var items =
                              controller.searchResultCustomerClass[index];
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
                                        controller.deleteLeadCategoryDetails(
                                            items.id);
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
                                  print("ontapped");
                                  var item =
                                      controller.customer_class_items[index];
                                  controller.categoryNameController.text =
                                      item.name ?? "";
                                  controller
                                          .paymentDueDaysLimitController.text =
                                      item.dueDaysLimit?.toString() ?? "";
                                  controller.creditLimitController.text =
                                      item.creditLimit?.toString() ?? "";

                                  editLeadCategoryDialog(context, item);
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
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade700,
                                          fontSize: 15),
                                    ),
                                    subtitle: Text(
                                      items.name ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
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
                                              var item = controller
                                                  .customer_class_items[index];
                                              controller.categoryNameController
                                                  .text = item.name ?? "";

                                              controller
                                                  .paymentDueDaysLimitController
                                                  .text = item.dueDaysLimit
                                                      ?.toString() ??
                                                  "";
                                              controller.creditLimitController
                                                  .text = item.creditLimit
                                                      ?.toString() ??
                                                  "";

                                              editLeadCategoryDialog(
                                                  context, item);
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: kColorlightBlue,
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
                                          // radius: 15,

                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                print(items.id);
                                                customDeleteAlertDialogue(
                                                    context, () {
                                                  controller
                                                      .deleteLeadCategoryDetails(
                                                          items.id);
                                                  Get.back();
                                                });
                                                // controller.deleteLeadCategoryDetails(items.id);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: kColorRed,
                                              ),
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
              bottom: 5.w,
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
                                key: formKey,
                                child: CustomPopup(
                                    title: "Add Party/Lead",
                                    onCancelPressed: () {
                                      Get.back();

                                      controller.categoryNameController.clear();
                                    },
                                    onUpdatePressed: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.postPartyLeadCategory();
                                      } else {
                                        print('not validated------save');
                                      }
                                    },
                                    saveButtonText: "Add",
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Party/Lead Name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              controller.categoryNameController,
                                          label: 'Name'),
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
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Add',
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

  Future<dynamic> editLeadCategoryDialog(
      BuildContext context, CustomerClassificationModel item) {
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: CustomPopup(
              title: "Edit Country",
              onCancelPressed: () {
                Get.back();

                controller.categoryNameController.clear();
                controller.paymentDueDaysLimitController.clear();
                controller.creditLimitController.clear();
              },
              onUpdatePressed: () {
                if (formKey.currentState!.validate()) {
                  print('pressed button entering to controller');
                  var value = CustomerClassificationModel(
                    id: item.id,
                    name: controller.categoryNameController.text,
                    deleted: item.deleted,
                    creditLimit: controller.creditLimitController.text.isEmpty
                        ? null
                        : controller.creditLimitController.text,
                    dueDaysLimit:
                        controller.paymentDueDaysLimitController.text.isEmpty
                            ? null
                            : controller.paymentDueDaysLimitController.text,
                  );
                  controller.customer_class_items.add(value);
                  var values = controller.customer_class_items
                      .map((element) => element.toJson())
                      .toList();

                  controller.postPartyLeadCategory(true, values);
                } else {
                  print("Not validated-------- error---");
                }
              },
              saveButtonText: "Edit",
              children: [
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Party/Lead Name';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    obscure: false,
                    controller: controller.categoryNameController,
                    label: 'Party/Lead Name'),
                CustomTextField(
                    validator: (value) {
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    obscure: false,
                    controller: controller.paymentDueDaysLimitController,
                    textInputType: TextInputType.number,
                    label: 'Payment Due Days Limit'),
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    obscure: false,
                    textInputType: TextInputType.number,
                    controller: controller.creditLimitController,
                    label: 'Credit Limit'),
              ]),
        );
      },
    );
  }
}
