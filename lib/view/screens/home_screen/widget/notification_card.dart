// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  const NotificationCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          color: kColorwhite,
          // boxShadow: kElevationToShadow[1],
          border: Border.all(color:const Color.fromARGB(43, 158, 158, 158))),
      child: Padding(
        padding: const EdgeInsets.only(top:8.0,bottom: 8),
        child: ListTile(
              title: Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(subTitle),
              leading:   CircleAvatar(
              radius: 7.w,
              backgroundColor: Colors.amber.shade50,
              child: Icon(Icons.wb_sunny_outlined,color: Colors.amber,),
            ),trailing: Text(time,style: TextStyle(color: kColorgrey),),
            ),
      ),
    );
  }
}
