import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

void DeleteAccountBottomSheet(BuildContext context, Widget reasons) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    // useSafeArea: true,
    // backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(top: 8.h, left: 3.w, right: 3.w, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    ' Delete Account',
                    style: TextStyle(fontSize: 25, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorblack),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 4.w,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                          size: 18,
                        ),
                      ))
                  // IconButton(onPressed: () {}, icon: )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 90.w,
                  child: Text(
                    "We\'re really sorry to see you go.Are you sure you, want to delete your account? Once you confirm,your data will gone.",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
                  )),
              Expanded(child: reasons)
            ],
          ),
        ),
      );
    },
  );
}
