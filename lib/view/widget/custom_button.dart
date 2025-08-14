import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class CustomButton extends StatelessWidget {
  Color? color;
  Color? textcolor;
  final String title;
  final VoidCallback ontap;
  final double width;
  CustomButton({
    super.key,
    required this.title,
    this.textcolor,
    this.color,
    required this.ontap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorlightBlue,
          minimumSize: Size(double.infinity, 5.0.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: textcolor, fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
