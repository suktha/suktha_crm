import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class MasterContainer extends StatelessWidget {
  final IconData icons;
  final String title;
  final Color iconColor;
  final Color containerColor;
  VoidCallback onTapFunction;
   MasterContainer(
      {super.key,
      required this.icons,
      required this.title,
      required this.iconColor,
      required this.containerColor,
      required this.onTapFunction
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        height: 14.h,
        width: 28.w,
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(3.w),
            // border: Border.all(color: Colors.grey.shade200),
            ),
        child: Padding(
        padding:  EdgeInsets.only(top: 3.w,bottom: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: kColorwhite,
                  radius: 6.w,
                  child: Icon(
                    icons,
                    color: iconColor,
                    size: 20.sp,
                  )),
              SizedBox(
                height: 2.w,
              ),
              SizedBox(
                width: 23.w,
                child: Text(title,
                textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: kColorblack)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
