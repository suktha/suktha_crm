// ignore_for_file: must_be_immutable, avoid_print

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

class CountryMasterScreen extends StatefulWidget {
  const CountryMasterScreen({super.key});

  @override
  State<CountryMasterScreen> createState() => _CountryMasterScreenState();
}

class _CountryMasterScreenState extends State<CountryMasterScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            title:  Text("Country Master",
                style: TextStyle(
                  fontSize: 18.5.sp
            )),
            
            
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResults.clear();
                    await controller.getCountryDetails("");
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
                return controller.searchResults.isEmpty
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
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            FadeIn(
                              delay: const Duration(milliseconds: 500),
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "Your Country Master is Empty ",
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
                        itemCount: controller.searchResults.length,
                        physics: const BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var items = controller.searchResults[index];
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
                                            .deleteCountryDetails(items.id);
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
                                  controller.countryNameController.text =
                                      controller.country_master_items[index]
                                              .name ??
                                          "";
                                  controller.countryCodeController.text =
                                      controller.country_master_items[index]
                                              .countryCode ??
                                          "";

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Form(
                                        key: formKey,
                                        child: CustomPopup(
                                            title: "Edit Country",
                                            onCancelPressed: () {
                                              Get.back();
                                              controller.countryCodeController
                                                  .clear();
                                              controller.countryNameController
                                                  .clear();
                                            },
                                            onUpdatePressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                print(
                                                    'pressed button entering to controller');
                                                controller.editCountryDetails(
                                                    id: controller
                                                            .country_master_items[
                                                                index]
                                                            .id ??
                                                        0,
                                                    delete: controller
                                                            .country_master_items[
                                                                index]
                                                            .deleted ??
                                                        '');
                                                Get.back();

                                                controller.countryCodeController
                                                    .clear();
                                                controller.countryNameController
                                                    .clear();
                                              } else {
                                                print(
                                                    "Not validated-------- error---");
                                              }
                                            },
                                            saveButtonText: "Edit",
                                            children: [
                                              CustomTextField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter country name';
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: controller
                                                      .countryNameController,
                                                  label: 'Country Name'),
                                              CustomTextField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter country code';
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: controller
                                                      .countryCodeController,
                                                  label: "Country code")
                                            ]),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[50],
                                    boxShadow: kElevationToShadow[1],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "Name : ${items.name}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text(
                                      "Country Code : ${items.countryCode ?? ""}",
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
                                              controller.countryNameController
                                                  .text = controller
                                                      .country_master_items[
                                                          index]
                                                      .name ??
                                                  "";
                                              controller.countryCodeController
                                                  .text = controller
                                                      .country_master_items[
                                                          index]
                                                      .countryCode ??
                                                  "";

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Form(
                                                    key: formKey,
                                                    child: CustomPopup(
                                                        title: "Edit Country",
                                                        onCancelPressed: () {
                                                          Get.back();
                                                          controller
                                                              .countryCodeController
                                                              .clear();
                                                          controller
                                                              .countryNameController
                                                              .clear();
                                                        },
                                                        onUpdatePressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            print(
                                                                'pressed button entering to controller');
                                                            controller.editCountryDetails(
                                                                id: controller
                                                                        .country_master_items[
                                                                            index]
                                                                        .id ??
                                                                    0,
                                                                delete: controller
                                                                        .country_master_items[
                                                                            index]
                                                                        .deleted ??
                                                                    '');
                                                            Get.back();

                                                            controller
                                                                .countryCodeController
                                                                .clear();
                                                            controller
                                                                .countryNameController
                                                                .clear();
                                                          } else {
                                                            print(
                                                                "Not validated-------- error---");
                                                          }
                                                        },
                                                        saveButtonText: "Edit",
                                                        children: [
                                                          CustomTextField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please Enter country name';
                                                                }
                                                                return null;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              obscure: false,
                                                              controller: controller
                                                                  .countryNameController,
                                                              label:
                                                                  'Country Name'),
                                                          CustomTextField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please Enter country code';
                                                                }
                                                                return null;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              obscure: false,
                                                              controller: controller
                                                                  .countryCodeController,
                                                              label:
                                                                  "Country code")
                                                        ]),
                                                  );
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
                                                      .deleteCountryDetails(
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
                                key: formKey,
                                child: CustomPopup(
                                    title: "Add Your Country",
                                    onCancelPressed: () {
                                      Get.back();
                                      controller.countryCodeController.clear();
                                      controller.countryNameController.clear();
                                    },
                                    onUpdatePressed: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.postCountryDetails();
                                      } else {
                                        print('not validated------save');
                                      }
                                    },
                                    saveButtonText: "Add",
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter country name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              controller.countryNameController,
                                          label: 'Country Name'),
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter country code';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              controller.countryCodeController,
                                          label: "Country code")
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
                              'Add Country',
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
