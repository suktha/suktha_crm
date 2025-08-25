// ignore_for_file: must_be_immutable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/My_account/more_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/My_account/more_module/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

class BankMasterScreen extends StatefulWidget {
  const BankMasterScreen({super.key});

  @override
  State<BankMasterScreen> createState() => _BankMasterScreenState();
}

class _BankMasterScreenState extends State<BankMasterScreen> {
  final bankController = Get.put(GeneralMasterController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // bankController.getBankdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: const Text("Bank Master"),
            actions: [
              IconButton(
                  onPressed: () async {
                    bankController.searchController.clear();
                    bankController.search("");
                    bankController.searchResultsBank.clear();
                    await bankController.getBankdetails();
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
                              onChanged: (value) =>
                                  bankController.search(value),
                              controller: bankController.searchController,
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
                bankController.searchController.clear();
                bankController.search("");
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
            child: Obx(() {
              return bankController.searchResultsBank.isEmpty
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
                              "Your Bank Master is Empty ",
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
                      itemCount: bankController.searchResultsBank.length,
                      physics: const BouncingScrollPhysics(),
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var items = bankController.searchResultsBank[index];
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
                                      bankController
                                          .deleteBankDetails(items.id);
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
                                bankController.bankAddressController.text =
                                    bankController.bank_master_items[index]
                                            .bankAddress ??
                                        "";

                                bankController.bankNameController.text =
                                    bankController.bank_master_items[index]
                                            .bankname ??
                                        "";

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Form(
                                        key: formKey,
                                        child: CustomPopup(
                                            title: "Edit your Details",
                                            onCancelPressed: () {
                                              Get.back();
                                              bankController
                                                  .bankAddressController
                                                  .clear();
                                              bankController.bankNameController
                                                  .clear();
                                            },
                                            onUpdatePressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                bankController.editBankDetails(
                                                    id: bankController
                                                            .bank_master_items[
                                                                index]
                                                            .id ??
                                                        0,
                                                    delete: bankController
                                                            .bank_master_items[
                                                                index]
                                                            .deleted ??
                                                        '');
                                                Get.back();
                                                bankController
                                                    .bankAddressController
                                                    .clear();
                                                bankController
                                                    .bankNameController
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
                                                      return 'Please Enter Bankname';
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: bankController
                                                      .bankNameController,
                                                  label: "Bank Name"),
                                              CustomTextField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter Bankaddress';
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: bankController
                                                      .bankAddressController,
                                                  label: "Bank Address"),
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
                                    "Bank : ${items.bankname}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    "Address : ${items.bankAddress}",
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
                                            bankController
                                                .bankAddressController
                                                .text = bankController
                                                    .bank_master_items[index]
                                                    .bankAddress ??
                                                "";
                              
                                            bankController.bankNameController
                                                .text = bankController
                                                    .bank_master_items[index]
                                                    .bankname ??
                                                "";
                              
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Form(
                                                    key: formKey,
                                                    child: CustomPopup(
                                                        title:
                                                            "Edit your Details",
                                                        onCancelPressed: () {
                                                          Get.back();
                                                          bankController
                                                              .bankAddressController
                                                              .clear();
                                                          bankController
                                                              .bankNameController
                                                              .clear();
                                                        },
                                                        onUpdatePressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            bankController.editBankDetails(
                                                                id: bankController
                                                                        .bank_master_items[
                                                                            index]
                                                                        .id ??
                                                                    0,
                                                                delete: bankController
                                                                        .bank_master_items[
                                                                            index]
                                                                        .deleted ??
                                                                    '');
                                                            Get.back();
                                                            bankController
                                                                .bankAddressController
                                                                .clear();
                                                            bankController
                                                                .bankNameController
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
                                                                  return 'Please Enter Bankname';
                                                                }
                                                                return null;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              obscure: false,
                                                              controller:
                                                                  bankController
                                                                      .bankNameController,
                                                              label:
                                                                  "Bank Name"),
                                                          CustomTextField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please Enter Bankaddress';
                                                                }
                                                                return null;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              obscure: false,
                                                              controller:
                                                                  bankController
                                                                      .bankAddressController,
                                                              label:
                                                                  "Bank Address"),
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
                                            customDeleteAlertDialogue(context,
                                                () {
                                              bankController
                                                  .deleteBankDetails(
                                                      items.id);
                                              Get.back();
                                            });
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
            }),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                // height: 100,
                child: Center(
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Form(
                                key: formKey,
                                child: CustomPopup(
                                    title: "Add Your Bank",
                                    onCancelPressed: () {
                                      Get.back();
                                      bankController.bankAddressController
                                          .clear();
                                      bankController.bankNameController.clear();
                                    },
                                    onUpdatePressed: () {
                                      if (formKey.currentState!.validate()) {
                                        bankController.postBankDetails();
                                      } else {
                                        print("Not validated");
                                      }
                                    },
                                    saveButtonText: "Add",
                                    children: [
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Bankname';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller:
                                              bankController.bankNameController,
                                          label: 'Bank Name'),
                                      CustomTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Bankaddress';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: bankController
                                              .bankAddressController,
                                          label: 'Bank Address'),
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
                              'Add bank',
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
