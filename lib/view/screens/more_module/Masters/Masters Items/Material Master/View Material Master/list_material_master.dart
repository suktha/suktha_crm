// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/controllers/get_material_master_controller.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Material%20Master/Add%20Material%20Master/material_master_add.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Material%20Master/View%20Material%20Master/open_material_master.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/filter_list.dart';
import 'package:work_Force/view/widget/shimmer_loading.dart';

class MaterialMasterScreen extends StatefulWidget {
  const MaterialMasterScreen({
    super.key,
  });

  @override
  State<MaterialMasterScreen> createState() => _MaterialMasterScreenState();
}

class _MaterialMasterScreenState extends State<MaterialMasterScreen> {
  final controller = Get.put(GetMaterialMasterController());
  final scrollcontroller = ScrollController();
  final FocusNode _focusNode = FocusNode();

  int page = 0;

  @override
  void initState() {
    super.initState();

    controller.getMaterialMasterlist("", page, "asc", "name", false, "0");

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.offset) {
        // controller.listLoad.value = false;
        setState(() {
          page++;
          controller.getMaterialMasterlist(
              controller.searchValue.value,
              page,
              controller.sortdirection.value,
              controller.sortwith.value,
              controller.isFilter.value,
              controller.materialsTypeId.value);
          print("hello");
          print(page);
          print("search value ====== ${controller.searchValue.value}");
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // toolbarHeight: 100.h,
          title: const Text("Material Master"),
          titleTextStyle: TextStyle(
              color: kColorblack,
              fontWeight: FontWeight.bold,
              fontSize: 19.5.sp),
          centerTitle: true,
          backgroundColor: kColorwhite,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  controller.listLoad.value = false;
                  controller.hasMore.value = true;
                  controller.searchController.clear();
                  controller.searchValue.value = "";
                  page = 0;
                  controller.materialMasteritem.clear();

                  controller.getMaterialMasterlist(
                      "", page, "asc", "name", false, "0");
                },
                icon: Icon(
                  Icons.refresh,
                  color: kColorblack,
                ))
          ],
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: kColorblack,
              size: 25.sp,
            ),
            onPressed: (() {
              Get.offAll(
                  () => const BottomNavigationMainscreen(
                        initialIndex: 2,
                      ),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 700)); // Get.back();
            }),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 6.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                      boxShadow: kElevationToShadow[4],
                      color: kColorwhite,
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            onTap: () {
                              setState(() {});
                            },
                            focusNode: _focusNode,
                            controller: controller.searchController,
                            onChanged: (value) {
                              controller.searchValue.value = value;
                              controller.getMaterialMasterlist(
                                  controller.searchValue.value,
                                  page,
                                  controller.sortdirection.value,
                                  controller.sortwith.value,
                                  controller.isFilter.value,
                                  controller.materialsTypeId.value);
                            },
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
                        Visibility(
                          visible: _focusNode.hasFocus,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                controller.searchController.clear();
                                _focusNode.unfocus();
                                if (controller.searchController.text.isEmpty) {
                                  _focusNode.unfocus();
                                  controller.searchValue.value = "";
                                  controller.listLoad.value = false;
                                  controller.hasMore.value = true;
                                  page = 0;
                                  controller.materialMasteritem.clear();
                                  controller.getMaterialMasterlist(
                                      '',
                                      page,
                                      controller.sortdirection.value,
                                      controller.sortwith.value,
                                      controller.isFilter.value,
                                      controller.materialsTypeId.value);
                                }
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      customFilterMethod(context);
                    },
                    icon: const Icon(Icons.filter_list),
                    iconSize: 20.sp,
                  )
                ],
              ),
            ),
            Obx(
              () => controller.loading.value == false
                  ? const HomeLoading()
                  : controller.materialMasteritem.isEmpty
                      ? Expanded(
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
                                  "Your Material Master is Empty",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              return Future.delayed(
                                const Duration(seconds: 1),
                                () {
                                  controller.listLoad.value = false;
                                  controller.hasMore.value = true;
                                  page = 0;
                                  controller.materialMasteritem.clear();
                                  controller.getMaterialMasterlist(
                                      "", page, "asc", "name", false, "0");
                                },
                              );
                            },
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(
                                      thickness: 1,
                                      color: kColorgrey,
                                    ),
                                controller: scrollcontroller,
                                itemCount:
                                    controller.materialMasteritem.length + 1,
                                itemBuilder: (context, index) {
                                  if (index <
                                      controller.materialMasteritem.length) {
                                    final item =
                                        controller.materialMasteritem[index];

                                    return GestureDetector(
                                        onTap: () {
                                          Get.to(
                                              OpenMaterialMasterScreen(
                                                contexts: context,
                                                materailMasterSavedValue: item,
                                              ),
                                              transition: Transition.fade,
                                              duration: const Duration(
                                                  milliseconds: 600));
                                        },
                                        onLongPress: () {
                                          customDeleteAlertDialogue(context,
                                              () {
                                            controller.deletePoList(
                                              false,
                                              item,
                                            );

                                            Get.back();
                                          });
                                        },
                                        child: Container(
                                          color: kColorwhite,
                                          // height: 26.h,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 4.h,
                                                left: 5.w,
                                                right: 4.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 50.w,
                                                        child: Text(
                                                          "Name: ${item.name ?? ""}", // qtn number,
                                                          style: TextStyle(
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 30.w,
                                                        child: Text(
                                                          "",
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 1.h,
                                                ),

                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      // width: 60.w,
                                                      child: Text(
                                                        item.materialTypeName ??
                                                            "Name", //name
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ), //Date
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  // mainAxisAlignment: MainAxisAlignment.,
                                                  children: [
                                                    Text(
                                                      "Stock: ${item.stock ?? "0.0"}",
                                                      style: TextStyle(
                                                          fontSize: 15.sp),
                                                    ), // mobile number
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),

                                                Row(
                                                  children: [
                                                    Text(
                                                      "Mrp: ${(item.mrp ?? "0.0")}",
                                                      style: TextStyle(
                                                          fontSize: 15.sp),
                                                    ),
                                                  ],
                                                ),
                                                // Divider(thickness: 2,),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Container(
                                                  // width: 100.w,
                                                  margin: EdgeInsets.only(
                                                      bottom: 1.h),
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                          Color.fromARGB(255,
                                                              229, 246, 255),
                                                          Color.fromARGB(255,
                                                              246, 246, 246)
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.w),
                                                    color: kColorwhite,
                                                    // boxShadow: kElevationToShadow[8]
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.to(
                                                                AddMaterialMasterScreen(
                                                                  isEdit: true,
                                                                  materialMasterSaved:
                                                                      item,
                                                                ),
                                                                transition:
                                                                    Transition
                                                                        .fade,
                                                                duration: const Duration(
                                                                    milliseconds:
                                                                        600));
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: kColorblack,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {
                                                            customDeleteAlertDialogue(
                                                                context, () {
                                                              controller
                                                                  .deletePoList(
                                                                false,
                                                                item,
                                                              );

                                                              Get.back();
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: kColorRed,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  } else {
                                    return Center(
                                      child: controller.hasMore.value
                                          ? const CircularProgressIndicator()
                                          : const Text("No more data to Load"),
                                    );
                                  }
                                }),
                          ),
                        ),
            ),
            Stack(
              children: [
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                          AddMaterialMasterScreen(
                            isEdit: false,
                          ),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 600));
                    },
                    child: Container(
                      width: 60.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[1],
                          color: const Color.fromARGB(255, 58, 192, 255),
                          borderRadius: BorderRadius.circular(4.w)),
                      child: Center(
                        child: Text(
                          "Create Material Master",
                          style: TextStyle(
                              color: kColorwhite,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
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
    );
  }

  Future<dynamic> customFilterMethod(BuildContext context) {
    return CustomFilterList(
      context: context,
      isStatusNeeded: false,
      customList: [
        SizedBox(
          height: 25.h,
          child: Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.materialTypeList.length,
                itemBuilder: (context, index) {
                  var item = controller.materialTypeList[index];
                  return SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name ?? "",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          width: 5.w,
                          child: Obx(() => Checkbox(
                                value: controller.ismaterialTypeSelected[index],
                                activeColor: Colors.lightBlue,
                                onChanged: (value) {
                                  controller.onStatusCheckboxChanged(
                                      index, value ?? false);
                                  controller.materialsTypeId.value =
                                      item.id.toString();
                                  print(
                                      "status id---- ${controller.materialsTypeId.value}");
                                },
                              )),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ),
      ],
      sortColumnList: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Material Name",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 5.w,
              child: Obx(() => Radio(
                    value: "name",
                    activeColor: Colors.lightBlue,
                    groupValue: controller.selectedRadio.value,
                    onChanged: (value) {
                      controller.onRadioSelected(value.toString());
                    },
                  )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Part Number",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 5.w,
              child: Obx(() => Radio(
                    value: "partNumber",
                    activeColor: Colors.lightBlue,
                    groupValue: controller.selectedRadio.value,
                    onChanged: (value) {
                      controller.onRadioSelected(value.toString());
                    },
                  )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Stock",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 5.w,
              child: Obx(() => Radio(
                    value: "stock",
                    activeColor: Colors.lightBlue,
                    groupValue: controller.selectedRadio.value,
                    onChanged: (value) {
                      controller.onRadioSelected(value.toString());
                    },
                  )),
            ),
          ],
        ),
      ],
      sortBy: controller.sortDirection,
      containerOnpressed: () {
        controller.containerOnpressed();
        print(
            "sortbool--- INITIAL TRUE--- Desc 1st ---${controller.sortDirection.value}");
      },
      confirmTap: () {
        // controller.isPageLoading.value = true;
        controller.materialMasteritem.clear();

        print(controller.selectedStatuses);

        controller.sortDirection.value == true
            ? controller.sortdirection.value = "desc"
            : controller.sortdirection.value = "asc";

        if (controller.selectedRadio.value == "stock") {
          controller.sortwith.value = "stock";
        } else if (controller.selectedRadio.value == "partNumber") {
          controller.sortwith.value = "partNumber";
        } else if (controller.selectedRadio.value == "name") {
          controller.sortwith.value = "name";
        }

        print("Is selected bool --- -----${controller.isFilter.value}");

        page = 0;
        print("search name --------${controller.searchValue.value}");
        controller.getMaterialMasterlist(
            controller.searchValue.value,
            page,
            controller.sortdirection.value,
            controller.sortwith.value,
            controller.isFilter.value,
            controller.materialsTypeId.value);
        Get.back();
      },
      ontapClose: () {
        controller.sortDirection.value = true;
        controller.selectedRadio.value = "";
        controller.isFilter.value = false;
        controller.selectedStatuses.clear();
        page = 0;
        controller.getMaterialMasterlist("", page, "desc", "name", false, "0");
        Get.back(); //clear button
      },
    );
  }

  void scrollUp() {
    double start = 0;
    scrollcontroller.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}
