import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class ActivityContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String activityText;
  const ActivityContainer(
      {super.key, required this.activityText, required this.icon,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11), border: Border.all(color: Colors.grey.shade200)),
      child: Padding(
        padding:  EdgeInsets.all(4.w),
        child: Row(
          children: [
            Icon(icon,color: color,),
            const SizedBox(
              width: 10,
            ),
            Text(activityText,style: TextStyle(fontSize: 16.sp),)
          ],
        ),
      ),
    );
  }
}
