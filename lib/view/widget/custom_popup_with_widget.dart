// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class CustomPopup extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final String saveButtonText;
  final VoidCallback onCancelPressed;
  final VoidCallback onUpdatePressed;

  CustomPopup({
    required this.children,
    required this.title,
    required this.onCancelPressed,
    required this.onUpdatePressed,
    required this.saveButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
      title: Center(
          child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: 100.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll(4),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Set your desired border radius here
              ),
            ),
          ),
          onPressed: onCancelPressed,
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll(4),
            backgroundColor: WidgetStatePropertyAll(kColorlightBlue),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Set your desired border radius here
              ),
            ),
          ),
          onPressed: onUpdatePressed,
          child: Text(saveButtonText),
        ),
      ],
    );
  }
}
