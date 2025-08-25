// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/state_model.dart';
import 'package:work_Force/view/screens/My_account/more_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/My_account/more_module/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/widget/custom_dropdown.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

// ignore: must_be_immutable
class CityMasterScreen extends StatefulWidget {
  const CityMasterScreen({super.key});

  @override
  State<CityMasterScreen> createState() => _CityMasterScreenState();
}

class _CityMasterScreenState extends State<CityMasterScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // int? stateId;
  StateModel? stateValue;

  @override
  void initState() {
    super.initState();
    // controller.getCityMasterDetails("");
    // controller.getStateDetails("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: const Text("City Master"),
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResultCityMaster.clear();
                    await controller.getCityMasterDetails("");
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
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Search Here',
                                hintStyle: TextStyle(color: kColorgrey),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
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
                Get.to(() => GeneralMasterScreen(),
                    transition: Transition.fade,
                    duration: Duration(milliseconds: 600));
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
              () => controller.searchResultCityMaster.isEmpty
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
                              "Your City Master is Empty ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.searchResultCityMaster.length,
                      itemBuilder: (context, index) {
                        var item = controller.searchResultCityMaster[index];

                        String? stateName;

                        controller.stateId.value = item.id ?? 0;
                        if (controller.state_master_items.isNotEmpty) {
                          var stateValue = controller.state_master_items
                              .firstWhere(
                                  (element) => element.id == item.stateId);
                          stateName = stateValue.name ?? "";
                          controller.foreignStateController.text =
                              stateValue.name ?? "";
                        }

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
                                      controller
                                          .deleteCityMasterDetails(item.id);
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
                                controller.cityNameController.text =
                                    item.name ?? "";
                                controller.stateId.value = item.stateId ?? 0;

                                controller.foreignStateController
                                    .text = controller.state_master_items
                                        .firstWhere(
                                          (e) =>
                                              e.id == controller.stateId.value,
                                        )
                                        .name ??
                                    "";
                                controller.stateName.value =
                                    controller.foreignStateController.text;

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Form(
                                        key: formkey,
                                        child: CustomPopup(
                                            title: 'Edit Your Edit',
                                            onCancelPressed: () {
                                              Get.back();
                                              controller.cityNameController
                                                  .clear();
                                              controller.foreignStateController
                                                  .clear();
                                              controller.stateName.value = '';
                                              controller.stateId.value = 0;
                                            },
                                            onUpdatePressed: () {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                controller.editCityMasterDetails(
                                                    id: controller
                                                            .city_master_items[
                                                                index]
                                                            .id ??
                                                        0,
                                                    delete: controller
                                                            .city_master_items[
                                                                index]
                                                            .deleted ??
                                                        '',
                                                    stateid: controller
                                                        .stateId.value);
                                              } else {}
                                            },
                                            saveButtonText: 'Update',
                                            children: [
                                              CustomTextField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter city name';
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: controller
                                                      .cityNameController,
                                                  label: "City Name"),
                                              FadeIn(
                                                  delay: const Duration(
                                                      milliseconds: 300),
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  child: Obx(() => Container(
                                                        margin:
                                                            EdgeInsets.all(2.w),
                                                        child: CustomDropdown(
                                                            value: controller
                                                                .stateName
                                                                .value,
                                                            items: controller
                                                                .state_master_items
                                                                .map((e) => e
                                                                    .name!
                                                                    .trim()) // Ensure no leading/trailing spaces
                                                                .toSet() // Remove duplicates
                                                                .toList(),
                                                            hintText:
                                                                "Select State",
                                                            onChanged:
                                                                (newValue) {
                                                              controller
                                                                      .stateName
                                                                      .value =
                                                                  newValue!;

                                                              stateValue = controller
                                                                  .state_master_items
                                                                  .firstWhere(
                                                                (item) =>
                                                                    item.name
                                                                        .toString() ==
                                                                    newValue,
                                                              );

                                                              if (stateValue !=
                                                                  null) {
                                                                controller
                                                                    .foreignStateController
                                                                    .text = stateValue!
                                                                        .name ??
                                                                    '';
                                                                controller
                                                                        .stateId
                                                                        .value =
                                                                    stateValue!
                                                                            .id ??
                                                                        0;
                                                              }
                                                              print(
                                                                  "stateName---${controller.foreignStateController.text}");
                                                            }),
                                                      ))),
                                            ]));
                                  },
                                );
                                //
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
                                    "City : ${item.name}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    "State : ${stateName ?? ""}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
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
                                            controller.cityNameController.text =
                                                item.name ?? "";
                                            controller.stateId.value =
                                                item.stateId ?? 0;

                                            controller.foreignStateController
                                                    .text =
                                                controller.state_master_items
                                                        .firstWhere(
                                                          (e) =>
                                                              e.id ==
                                                              controller.stateId
                                                                  .value,
                                                        )
                                                        .name ??
                                                    "";
                                            controller.stateName.value =
                                                controller
                                                    .foreignStateController
                                                    .text;

                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Form(
                                                    key: formkey,
                                                    child: CustomPopup(
                                                        title: 'Edit Your Edit',
                                                        onCancelPressed: () {
                                                          Get.back();
                                                          controller
                                                              .cityNameController
                                                              .clear();
                                                          controller
                                                              .foreignStateController
                                                              .clear();
                                                          controller.stateName
                                                              .value = '';
                                                          controller.stateId
                                                              .value = 0;
                                                        },
                                                        onUpdatePressed: () {
                                                          if (formkey
                                                              .currentState!
                                                              .validate()) {
                                                            controller.editCityMasterDetails(
                                                                id: item.id ??
                                                                    0,
                                                                delete:
                                                                    item.deleted ??
                                                                        '',
                                                                stateid:
                                                                    controller
                                                                        .stateId
                                                                        .value);
                                                          } else {}
                                                        },
                                                        saveButtonText: 'Update',
                                                        children: [
                                                          CustomTextField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please Enter city name';
                                                                }
                                                                return null;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              obscure: false,
                                                              controller: controller
                                                                  .cityNameController,
                                                              label:
                                                                  "City Name"),
                                                          FadeIn(
                                                              delay: const Duration(
                                                                  milliseconds:
                                                                      300),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              child: Obx(
                                                                  () =>
                                                                      Container(
                                                                        margin:
                                                                            EdgeInsets.all(2.w),
                                                                        child: CustomDropdown(
                                                                            value: controller.stateName.value,
                                                                            items: controller.state_master_items
                                                                                .map((e) => e.name!.trim()) // Ensure no leading/trailing spaces
                                                                                .toSet() // Remove duplicates
                                                                                .toList(),
                                                                            hintText: "Select State",
                                                                            onChanged: (newValue) {
                                                                              controller.stateName.value = newValue!;

                                                                              stateValue = controller.state_master_items.firstWhere(
                                                                                (item) => item.name.toString() == newValue,
                                                                              );

                                                                              if (stateValue != null) {
                                                                                controller.foreignStateController.text = stateValue!.name ?? '';
                                                                                controller.stateId.value = stateValue!.id ?? 0;
                                                                              }
                                                                              print("stateName---${controller.foreignStateController.text}");
                                                                            }),
                                                                      ))),
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
                                      SizedBox(
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
                                              customDeleteAlertDialogue(context,
                                                  () {
                                                controller
                                                    .deleteCityMasterDetails(
                                                        item.id);
                                                Get.back();
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: kColorRed,
                                              size: 20,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                                    title: 'Add Your City',
                                    onCancelPressed: () {
                                      Get.back();
                                      controller.foreignStateController.clear();
                                      controller.cityNameController.clear();
                                      controller.stateName
                                                              .value = '';
                                                          controller.stateId
                                                              .value = 0;
                                    },
                                    onUpdatePressed: () {
                                      if (formkey.currentState!.validate()) {
                                        controller.postCityMasterdDetails(
                                            controller.stateId.value);
                                        // controller.cityNameController.clear();
                                      } else {}
                                    },
                                    saveButtonText: "Add",
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter City name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              controller.cityNameController,
                                          label: 'City Name'),
                                      FadeIn(
                                          delay:
                                              const Duration(milliseconds: 300),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: Obx(() => Container(
                                                margin: EdgeInsets.all(2.w),
                                                child: CustomDropdown(
                                                    value: controller
                                                        .stateName.value,
                                                    items: controller
                                                        .state_master_items
                                                        .map((e) => e.name!
                                                            .trim()) // Ensure no leading/trailing spaces
                                                        .toSet() // Remove duplicates
                                                        .toList(),
                                                    hintText: "Select State",
                                                    onChanged: (newValue) {
                                                      controller.stateName
                                                          .value = newValue!;

                                                      stateValue = controller
                                                          .state_master_items
                                                          .firstWhere(
                                                        (item) =>
                                                            item.name
                                                                .toString() ==
                                                            newValue,
                                                      );

                                                      if (stateValue != null) {
                                                        controller
                                                            .foreignStateController
                                                            .text = stateValue!
                                                                .name ??
                                                            '';
                                                        controller
                                                                .stateId.value =
                                                            stateValue!.id ?? 0;
                                                      }
                                                      print(
                                                          "stateName---${controller.foreignStateController.text}");
                                                    }),
                                              ))),
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
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Add City Master',
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
