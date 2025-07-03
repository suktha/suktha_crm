// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/controllers/get_service_master_controller.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Service%20Master/Add%20Service%20Master/add_service_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/filter_list.dart';
import 'package:work_Force/view/widget/shimmer_loading.dart';

class ServiceMasterScreen extends StatefulWidget {
  ServiceMasterScreen({
    super.key,
  });

  @override
  State<ServiceMasterScreen> createState() => _ServiceMasterScreenState();
}

class _ServiceMasterScreenState extends State<ServiceMasterScreen> {
  final controller = Get.put(GetServiceMasterController());
  final scrollcontroller = ScrollController();

  final FocusNode _focusNode = FocusNode();

  int page = 0;

  @override
  void initState() {
    super.initState();
// controller.ServiceMasteritem.clear();
    controller.getServiceMasterlist("", 0, "desc", "name", false);

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.offset) {
        controller.listLoad.value = false;
        setState(() {
          page++;
          controller.getServiceMasterlist(
              controller.searchValue.value,
              page,
              controller.sortdirection.value,
              controller.sortwith.value,
              controller.isFilter.value);
          print("hello");
          print(page);
          print("searchvalue --- ${controller.searchValue.value}");
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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              title: const Text("Service Master"),
              titleTextStyle: TextStyle(
                  color: kColorblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.sp),
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
                      controller.ServiceMasteritem.clear();
                      controller.getServiceMasterlist(
                          "", 0, "desc", "name", false);
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
                      duration: const Duration(milliseconds: 700));
                  controller.ServiceMasteritem.clear();
                  controller.searchController.clear();
                  controller.searchValue.value = "";
                  // Get.to(() => MasterScreen(context), transition: Transition.fade, duration: Duration(milliseconds: 600));
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
                                  controller.getServiceMasterlist(
                                      controller.searchValue.value,
                                      page,
                                      controller.sortdirection.value,
                                      controller.sortwith.value,
                                      controller.isFilter.value);
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Search Here',
                                  hintStyle: TextStyle(color: kColorgrey),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                    if (controller
                                        .searchController.text.isEmpty) {
                                      _focusNode.unfocus();
                                      controller.searchValue.value = "";
                                      controller.listLoad.value = false;
                                      controller.hasMore.value = true;
                                      page = 0;
                                      controller.ServiceMasteritem.clear();
                                      controller.getServiceMasterlist(
                                          '',
                                          page,
                                          controller.sortdirection.value,
                                          controller.sortwith.value,
                                          controller.isFilter.value);
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
                      : controller.ServiceMasteritem.isEmpty
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeIn(
                                      delay: const Duration(milliseconds: 300),
                                      duration:
                                          const Duration(milliseconds: 300),
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
                                      "Your Service Master is Empty",
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
                                      controller.ServiceMasteritem.clear();
                                      controller.getServiceMasterlist(
                                          "", page, "desc", "name", false);
                                    },
                                  );
                                },
                                child: Obx(() => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                                // thickness: 1,
                                                color: kColorgrey,
                                              ),
                                          controller: scrollcontroller,
                                          itemCount: controller
                                                  .ServiceMasteritem.length +
                                              1,
                                          itemBuilder: (context, index) {
                                            if (index <
                                                controller
                                                    .ServiceMasteritem.length) {
                                              final item = controller
                                                  .ServiceMasteritem[index];

                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    AddServiceMasterScreen(
                                                      isEdit: true,
                                                      serviceMasterSavedValue:
                                                          item,
                                                      indexes: index,
                                                    ),
                                                    transition: Transition.fade,
                                                    duration: const Duration(
                                                        milliseconds: 600),
                                                  );
                                                },
                                                onLongPress: () {
                                                  customDeleteAlertDialogue(
                                                      context, () {
                                                    controller.deletePoList(
                                                      false,
                                                      item,
                                                    );

                                                    Get.back();
                                                  });
                                                },
                                                child: ListTile(
                                                  title: Text(item.name!,
                                                      style: TextStyle(
                                                          fontSize: 16.5.sp,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  // leading:  FutureBuilder<Uint8List>(
                                                  //   future: quotationController.getMaterialImage(item.id!),
                                                  //   builder: (context, snapshot) {
                                                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                                                  //       return CircularProgressIndicator();
                                                  //     } else if (snapshot.hasError) {
                                                  //       return Icon(Icons.error);
                                                  //     } else if (snapshot.hasData) {
                                                  //       return CircleAvatar(
                                                  //         backgroundImage: MemoryImage(
                                                  //           snapshot.data!,
                                                  //         ),
                                                  //       );
                                                  //     } else {
                                                  //       // Handle the case when snapshot has no data
                                                  //       return Text('No image data available');
                                                  //     }
                                                  //   },
                                                  // ),
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        kColorLightGrey,
                                                    child: Text(
                                                      item.name != ""
                                                          ? item.name!
                                                              .split(" ")
                                                              .where((word) =>
                                                                  word
                                                                      .isNotEmpty)
                                                              .map((word) => word[
                                                                      0]
                                                                  .toUpperCase())
                                                              .take(2)
                                                              .join()
                                                          : "",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kColorblack),
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                      item.price == null
                                                          ? "₹0.00"
                                                          : "₹${item.price}",
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      item.serviceType == 1
                                                          ? const SizedBox
                                                              .shrink()
                                                          : const Icon(
                                                              Icons.loop,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                      IconButton(
                                                          onPressed: () {
                                                            // print(item.subscriptionBasedServices![index]);
                                                            Get.to(
                                                              AddServiceMasterScreen(
                                                                isEdit: true,
                                                                serviceMasterSavedValue:
                                                                    item,
                                                                indexes: index,
                                                              ),
                                                              transition:
                                                                  Transition
                                                                      .fade,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          600),
                                                            );
                                                            // if (item.subscriptionBasedServices != null && item.subscriptionBasedServices!.length > index) {
                                                            //   var subItem = item.subscriptionBasedServices![index];

                                                            // } else {
                                                            //   print("subscriptionBasedServices is null or index is out of range");
                                                            // }
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit)),
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
                                                // child: CustomListCard(
                                                //   popup: Container(),

                                                //   title1: "Name: ${item.name ?? ""}", // qtn number,

                                                //   date2: item.specification ?? "",

                                                //   name3: "Price: ${item.price ?? ""}", //name

                                                //   amount: "", //  grand total amount,

                                                //   statusName: "", //status

                                                //   editIcon: () {
                                                // Get.to(
                                                //  AddServiceMasterScreen(
                                                //       isEdit: true,
                                                //       serviceMasterSavedValue: item,
                                                //     ),
                                                //     transition: Transition.fade,
                                                //     duration: Duration(milliseconds: 600));
                                                //   },
                                                //   bgColor: kColorblack,
                                                //   printIcon: () async {},

                                                //   shareIcon: () async {},
                                                //   emailIcon: () {},
                                                // ),
                                              );
                                            } else {
                                              return Center(
                                                child: controller.hasMore.value
                                                    ? const CircularProgressIndicator()
                                                    : const Text(
                                                        "No more data to Load"),
                                              );
                                            }
                                          }),
                                    )),
                              ),
                            ),
                ),
                Stack(
                  children: [
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                              AddServiceMasterScreen(
                                isEdit: false,
                              ),
                              transition: Transition.fade,
                              duration: const Duration(milliseconds: 600));
                        },
                        child: Container(
                          width: 60.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[1],
                              color: const Color.fromARGB(255, 58, 192, 255),
                              borderRadius: BorderRadius.circular(4.w)),
                          child: Center(
                            child: Text(
                              "Create Service Master",
                              style: TextStyle(
                                  color: kColorwhite,
                                  fontSize: 16.5.sp,
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
        ),
        Obx(() => loadingScreenWithText(
            isPageLoading: controller.isPageLoading.value)),
      ],
    );
  }

  Future<dynamic> customFilterMethod(BuildContext context) {
    return CustomFilterList(
      context: context,
      isStatusNeeded: false,
      customList: [],
      sortColumnList: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Service Name",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 7.w,
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
              "Price",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 7.w,
              child: Obx(() => Radio(
                    value: "price",
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
              "Service Type",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 7.w,
              child: Obx(() => Radio(
                    value: "Service Type",
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
        controller.ServiceMasteritem.clear();

        print(controller.selectedStatuses);

        controller.sortDirection.value == true
            ? controller.sortdirection.value = "desc"
            : controller.sortdirection.value = "asc";

        if (controller.selectedRadio.value == "price") {
          controller.sortwith.value = "price";
        } else if (controller.selectedRadio.value == "name") {
          controller.sortwith.value = "name";
        } else if (controller.selectedRadio.value == "Service Type") {
          controller.sortwith.value = "serviceTypeName";
        }

        print("Is selected bool --- -----${controller.isFilter.value}");

        page = 0;
        print("search name --------${controller.searchValue.value}");
        controller.getServiceMasterlist(
            controller.searchValue.value,
            page,
            controller.sortdirection.value,
            controller.sortwith.value,
            controller.isFilter.value);
        Get.back();
      },
      ontapClose: () {
        controller.sortDirection.value = true;
        controller.selectedRadio.value = "";
        controller.isFilter.value = false;
        controller.selectedStatuses.clear();
        page = 0;
        controller.getServiceMasterlist("", page, "desc", "name", false);
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
