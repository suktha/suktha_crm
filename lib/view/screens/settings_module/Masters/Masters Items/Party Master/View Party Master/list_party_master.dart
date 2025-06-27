// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/controllers/get_party_master_controller.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/open_party_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/filter_list.dart';
import 'package:work_Force/view/widget/shimmer_loading.dart';
import '../../../Masters Screen.dart';
import '../Add Party Master/party_master_add.dart';

class PartyMasterScreen extends StatefulWidget {
  PartyMasterScreen({
    super.key,
  });

  @override
  State<PartyMasterScreen> createState() => _PartyMasterScreenState();
}

class _PartyMasterScreenState extends State<PartyMasterScreen> {
  final controller = Get.put(GetPartyMasterController());
  // final cashVouchercontroller = Get.put(GetCashVoucherController());
  // final chequeVouchercontroller = Get.put(GetChequeVoucherController());

  final partyController = Get.put(PartyMasterController());
  final scrollcontroller = ScrollController();

  final FocusNode _focusNode = FocusNode();

  int page = 0;

  @override
  void initState() {
    super.initState();
    controller.getPartyMasterlist("", 0, "asc", "name", false);
    partyController.getNewSupplierTransactionItems();
    partyController.getNewCustomerTransactionItems();

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.offset) {
        controller.listLoad.value = false;
        setState(() {
          page++;

          controller.getPartyMasterlist(
              controller.searchValue.value,
              page,
              controller.sortdirection.value,
              controller.sortwith.value,
              controller.isFilter.value);
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
              title: const Text("Party Master"),
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
                      controller.searchValue.value = "";
                      controller.searchController.clear();
                      page = 0;
                      controller.partyMasterList.clear();
                      controller.getPartyMasterlist(
                          "", page, "asc", "name", false);

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
                  controller.partyMasterList.clear();
                  controller.searchValue.value = "";
                  controller.searchController.clear();
                  Get.offAll(
                      () => const BottomNavigationMainscreen(
                            initialIndex: 2,
                          ),
                      transition: Transition.fade,
                      duration:
                          const Duration(milliseconds: 700)); // Get.back();
                }),
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                                  page = 0;
                                  controller.getPartyMasterlist(
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
                                      controller.partyMasterList.clear();
                                      controller.getPartyMasterlist(
                                          "",
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
                      ? HomeLoading()
                      : controller.partyMasterList.isEmpty
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeIn(
                                      delay: const Duration(milliseconds: 300),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: LottieBuilder.asset(
                                          "assets/lottie/empty.json",height: 15.h,)),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  FadeIn(
                                    delay: const Duration(milliseconds: 500),
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      "Your Party Master is Empty",
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
                                      controller.partyMasterList.clear();
                                      controller.getPartyMasterlist(
                                          "",
                                          page,
                                          controller.sortdirection.value,
                                          controller.sortwith.value,
                                          controller.isFilter.value);
                                    },
                                  );
                                },
                                child: Obx(
                                  () => ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                            thickness: 1, color: kColorgrey),
                                    controller: scrollcontroller,
                                    itemCount:
                                        controller.partyMasterList.length + 1,
                                    itemBuilder: (context, index) {
                                      print(
                                          "lenght of the list${controller.partyMasterList.length}");
                                      if (index <
                                          controller.partyMasterList.length) {
                                        final item = controller
                                            .partyMasterList[index].partyDTO;

                                        return GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  OpenPartyMasterScreen(
                                                    partyMasterSavedValue:
                                                        controller
                                                                .partyMasterList[
                                                            index],
                                                    contexts: context,
                                                  ),
                                                  transition: Transition.fade,
                                                  duration: const Duration(
                                                      milliseconds: 600));
                                            },
                                            onLongPress: () {
                                              customDeleteAlertDialogue(context,
                                                  () {
                                                controller
                                                    .deletePartyMasterList(
                                                        false, item);

                                                Get.back();
                                              });
                                            },
                                            child: Container(
                                              color: kColorwhite,
                                              // height: 26.h,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 4.h,
                                                    left: 4.w,
                                                    right: 2.h),
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
                                                              "No: ${item!.partyCode ?? ""}", // qtn number,,
                                                              style: TextStyle(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                  fontSize:
                                                                      15.5.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(height: 1.h),

                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 70.w,
                                                          child: Text(
                                                            item.name ?? "Party Name", //name
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        SizedBox(
                                                          // width: 20.w,
                                                          child: Text(
                                                            item.partyTypeName
                                                                .toString(), //grand total amount ,
                                                            style: TextStyle(
                                                                fontSize: 15.5.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ), //Date
                                                    SizedBox(height: 1.h),
                                                    item.contactPersonNumber !=
                                                                "" &&
                                                            item.contactPersonNumber !=
                                                                null
                                                        ? Row(
                                                            children: [
                                                              Icon(Icons.call,
                                                                  size: 15.sp),
                                                              SizedBox(
                                                                width: 1.h,
                                                              ),
                                                              Text(item
                                                                      .contactPersonNumber ??
                                                                  ""), // mobile number
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    SizedBox(height: 1.h),

                                                    item.email != "" &&
                                                            item.email
                                                                    ?.split(
                                                                        ".com")
                                                                    .first !=
                                                                "notnull@notnull"
                                                        ? Row(
                                                            children: [
                                                              Icon(
                                                                Icons.mail,
                                                                size: 15.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 1.h,
                                                              ),
                                                              Text(
                                                                item.email
                                                                            ?.split(
                                                                                ".com")
                                                                            .first ==
                                                                        "notnull@notnull"
                                                                    ? ""
                                                                    : item.email ==
                                                                            null
                                                                        ? ""
                                                                        : item.email ==
                                                                                ""
                                                                            ? ""
                                                                            : item.email.toString(),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox(),

                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 1.h),
                                                      decoration: BoxDecoration(
                                                        gradient: const LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  229,
                                                                  246,
                                                                  255),
                                                              Color.fromARGB(
                                                                  255,
                                                                  246,
                                                                  246,
                                                                  246)
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.w),
                                                        color: kColorwhite,
                                                        // boxShadow: kElevationToShadow[8]
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                controller
                                                                    .isPageLoading
                                                                    .value = true;

                                                                print(
                                                                    "----price----${controller.partyMasterList[index].materialPriceListDTOList!.length}");
                                                                print(
                                                                    "----bank----${controller.partyMasterList[index].partyBankMapDTOList!.length}");

                                                                Get.to(
                                                                    AddPartyMasterScreen(
                                                                      isEdit:
                                                                          true,
                                                                      partyMasterSaved:
                                                                          item,
                                                                      bankList: controller
                                                                          .partyMasterList[
                                                                              index]
                                                                          .partyBankMapDTOList,
                                                                      priceList: controller
                                                                          .partyMasterList[
                                                                              index]
                                                                          .materialPriceListDTOList,
                                                                      contactList: controller
                                                                          .partyMasterList[
                                                                              index]
                                                                          .partyContactDetails,
                                                                      termsAndConditionValue: controller
                                                                          .partyMasterList[
                                                                              index]
                                                                          .termsAndConditions,
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
                                                                color:
                                                                    kColorblack,
                                                              )),
                                                          SizedBox(
                                                            width: 3.h,
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                customDeleteAlertDialogue(
                                                                    context,
                                                                    () {
                                                                  // controller.deletePartyMasterList(false, item);

                                                                  Get.back();
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              )),
                                                          const Spacer(),
                                                          PopupMenuButton(
                                                            icon: Icon(
                                                              Icons.menu,
                                                              color:
                                                                  kColorblack,
                                                            ),
                                                            itemBuilder:
                                                                (context) => [
                                                             
                                                              PopupMenuItem(
                                                                onTap: () {
                                                                  controller
                                                                      .isPageLoading
                                                                      .value = true;

                                                                  print(
                                                                      "----price----${controller.partyMasterList[index].materialPriceListDTOList!.length}");
                                                                  print(
                                                                      "----bank----${controller.partyMasterList[index].partyBankMapDTOList!.length}");

                                                                  Get.to(
                                                                      AddPartyMasterScreen(
                                                                        isEdit:
                                                                            true,
                                                                        partyMasterSaved:
                                                                            item,
                                                                        bankList: controller
                                                                            .partyMasterList[index]
                                                                            .partyBankMapDTOList,
                                                                        priceList: controller
                                                                            .partyMasterList[index]
                                                                            .materialPriceListDTOList,
                                                                        contactList: controller
                                                                            .partyMasterList[index]
                                                                            .partyContactDetails,
                                                                        termsAndConditionValue: controller
                                                                            .partyMasterList[index]
                                                                            .termsAndConditions,
                                                                      ),
                                                                      transition:
                                                                          Transition
                                                                              .fade,
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              600));
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color:
                                                                            kColorblack),
                                                                    SizedBox(
                                                                      width:
                                                                          2.h,
                                                                    ),
                                                                    const Text(
                                                                        "Edit"),
                                                                  ],
                                                                ),
                                                              ),
                                                              PopupMenuItem(
                                                                onTap: () {
                                                                  customDeleteAlertDialogue(
                                                                      context,
                                                                      () {
                                                                    // controller.deletePartyMasterList(false, item);

                                                                    Get.back();
                                                                  });
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color:
                                                                            kColorblack),
                                                                    SizedBox(
                                                                      width:
                                                                          2.h,
                                                                    ),
                                                                    const Text(
                                                                        "Delete"),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          )
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
                                              : const Text(
                                                  "No more data to Load"),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                ),
                Stack(
                  children: [
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                              AddPartyMasterScreen(
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
                              "Create Party Master",
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
        ),
        Obx(() => loadingScreenWithText(
            isPageLoading: controller.isPageLoading.value)),
      ],
    );
  }

  // addCreateNewTransaction(PartyMasterController controller, PartyDTO? item) async {
  //   print("id---${controller.newTranTypeId.value}");
  //   if (controller.newTranTypeId.value == "1") {
  //     print("--1-inside");

  //     print("----inside for tax invoice customer id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     //customer Invoice

  //     Get.to(
  //         () => TaxInvoiceDetailScreen(
  //               isCreateproforma: false,
  //               isCreatePo: false,
  //               isEdit: false,
  //               isClone: false,
  //               isCreateDc: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));

  //     // Get.back();
  //     // } else {
  //     //   customSnackbar("Can't Edit", " '${controller.taxInvoiceitems[index].statusName}' Quoatation can't edit", "normal");
  //   } else if (controller.newTranTypeId.value == "18") {
  //     print("-2--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SubcontractingInvoiceDetailScreen(
  //               isCreateproforma: false,
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateDc: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "19") {
  //     print("--3-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => ProformaInvoiceDetailScreen(
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateDc: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "32") {
  //     print("--4-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => JobworkProformaInvoiceDetailScreen(
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateDc: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "33") {
  //     print("--5-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SubcontractingProformaInvoiceDetailScreen(
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateDc: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "7") {
  //     print("--6-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => DcAddScreen(
  //               isEdit: false,
  //               isCreateDc: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "14") {
  //     print("--7-inside");

  //     print("----inside for id--${item!.name.toString()}");
  //     Get.to(
  //         () => JobworkOutDcAddScreen(
  //               isCreateInDc: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));

  //     // controller.getInvoicedetails(item!.id.toString());

  //     // Get.to(
  //     //     () => JobworkOutDcAddScreen(
  //     //           isCreateInDc: false,
  //     //           isEdit: false,
  //     //           isCreateFromPartyMaster: true,
  //     //           partyMasterSaved: item,
  //     //           dcNumber: taxcontroller.taxInvoiceTransactionNumber!.responseString,
  //     //           // partyMasterSaved: controller.itemDatas,
  //     //         ),
  //     //     transition: Transition.fade,
  //     //     duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "13") {
  //     print("-8--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => JobworkInDcAddScreen(
  //               isEdit: false,
  //               isCreateDc: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "16") {
  //     print("-9--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SubcontractingOutDcAddScreen(
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "17") {
  //     print("-sub in dc--inside");
  //     print("----inside for id--${item!.name.toString()}");
  //     Get.to(
  //       () => SubcontractingInDcAddScreen(
  //         isEdit: false,
  //         isCreateOutDc: false,
  //         isCreateFromPartyMaster: true,
  //         partyMasterSaved: item,
  //       ),
  //       transition: Transition.fade,
  //       duration: Duration(milliseconds: 600),
  //     );

  //     // controller.getInvoicedetails(item!.id.toString());
  //   } else if (controller.newTranTypeId.value == "15") {
  //     print("--10-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     //jobwork Invoice

  //     Get.to(
  //         () => JobworkInvoiceDetailScreen(
  //               isCreateDc: false,
  //               isCreatePo: false,
  //               isCreateproforma: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "3") {
  //     print("-11--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => CustomerReceiptsDetailScreen(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               isCreateDc: false,
  //               isCreatePo: false,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "11") {
  //     print("---12-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => PurchaseOrderDetailsScreen(
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "20") {
  //     print("-13--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => JobWorkPOdetailsScreen(
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "21") {
  //     print("--14-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SubcontractingPOdetailsScreen(
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "22") {
  //     print("-15--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => CashVoucherAddScreen(
  //               isEdit: false,
  //               transactionNumber: cashVouchercontroller.cashVoucherTransactionNumber!.responseString!,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "23") {
  //     Get.to(
  //         () => ChequeVoucherAddScreen(
  //               isEdit: false,
  //               transactionNumber: chequeVouchercontroller.chequeVoucherTransactionNumber!.responseString!,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "9") {
  //     print("-16--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => CreditNoteDetailScreen(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "28") {
  //     print("-17--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => JobWorkCreditNoteDetailScreen(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "29") {
  //     print("--18-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SubcontractDebitNoteDetailScreen(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "12") {
  //     print("---19-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => QuotationAdd(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "30") {
  //     print("--20-inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => JobWorkQuotationAdd(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "31") {
  //     print("-21--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SubcontractingQuotationAdd(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "2") {
  //     print("SSupplier po");
  //     print("-22--inside");

  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SupplierPoDetailScreen(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "4") {
  //     print("SSupplier payment");
  //     print("----inside for id--${item!.name.toString()}");
  //     print("-23--inside");
  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => SupplierPaymentDetailScreen(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               isCreateDc: false,
  //               isCreatePo: false,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "10") {
  //     print("Debit Note ---");
  //     print("----inside for id--${item!.name.toString()}");
  //     print("-24--inside");
  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => DebitNoteDetailScreen(
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "6") {
  //     print("Incoming dc --- ");
  //     print("-25--inside");
  //     print("----inside for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => IncomingDcAddScreen(
  //               isCreateDc: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   } else if (controller.newTranTypeId.value == "5") {
  //     print(" Purchase Invoice --- ");
  //     print("----inside 26 for id--${item!.name.toString()}");

  //     // controller.getInvoicedetails(item!.id.toString());

  //     Get.to(
  //         () => PurchaseInvoiceDetailScreen(
  //               isCreateGrn: false,
  //               isCreatePo: false,
  //               isEdit: false,
  //               isCreateFromPartyMaster: true,
  //               partyMasterSaved: item,
  //               // partyMasterSaved: controller.itemDatas,
  //             ),
  //         transition: Transition.fade,
  //         duration: Duration(milliseconds: 600));
  //   }
  // }

  Future<dynamic> customCreateTranscationDialog(
      BuildContext context, VoidCallback itemAddButton) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
          title: const Text("select transaction type"),
          content: SizedBox(
            height: 10.h,
            child: Column(
              children: [
                Obx(
                  () => Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5, top: 10),
                    child: SizedBox(
                        // width: 30.w,
                        height: 6.h,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: const Divider(
                            color: Color.fromARGB(255, 220, 220, 220),
                            thickness: 1,
                            height: 1,
                          ),
                          value: partyController.newTranTypeId.value,
                          items: [
                            const DropdownMenuItem<String>(
                              value: "",
                              child: Text("Create New Transaction"),
                            ),
                            ...partyController.createNewTramsactionList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.id.toString(),
                                      child: Text(
                                        "${item.name}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              partyController.newTranTypeId.value = newValue!;

                              print(partyController.newTranTypeId.value);

                              partyController
                                      .newTransactionTypeController.text =
                                  partyController.createNewTramsactionList
                                      .firstWhere((item) =>
                                          item.id.toString() ==
                                          partyController.newTranTypeId.value)
                                      .name!;

                              print(partyController
                                  .newTransactionTypeController.text);
                            });
                          },
                          hint: const Text('Select an item'),
                        )),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                    backgroundColor: kColorwhite),
                onPressed: () {
                  partyController.newTranTypeId.value = "";
                  partyController.newTransactionTypeController.clear();
                  partyController.createNewTramsactionList.clear();
                  Get.back();
                },
                child: Text(
                  "Back",
                  style: TextStyle(color: kColorblack),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                ),
                onPressed: itemAddButton,
                child: const Text("Add"))
          ],
        );
      },
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
              "PartyType",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 5.w,
              child: Obx(() => Radio(
                    value: "partyTypeName",
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
              "Customer Name",
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
              "Party Code",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 5.w,
              child: Obx(() => Radio(
                    value: "partyCode",
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
              "Contact Number",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 5.w,
              child: Obx(() => Radio(
                    value: "contactPersonNumber",
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
        controller.isPageLoading.value = true;
        controller.partyMasterList.clear();

        print(controller.selectedStatuses);

        controller.sortDirection.value == true
            ? controller.sortdirection.value = "desc"
            : controller.sortdirection.value = "asc";

        if (controller.selectedRadio.value == "contactPersonNumber") {
          controller.sortwith.value = "contactPersonNumber";
        } else if (controller.selectedRadio.value == "partyCode") {
          controller.sortwith.value = "partyCode";
        } else if (controller.selectedRadio.value == "name") {
          controller.sortwith.value = "name";
        } else if (controller.selectedRadio.value == "partyTypeName") {
          controller.sortwith.value = "partyTypeName";
        }

        print("Is selected bool --- -----${controller.isFilter.value}");

        page = 0;

        controller.getPartyMasterlist(
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

        controller.getPartyMasterlist("", 1, "desc", "name", false);
        Get.back(); //clear button
      },
    );
  }

  void scrollUp() {
    final double start = 0;
    scrollcontroller.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}
