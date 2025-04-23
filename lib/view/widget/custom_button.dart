import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  Color? color;
  Color? textcolor;
  final String title;
  final VoidCallback ontap;
  final double width;
  CustomButton({
    Key? key,
    required this.title,
    this.textcolor,
    this.color,
    required this.ontap,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.6.h),
        decoration: BoxDecoration(boxShadow: kElevationToShadow[1], color: color, borderRadius: BorderRadius.circular(3.w)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: textcolor, fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
