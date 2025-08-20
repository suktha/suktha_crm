import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

Future<dynamic> CustomFilterList({
  required BuildContext context,
  required List<Widget> customList,
  required List<Widget> sortColumnList,
  Widget? financialYearList,
  required RxBool sortBy,
  required VoidCallback containerOnpressed,
  required VoidCallback confirmTap,
  required VoidCallback ontapClose,
  bool? isStatusNeeded = true,
}) {
  final formKey = GlobalKey<FormState>();

  return showDialog(
    barrierDismissible: true,
    barrierColor: kColorblack45,
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
        actions: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(width: 2.w,),
                    Center(
                      child: TextButton(
                        onPressed: ontapClose,
                        child: Text(
                          "Clear",
                          style: TextStyle(fontSize: 16.sp, color: kColorblack),
                        ),
                      ),
                    ),

                    CircleAvatar(
                      radius: 6.w,
                      backgroundColor: Colors.lightBlue[300],
                      child: Center(
                        child: IconButton(
                          onPressed: confirmTap,
                          icon: Icon(
                            size: 18.sp,
                            Icons.done_outline_rounded,
                            color: kColorwhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        backgroundColor: kColorwhite,

        // insetPadding: EdgeInsets.all(5.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
        ),
        elevation: 6,
        content: SizedBox(
          // height: 70.h,
          width: 100.w,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Filter By",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17.5.sp),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close,
                              color: kColorblack,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  financialYearList ?? const SizedBox(),
                  Row(
                    children: [
                      isStatusNeeded == true
                          ? Text(
                              "Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17.sp),
                            )
                          : const SizedBox()
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Column(children: customList),
                  ),
                  Text(
                    "Sort By",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Obx(
                          () => SizedBox(
                            height: 7.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: containerOnpressed,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: sortBy.value ? 5.h : 5.5.h,
                                    decoration: BoxDecoration(
                                        boxShadow: kElevationToShadow[3],
                                        border: sortBy.value
                                            ? null
                                            : Border.all(color: kColorlightBlue),
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        color: kColorwhite),
                                    width: sortBy.value ? 29.w : 30.w,
                                    child: Center(
                                      child: Text(
                                        'Ascending',
                                        style: TextStyle(
                                            color: sortBy.value
                                                ? kColorgrey
                                                : kColorblack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: containerOnpressed,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    height: sortBy.value ? 5.5.h : 5.h,
                                    decoration: BoxDecoration(
                                        boxShadow: kElevationToShadow[3],
                                        border: sortBy.value
                                            ? Border.all(color: kColorlightBlue)
                                            : null,
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        color: kColorwhite),
                                    width: sortBy.value ? 30.w : 29.w,
                                    child: Center(
                                      child: Text(
                                        'Descending',
                                        style: TextStyle(
                                            color: sortBy.value
                                                ? kColorblack
                                                : kColorgrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: sortColumnList,
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
