// ignore_for_file: camel_case_types

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/master_controller.dart';

MasterScreen(BuildContext context) async {
  final controller = Get.put(MasterController());

  await controller.FetchItems();
  showModalBottomSheet(

    // ignore: use_build_context_synchronously
    context: context,
    backgroundColor: kColortransparent,
    builder: (context) {
      final sheetHeight = (controller.selectedMasterItems.length * 100.0)
          .clamp(100.0, MediaQuery.of(context).size.height * 0.9);

      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: Container(
          color: kColorwhite,
          height: sheetHeight,
          child: Padding(
            padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: controller.selectedMasterItems.length,
              itemBuilder: (context, index) {
                final item = controller.selectedMasterItems[index];
                final isLeft = index % 2 == 0;

                return isLeft
                    ? FadeInLeft(
                        delay: Duration(milliseconds: 500 + (index * 100)),
                        duration: const Duration(milliseconds: 500),
                        child: transactionItemsCustom(
                          title: item["title"] as String,
                          icons: item["icon"] as IconData,
                          ontap: () {
                            Get.to(() => item["screen"] as Widget,
                                duration:const Duration(milliseconds: 400),
                                transition: Transition.zoom);
                          },
                        ),
                      )
                    : FadeInRight(
                        delay: Duration(milliseconds: 500 + (index * 100)),
                        duration: const Duration(milliseconds: 500),
                        child: transactionItemsCustom(
                          title: item["title"] as String,
                          icons: item["icon"] as IconData,
                          ontap: () {
                            Get.to(() => item["screen"] as Widget,
                                duration: const Duration(milliseconds: 400),
                                transition: Transition.zoom);
                          },
                        ),
                      );
              },
            ),
          ),
        ),
      );
    },
  );
}

class transactionItemsCustom extends StatelessWidget {
  final String title;
  final IconData icons;
  final VoidCallback ontap;
  const transactionItemsCustom({
    super.key,
    required this.title,
    required this.icons,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        // height: 9.h,
        padding: EdgeInsets.all(3.w),
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
            color: kColorwhite,
            boxShadow: kElevationToShadow[2]),
        child: Center(
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 252, 220, 179),
                  radius: 6.w,
                  child: Icon(
                    icons,
                    color: kColorblack,
                    size: 19.sp,
                  )),
              SizedBox(
                width: 4.w,
              ),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: kColorblack)),
            ],
          ),
        ),
      ),
    );
  }
}
