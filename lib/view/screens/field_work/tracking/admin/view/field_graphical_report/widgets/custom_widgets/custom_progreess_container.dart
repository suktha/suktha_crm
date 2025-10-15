 import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

 customProgressContainer({
    required IconData iconData,
    required String title,
    required String subtitle,
    required Widget graphPlaceholder,
    required List<Widget> customChildren,
    IscontainerGradient=true,
  }) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
    dashPattern: [5, 5],
    strokeWidth: 2,
    color: Colors.grey.shade200,
    radius: Radius.circular(5.w),
    // padding: EdgeInsets.all(16),
  ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.w)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               SizedBox(
                height: 2.w,
              ),
              Padding(
                padding: const EdgeInsets.only(left:  5.0,right: 5.0),
                child: Row(
                  children: [
                     Icon(iconData, color: Colors.blue),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(title,
                        style:  TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.sp)),
                    const Spacer(),
                    Text(subtitle, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
               SizedBox(
                height: 5.w,
              ),
              Container(
                // height: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade100),
               gradient:  LinearGradient(
                      colors:   IscontainerGradient==false?  [
                        Colors.white,
                        Colors.white,
                      ]: [
                        const Color.fromARGB(144, 220, 246, 255),
                        const Color.fromARGB(14, 227, 242, 253),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(5.w)),
                child: graphPlaceholder,
              ),
              SizedBox(height: 1.5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: customChildren,
              )
            ],
          ),
        ),
      ),
    );
  }