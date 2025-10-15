import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/service_material_model.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/Service%20Master/Add%20Service%20Master/add_service_master.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/Service%20Master/View%20Service%20Master/list_service_master.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/icon_button.dart';

// ignore: must_be_immutable
class OpenServiceMasterScreen extends StatelessWidget {
  BuildContext? contexts;

  ServiceMaterialListModel? serviceMasterSavedValue;

  OpenServiceMasterScreen({
    super.key,
    this.serviceMasterSavedValue,
    this.contexts,
  });

  @override
  Widget build(BuildContext context) {

    // print(supplierPaymentSavedModel!.statusName);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text("Service Master"),
          titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 17.sp),
          centerTitle: true,
          backgroundColor: kColortransparent,
          elevation: 0,
          actions:const [
            // CreditNotePopUpMenu(
            //   ,
            //     controller: quotationController,
            //
            //     list: controller.supplierPaymentList,
            //     contexts: context,
            //     ispopupDelete: true)
          ],
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: kColorblack,
              size: 23.sp,
            ),
            onPressed: (() {
              Get.to(() => const ServiceMasterScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 600));
            }),
          )),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 14.h, left: 8.w, right: 8.w, bottom: 5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w), bottomRight: Radius.circular(10.w)),
                boxShadow: kElevationToShadow[2],
                gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                  Color.fromARGB(255, 220, 246, 255),
                  Color.fromARGB(255, 62, 194, 255),
                ])),
            // height: 28.h,
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // width: 40.w,
                  height: 3.h,
                  child: Text(
                    "Name : ${serviceMasterSavedValue!.name}" == "" ? "" : "Name : ${serviceMasterSavedValue!.name}", //////quotation number
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
                  ),
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
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          Get.to(
                            AddServiceMasterScreen(
                              isEdit: true,
                              serviceMasterSavedValue: serviceMasterSavedValue,
                            ),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 600),
                          );
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
                      Get.off(() => const ServiceMasterScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 600));
                    },
                    color: kColorwhite,
                  ),
                )
              ],
            ),
          )
        ],
      ),
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
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            specification,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
