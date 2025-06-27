// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/widget/custom_dropdown.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

class ForeignStateMasterScreen extends StatefulWidget {
  const ForeignStateMasterScreen({super.key});

  @override
  State<ForeignStateMasterScreen> createState() =>
      _ForeignStateMasterScreenState();
}

class _ForeignStateMasterScreenState extends State<ForeignStateMasterScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // int? countryId;

  @override
  void initState() {
    super.initState();
    // controller.getForiegnStateDetails();
    // controller.getCountryDetails("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: const Text("Foreign state Master"),
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResultsForeignState.clear();
                    await controller.getForiegnStateDetails();
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
              () => controller.searchResultsForeignState.isEmpty
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
                              "Your Foreign State Master is Empty ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
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
                      itemCount: controller.searchResultsForeignState.length,
                      itemBuilder: (context, index) {
                        var item = controller.searchResultsForeignState[index];

                        var countryValue = controller.country_master_items
                            .firstWhere(
                                (element) => element.id == item.countryId);

                        var countryName = countryValue.name;
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
                                          .deleteForeignStateDetails(item.id);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                // height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[50],
                                  boxShadow: kElevationToShadow[1],
                                ),
                                // height: 40,
                                child: ListTile(
                                  title: Text(
                                    "State : ${item.name}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    "Country : ${countryName ?? ""}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Container(
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
                                                .deleteForeignStateDetails(
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
                                    title: "Add Your State",
                                    onCancelPressed: () {
                                      Get.back();
                                      controller.foreignStateController.clear();
                                      controller.countryNameController.clear();
                                      controller.countryId.value = 0;
                                      controller.countryName.value = "";
                                    },
                                    onUpdatePressed: () {
                                      if (formkey.currentState!.validate()) {
                                        controller.postForeignStatedDetails(
                                            controller.countryId.value);
                                      } else {
                                        print("Not validated");
                                      }
                                    },
                                    saveButtonText: 'Add',
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter state name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              controller.foreignStateController,
                                          label: 'State Name'),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Obx(() => CustomDropdown(
                                            value: controller.countryName.value,
                                            items: controller
                                                .country_master_items
                                                .map((e) => e.name!)
                                                .where((element) =>
                                                    element != "India")
                                                .toList(),
                                            hintText: "Select Country",
                                            onChanged: (value) {
                                              controller.countryName.value =
                                                  value!;
                                              controller
                                                  .countryId.value = controller
                                                      .country_master_items
                                                      .firstWhere((element) =>
                                                          element.name == value)
                                                      .id ??
                                                  0;
                                            })),
                                      ),
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
                              'Add Foreign state',
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
