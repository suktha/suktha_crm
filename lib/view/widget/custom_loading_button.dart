import 'package:flutter/material.dart';

import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/main.dart';

class CustomAnimatedButton extends StatelessWidget {
  final String name;
  final VoidCallback ontap;
  final double width;
  final double height;
  final RoundedLoadingButtonController controller;

  const CustomAnimatedButton({
    Key? key,
    required this.name,
    required this.ontap,
    required this.controller,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: RoundedLoadingButton(
        height: height,
        width: width,
        // completionCurve: Curves.fastOutSlowIn,
        successIcon: Icons.sentiment_satisfied_alt,
        animateOnTap: false,
        color: Colors.lightBlue,
        elevation: 10,
        successColor: Color.fromARGB(255, 46, 209, 52),
        errorColor: Colors.red,
        failedIcon: Icons.sentiment_dissatisfied,
        controller: controller,
        onPressed: ontap,
        child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite, fontSize: 16.sp)),
      ),
    );
  }
}
