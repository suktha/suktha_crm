import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/colors.dart';

class ListTileCustomWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icons;
  const ListTileCustomWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ListTile(
              title: Text(
                title,
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.5.sp,
              ),
              minLeadingWidth: 1,
              leading: Icon(
                icons,
                size: 19.sp,
                color: kColorlightBlue,
              )),
        ),
        const Divider(),
      ],
    );
  }
}
