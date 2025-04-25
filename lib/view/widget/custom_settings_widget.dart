import 'package:flutter/material.dart';
import 'package:suktha_crm/Constants/colors.dart';

class MoreListCustomWidgets extends StatelessWidget {
  const MoreListCustomWidgets({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.icon,
    required this.ontap,
  });

  final double height;
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
        style: TextStyle(fontSize: width * 0.04, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500, color: kColorblack),
      ),
      leading: Icon(icon),
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

      trailing: Icon(Icons.keyboard_arrow_right_outlined),
    );
  }
}
