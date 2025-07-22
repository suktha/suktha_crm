// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';

class QuickTaskNotification extends StatelessWidget {
  const QuickTaskNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        border: Border.all(color: Colors.grey.shade200, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '2 ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'tasks are waiting for you in ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                          color: Colors.black87),
                    ),
                    TextSpan(
                      text: 'Tasks',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            TextButton(
              onPressed: () {
                Get.find<NavigationController>().changeTab(2);
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Open",
                  style: TextStyle(
                    color: Colors.blue,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
