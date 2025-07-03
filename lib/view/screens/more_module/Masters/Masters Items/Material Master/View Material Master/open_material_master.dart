import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/material_list_model.dart';
import 'package:work_Force/controllers/get_material_master_controller.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Material%20Master/View%20Material%20Master/list_material_master.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/icon_button.dart' show customIconButton;
import '../Add Material Master/material_master_add.dart';

// ignore: must_be_immutable
class OpenMaterialMasterScreen extends StatelessWidget {
  BuildContext? contexts;

  MaterialListModel? materailMasterSavedValue;

  OpenMaterialMasterScreen({
    super.key,
    this.materailMasterSavedValue,
    this.contexts,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetMaterialMasterController());

    // controller.getTaxesList("");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text("Material Master"),
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
              Get.to(() => const MaterialMasterScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 600));
            }),
          )),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 12.h, left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.w), bottomRight: Radius.circular(12.w)),
                boxShadow: kElevationToShadow[2],
                gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                  Color.fromARGB(255, 220, 246, 255),
                  Color.fromARGB(255, 62, 194, 255),
                ])),
            height: 23.5.h,
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 10.h,
                  child: Text(
                    "Name: ${materailMasterSavedValue!.name}" == "" ? "" : "Name: ${materailMasterSavedValue!.name}", //////quotation number
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                ),
                SizedBox(
                  // height: 10.h,
                  child: Text(
                    "Material Type: ${materailMasterSavedValue!.materialTypeName}", // party name
                    // "jgjglhlkhlkhlhklj",
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15,top: 8,bottom: 8),
                child: Column(
                  children: [
                    SizedBox(height: 2.h,),
                    KeyValueWidget('Part Number', materailMasterSavedValue!.partNumber ?? ""),
                    KeyValueWidget('HSN/SAC', materailMasterSavedValue!.hsnCode ?? ""),
                    KeyValueWidget('UOM', materailMasterSavedValue!.unitOfMeasurementName ?? ""),
                    Obx(() => controller.taxList.isEmpty
                        ? const SizedBox()
                        : KeyValueWidget(
                            'Tax',
                            materailMasterSavedValue!.taxId != null
                                ? "${controller.taxList
                                        .firstWhere((element) => element.id == materailMasterSavedValue?.taxId)
                                        .rate}%"
                                : "")),
                    KeyValueWidget('Current Stock', materailMasterSavedValue!.stock?.toStringAsFixed(0) ?? "0"),
                    KeyValueWidget('Opening Stock', materailMasterSavedValue!.openingStock?.toStringAsFixed(0) ?? "0"),
                    KeyValueWidget('Minimum Stock', materailMasterSavedValue!.minimumStock?.toStringAsFixed(0) ?? "0"),
                    KeyValueWidget('MRP', "₹${materailMasterSavedValue!.mrp?.toStringAsFixed(1) ?? "0.00"}"),
                    KeyValueWidget('Buying Price', "₹${materailMasterSavedValue!.buyingPrice?.toStringAsFixed(1) ?? "0.00"}"),
                    KeyValueWidget('Selling Price', "₹${materailMasterSavedValue!.price?.toStringAsFixed(1) ?? "0.00"}"),
                    KeyValueWidget('Description', "${materailMasterSavedValue!.specification ?? ""}"),
                  ],
                ),
              ),
            ),
          ),
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
                              AddMaterialMasterScreen(
                                isEdit: true,
                                materialMasterSaved: materailMasterSavedValue,
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
                      Get.to(() => const MaterialMasterScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 600));
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

class KeyValueWidget extends StatelessWidget {
  final String keyText;
  final String valueText;

  const KeyValueWidget(this.keyText, this.valueText, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$keyText : ",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.002),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    valueText,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
