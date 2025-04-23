import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/controllers/global_controller.dart';
import 'package:suktha_crm/view/widget/custom_button.dart';
import 'package:suktha_crm/view/widget/popup_with_lottie.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await popupWithLottie(
            context: context,

            //ontap
            ontap: () {
              SystemNavigator.pop();
            },
            //oncanecl
            oncancel: () {
              Get.back();
            },
            title: "Are you Sure \nyou want to Exit?",
            lottie: exitLottie);

        return value == true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kColorwhite,
          title: Text(
            "Settings",
            style: TextStyle(color: kColorblack, fontSize: 19.sp, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: kColorblack),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomButton(
                width: 25.w,
                title: "LOGOUT",
                ontap: () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      popupWithLottie(
                          context: context,
                          ontap: () {
                            //ontap
                            globalController.logoutData();
                          },
                          oncancel: () {
                            //oncanecl
                            Get.back();
                          },
                          title: "Are you Sure \nyou want to Log Out?",
                          lottie: exitLottie);
                      // controller.logoutData();
                    },
                  );
                },
                color: kColorlightBlue300,
                textcolor: kColorwhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
