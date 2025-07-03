import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/get_party_master_model.dart';
import 'package:work_Force/controllers/get_party_master_controller.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/list_party_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/icon_button.dart';
import '../Add Party Master/party_master_add.dart';

// ignore: must_be_immutable
class OpenPartyMasterScreen extends StatelessWidget {
  BuildContext? contexts;

  PartyWithPriceLists? partyMasterSavedValue;

  OpenPartyMasterScreen({
    super.key,
    this.partyMasterSavedValue,
    this.contexts,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetPartyMasterController());

    var gmail = partyMasterSavedValue!.partyDTO!.email ?? "";

    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(11.h),
            child: AppBar(
                toolbarHeight: 100.h,
                title: const Text("Party Master"),
                titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 19.sp),
                centerTitle: true,
                backgroundColor: kColortransparent,
                elevation: 0,
                
                leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: kColorblack,
                    size: 25.sp,
                  ),
                  onPressed: (() {
                    Get.to(() => PartyMasterScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 600));
                  }),
                )),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.h, left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.w), bottomRight: Radius.circular(16.w)),
                    boxShadow: kElevationToShadow[2],
                    gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      Color.fromARGB(255, 220, 246, 255),
                      Color.fromARGB(255, 62, 194, 255),
                    ])),
                height: 28.h,
                width: 100.w,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          // width: 70.w,
                          height: 4.h,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              partyMasterSavedValue!.partyDTO!.name ?? "", // party name
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   // width: 40.w,
                        //   height: 4.h,
                        //   child: Text(
                        //     "${                                            partyMasterSavedValue!.partyDTO!.partyTypeName : controller.partyMasterList[index!].partyTypeName}" ==
                        //             ""
                        //         ? ""
                        //         : "${                                            partyMasterSavedValue!.partyDTO!.partyTypeName : controller.partyMasterList[index!].partyTypeName}", //////quotation number
                        //     overflow: TextOverflow.ellipsis,
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w500, fontSize: 15.5.sp),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(
                            "Code: ${partyMasterSavedValue!.partyDTO!.partyCode}" == ""
                                ? ""
                                : "Code: ${partyMasterSavedValue!.partyDTO!.partyCode}",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.5.sp),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var url = Uri.parse("tel:${partyMasterSavedValue!.partyDTO!.contactPersonNumber!}");
                                urlLauncher.launchUrl(url);
                              },
                              child: SizedBox(
                                child: Text(
                                  partyMasterSavedValue!.partyDTO!.contactPersonNumber ?? "",
                                  style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w500, fontSize: 15.5.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 50.w,
                              height: 3.h,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  gmail.split(".com").first == "notnull@notnull"
                                      ? ""
                                      : gmail == "null"
                                          ? ""
                                          : gmail == ""
                                              ? ""
                                              : gmail.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.5.sp),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                child: Column(
                  children: [
                    Text(
                      "GST: ${partyMasterSavedValue!.partyDTO!.gstNumber ?? ""}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(
                            "Contact Name\n${partyMasterSavedValue!.partyDTO!.contactPersonName == "" ? "--" : partyMasterSavedValue!.partyDTO!.contactPersonName}",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.5.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            "Contact Number\n${partyMasterSavedValue!.partyDTO!.contactPersonNumber == "" ? "--" : partyMasterSavedValue!.partyDTO!.contactPersonNumber}",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.5.sp),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
                      margin: EdgeInsets.symmetric(vertical: 2.h),
                      // height: 15.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 237, 237, 237),
                          boxShadow: kElevationToShadow[2],
                          borderRadius: BorderRadius.circular(6.w)),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 20.w,
                                  child: const Text(
                                    "Address",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  partyMasterSavedValue!.partyDTO!.address ?? "",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 20.w,
                                  child: const Text(
                                    "Ship To Address ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  partyMasterSavedValue!.partyDTO!.billAddress ?? "",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 3.w),
                      child: customIconButton(
                          ontap: () {
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                              controller.isPageLoading.value = true;

                              Get.to(
                                  AddPartyMasterScreen(
                                    isEdit: true,
                                    bankList: partyMasterSavedValue!.partyBankMapDTOList,
                                    priceList: partyMasterSavedValue!.materialPriceListDTOList,
                                    partyMasterSaved: partyMasterSavedValue!.partyDTO,
                                    termsAndConditionValue: partyMasterSavedValue!.termsAndConditions,
                                  ),
                                  transition: Transition.fade,
                                  duration: const Duration(milliseconds: 600));
                            });
                          },
                          icon: Icons.edit,
                          bgcolor: Colors.lightBlue[500]),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                        width: 50.w,
                        title: "Back",
                        ontap: () {
                          Get.off(() => PartyMasterScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 600));
                        },
                        color: kColorwhite,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Obx(() => loadingScreenWithText(isPageLoading: controller.isPageLoading.value)),
      ],
    );
  }
}

class Itemscustom extends StatelessWidget {
  final String partName;
  final String price;
  final String itemsPlusamount;
  final String specification;

  const Itemscustom({super.key, required this.partName, required this.price, required this.itemsPlusamount, required this.specification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                partName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
            ),
            SizedBox(
              child: Text(
                price,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
            )
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            itemsPlusamount,
            style: TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            specification,
            style: TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
