import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class MoreListCustomWidgets extends StatelessWidget {
   MoreListCustomWidgets({
    super.key,
     this.height,
    required this.width,
    required this.title,
    required this.icon,
    required this.ontap,
  });

   double? height;
  final double width;
  final String title;
  final IconData icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w400, color: kColorblack),
      ),
      leading: Icon(icon,color: Colors.blue,),
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

      trailing: Icon(Icons.keyboard_arrow_right_outlined),
    );
  }
}
