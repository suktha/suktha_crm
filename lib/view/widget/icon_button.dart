import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class customIconButton extends StatelessWidget {
  customIconButton({
    Key? key,
    this.bgcolor,
    required this.ontap,
    required this.icon,
  }) : super(key: key);

  final VoidCallback ontap;
  Color? bgcolor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 6.w,
        backgroundColor: bgcolor,
        child: Center(
          child: IconButton(
            onPressed: ontap,
            //  () {

            // controller.loadPdf(

            //     widget.id,
            //    widget.transType,
            //     widget.Amount,
            //     controller.printHeaderTextController.text,
            //     controller.materialImageIschecked.isTrue ? 1 : 0,
            //     controller.dropdownvalue.value,
            //     true);
            // },
            icon: Icon(icon),
            tooltip: "Print",
            color: kColorwhite,
          ),
        ));
  }
}
