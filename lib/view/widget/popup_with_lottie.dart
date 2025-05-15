import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

// class PopupWithLottie extends StatelessWidget {
//  final BuildContext context;
//  final VoidCallback ontap;
//  final VoidCallback oncancel;
//  final String title;
//  final String lottie;
//   const PopupWithLottie({super.key, required this.context, required this.ontap, required this.oncancel, required this.title, required this.lottie});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(

//     );
//   }
// }

Future<dynamic> popupWithLottie({required BuildContext context, required VoidCallback ontap, required VoidCallback oncancel, required String title, String? lottie}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
        content: SizedBox(
          height: lottie == null ? 17.h : 33.h,
          child: Column(
            children: [
              lottie == null
                  ? SizedBox()
                  : LottieBuilder.asset(
                      lottie,
                      fit: BoxFit.cover,
                      width: 40.w,
                    ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    // SizedBox(width: 2.w,),
                    lottie == null
                        ? SizedBox()
                        : CircleAvatar(
                            radius: 5.5.w,
                            backgroundColor: Colors.red,
                            child: Center(
                                child: IconButton(
                                    onPressed: oncancel,
                                    icon: Icon(
                                      Icons.close,
                                      color: kColorwhite,
                                    ))),
                          ),
                    Spacer(),
                    CircleAvatar(
                      radius: 5.5.w,
                      backgroundColor: Colors.lightBlue[300],
                      child: Center(
                          child: IconButton(
                              onPressed: ontap,
                              icon: Icon(
                                Icons.done,
                                color: kColorwhite,
                              ))),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
  );
}
