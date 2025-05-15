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
        content: Container(
          // height: 70.h,
          width: 100.w,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
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
                  financialYearList ?? SizedBox(),
                  Row(
                    children: [
                      isStatusNeeded == true
                          ? Text(
                              "Status",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Column(children: customList),
                  ),
                  Text(
                    "Sort By",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
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
                                    duration: Duration(milliseconds: 300),
                                    height: sortBy.value ? 5.h : 6.h,
                                    decoration: BoxDecoration(
                                        boxShadow: kElevationToShadow[3],
                                        border: Border.all(color: Colors.lightBlue.shade300),
                                        borderRadius: BorderRadius.circular(3.w),
                                        color: sortBy.value ? kColorwhite : Colors.lightBlue[300]),
                                    width: sortBy.value ? 29.w : 30.w,
                                    child: Center(
                                      child: Text(
                                        'Ascending',
                                        style: TextStyle(color: sortBy.value ? kColorblack : kColorwhite, fontWeight: FontWeight.w400, fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: containerOnpressed,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    height: sortBy.value ? 6.h : 5.h,
                                    decoration: BoxDecoration(
                                        boxShadow: kElevationToShadow[3],
                                        border: Border.all(color: Colors.lightBlue.shade300),
                                        borderRadius: BorderRadius.circular(3.w),
                                        color: sortBy.value ? Colors.lightBlue[300] : kColorwhite),
                                    width: sortBy.value ? 30.w : 29.w,
                                    child: Center(
                                      child: Text(
                                        'Descending',
                                        style: TextStyle(color: sortBy.value ? kColorwhite : kColorblack, fontWeight: FontWeight.w400, fontSize: 15.sp),
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
