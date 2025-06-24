// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/city_model.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/screens/settings_module/user_profile/controller/address_detail_controller.dart';
import 'package:work_Force/view/widget/custom_dropdown.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

// ignore: must_be_immutable
class AreaMasterScreen extends StatefulWidget {
  AreaMasterScreen({super.key});

  @override
  State<AreaMasterScreen> createState() => _AreaMasterScreenState();
}

class _AreaMasterScreenState extends State<AreaMasterScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  int? cityId;
  CityModel? cityValue;

  @override
  void initState() {
    super.initState();
    // controller.getCityMasterDetails("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: const Text("Area Master"),
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResultAreaMaster.clear();
                    await controller.getAreaMasterDetails("");
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
              () => controller.searchResultAreaMaster.isEmpty
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
                              "Your Area Master is Empty ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.sp),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.searchResultAreaMaster.length,
                      itemBuilder: (context, index) {
                        var item = controller.searchResultAreaMaster[index];

                        String cityName = "";

                        controller.cityId.value = item.cityId ?? 0;
                        if (item.cityId != null) {
                          var cityValue = controller.city_master_items
                              .firstWhere(
                                  (element) => element.id == item.cityId);

                          cityName = cityValue.name ?? "";
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
                                      print(item.id);
                                      controller
                                          .deleteAreaMasterDetails(item.id);
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
                                controller.areaNameController.text =
                                    controller.area_master_items[index].name ??
                                        "";
                                controller.cityId.value = controller
                                        .area_master_items[index].cityId ??
                                    0;
                                controller.cityNameController.text =
                                    controller.city_master_items
                                            .firstWhere(
                                              (element) =>
                                                  element.id ==
                                                  controller.cityId.value,
                                            )
                                            .name ??
                                        "";
                                controller.cityName.value =
                                    controller.cityNameController.text;

                                print("cityId---${controller.cityId.value}");
                                print(
                                    "cityName---${controller.cityNameController.text}");
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Form(
                                        key: formkey,
                                        child: CustomPopup(
                                            title: 'Edit Your Details',
                                            onCancelPressed: () {
                                              Get.back();
                                              controller.areaNameController
                                                  .clear();
                                              controller.cityId.value = 0;
                                              controller.cityName.value = "";
                                              controller.cityNameController
                                                  .clear();
                                            },
                                            onUpdatePressed: () {
                                              print("onpressed---");
                                              if (formkey.currentState!
                                                  .validate()) {
                                                print(
                                                    'pressed button entering to controller');
                                                controller.editAreaMasterDetails(
                                                    id: item.id ?? 0,
                                                    delete: controller
                                                            .area_master_items[
                                                                index]
                                                            .deleted ??
                                                        '',
                                                    cityId: controller
                                                        .cityId.value);
                                              } else {
                                                print("not validated");
                                              }
                                            },
                                            saveButtonText: "Update",
                                            children: [
                                              CustomTextField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter area name';
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: controller
                                                      .areaNameController,
                                                  label: "Area Name"),
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
                                                                .cityName.value,
                                                            items: controller
                                                                .city_master_items
                                                                .map((e) => e
                                                                    .name!
                                                                    .trim()) // Ensure no leading/trailing spaces
                                                                .toSet() // Remove duplicates
                                                                .toList(),
                                                            hintText:
                                                                "Select City",
                                                            onChanged:
                                                                (newValue) {
                                                              controller
                                                                      .cityName
                                                                      .value =
                                                                  newValue!;

                                                              cityValue = controller
                                                                  .city_master_items
                                                                  .firstWhere(
                                                                (item) =>
                                                                    item.name
                                                                        .toString() ==
                                                                    newValue,
                                                              );

                                                              if (cityValue !=
                                                                  null) {
                                                                controller
                                                                    .cityNameController
                                                                    .text = cityValue!
                                                                        .name ??
                                                                    '';
                                                                controller
                                                                        .cityId
                                                                        .value =
                                                                    cityValue!
                                                                            .id ??
                                                                        0;
                                                              }
                                                              print(
                                                                  "cityname---${controller.cityNameController.text}");
                                                            }),
                                                      )))
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
                                    "Area : ${item.name}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    "City : ${cityName}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
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
                                            controller.areaNameController
                                                .text = controller
                                                    .area_master_items[index]
                                                    .name ??
                                                "";
                                            controller.cityId.value = controller
                                                    .area_master_items[index]
                                                    .cityId ??
                                                0;
                                            controller.cityNameController.text =
                                                controller.city_master_items
                                                        .firstWhere(
                                                          (element) =>
                                                              element.id ==
                                                              controller
                                                                  .cityId.value,
                                                        )
                                                        .name ??
                                                    "";
                                            controller.cityName.value =
                                                controller
                                                    .cityNameController.text;

                                            print(
                                                "cityId---${controller.cityId.value}");
                                            print(
                                                "cityName---${controller.cityNameController.text}");
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Form(
                                                    key: formkey,
                                                    child: CustomPopup(
                                                        title:
                                                            'Edit Your Details',
                                                        onCancelPressed: () {
                                                          Get.back();
                                                          controller
                                                              .areaNameController
                                                              .clear();
                                                          controller
                                                              .cityId.value = 0;
                                                          controller.cityName
                                                              .value = "";
                                                          controller
                                                              .cityNameController
                                                              .clear();
                                                        },
                                                        onUpdatePressed: () {
                                                          print("onpressed---");
                                                          if (formkey
                                                              .currentState!
                                                              .validate()) {
                                                            print(
                                                                'pressed button entering to controller');
                                                            controller.editAreaMasterDetails(
                                                                id: item.id ??
                                                                    0,
                                                                delete:
                                                                    item.deleted ??
                                                                        '',
                                                                cityId:
                                                                    controller
                                                                        .cityId
                                                                        .value);
                                                          } else {
                                                            print(
                                                                "not validated");
                                                          }
                                                        },
                                                        saveButtonText:
                                                            "Update",
                                                        children: [
                                                          CustomTextField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please Enter area name';
                                                                }
                                                                return null;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              obscure: false,
                                                              controller: controller
                                                                  .areaNameController,
                                                              label:
                                                                  "Area Name"),
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
                                                                            value: controller.cityName.value,
                                                                            items: controller.city_master_items
                                                                                .map((e) => e.name!.trim()) // Ensure no leading/trailing spaces
                                                                                .toSet() // Remove duplicates
                                                                                .toList(),
                                                                            hintText: "Select City",
                                                                            onChanged: (newValue) {
                                                                              controller.cityName.value = newValue!;

                                                                              cityValue = controller.city_master_items.firstWhere(
                                                                                (item) => item.name.toString() == newValue,
                                                                              );

                                                                              if (cityValue != null) {
                                                                                controller.cityNameController.text = cityValue!.name ?? '';
                                                                                controller.cityId.value = cityValue!.id ?? 0;
                                                                              }
                                                                              print("cityname---${controller.cityNameController.text}");
                                                                            }),
                                                                      )))
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
                                              print(item.id);
                                              customDeleteAlertDialogue(context,
                                                  () {
                                                controller
                                                    .deleteAreaMasterDetails(
                                                        item.id);
                                                Get.back();
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: kColorRed,
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
                                    title: "Add Your Area",
                                    onCancelPressed: () {
                                      Get.back();
                                      controller.areaNameController.clear();
                                      controller.cityId.value = 0;
                                      controller.cityName.value = "";
                                      controller.cityNameController.clear();
                                    },
                                    onUpdatePressed: () {
                                      if (formkey.currentState!.validate()) {
                                        controller.postAreaMasterdDetails(
                                            controller.cityId.value);
                                        // controller.countryNameController.clear();
                                      } else {
                                        print("Not validated");
                                      }
                                    },
                                    saveButtonText: "Add",
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Area name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              controller.areaNameController,
                                          label: 'Area Name'),
                                      FadeIn(
                                          delay:
                                              const Duration(milliseconds: 300),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: Obx(() => Container(
                                                margin: EdgeInsets.all(2.w),
                                                child: CustomDropdown(
                                                    value: controller
                                                        .cityName.value,
                                                    items: controller
                                                        .city_master_items
                                                        .map((e) => e.name!
                                                            .trim()) // Ensure no leading/trailing spaces
                                                        .toSet() // Remove duplicates
                                                        .toList(),
                                                    hintText: "Select City",
                                                    onChanged: (newValue) {
                                                      controller.cityName
                                                          .value = newValue!;

                                                      cityValue = controller
                                                          .city_master_items
                                                          .firstWhere(
                                                        (item) =>
                                                            item.name
                                                                .toString() ==
                                                            newValue,
                                                      );

                                                      if (cityValue != null) {
                                                        controller
                                                            .cityNameController
                                                            .text = cityValue!
                                                                .name ??
                                                            '';
                                                        controller
                                                                .cityId.value =
                                                            cityValue!.id ?? 0;
                                                      }
                                                      print(
                                                          "cityname---${controller.cityNameController.text}");
                                                    }),
                                              )))
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
                              'Add Area ',
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
