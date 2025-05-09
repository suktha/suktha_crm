// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/Constants/shared_pref_keys.dart';
import 'package:suktha_crm/Model/company_model.dart';
import 'package:suktha_crm/controllers/Home_controller.dart';
import 'package:suktha_crm/controllers/global_controller.dart';
import 'package:suktha_crm/controllers/settings_controller.dart';
import 'package:suktha_crm/utils/Services/sharedpref_services.dart';
import 'package:suktha_crm/utils/responsive_utils.dart';
import 'package:suktha_crm/view/settings_module/Account%20Settings/company_details_screen.dart';
import 'package:suktha_crm/view/settings_module/tracking/admin/view/user_field_work_screen.dart';
import 'package:suktha_crm/view/widget/custom_button.dart';
import 'package:suktha_crm/view/widget/custom_settings_widget.dart';
import 'package:suktha_crm/view/widget/popup_with_lottie.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final globalController = Get.find<GlobalController>();

  final homeController = Get.put(HomeController());
  final settingsController = Get.put(SettingsController());

  CompanyModel? companyDetails;

  getCompanyLogo() async {
    print("inside--company logo loading ");
    String newvalue = SharedPreferencesService.instance
        .getValue(SharedPrefKeys().CompanyLogoKey);
    String? companyEncodedDetails = SharedPreferencesService.instance
        .getValue(SharedPrefKeys().CompanyDetailsKey);
    print("companyEncodedDetails -- ${companyEncodedDetails}");
    if (companyEncodedDetails != null) {
      companyDetails = CompanyModel.fromJson(jsonDecode(companyEncodedDetails));
      print("companyDetails Address -- ${companyDetails?.address}");
    }

    //decoding string to uint8list
    homeController.companyLogo.value = base64Decode(newvalue);
  }

  @override
  void initState() {
    super.initState();
    homeController.getCompanyDetails();
    homeController.getCompanyLogoName();
    settingsController.getcurrencyDetails();

    setState(() {
      Timer(Duration.zero, () => getCompanyLogo());
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);

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
            style: TextStyle(
                color: kColorblack,
                fontSize: 19.sp,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: kColorblack),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: MoreListCustomWidgets(
                      height: height,
                      width: width,
                      ontap: () {
                        Get.to(
                            () => CompanyDetailsScreen(
                                companyDetails: companyDetails!),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                      title: "Company Profile",
                      icon: Icons.business_center_outlined)),
              FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: MoreListCustomWidgets(
                      height: height,
                      width: width,
                      ontap: () {
                        Get.to(
                          () => const UserFieldWorkScreen(),
                          duration: const Duration(milliseconds: 400),
                          transition: Transition.rightToLeft,
                        );
                      },
                      title: "Field Work",
                      icon: Icons.person_pin_circle_sharp)),
              const Spacer(),
              CustomButton(
                width: 25.w,
                title: "LOGOUT",
                ontap: () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      popupWithLottie(
                          context: context,
                          ontap: () async {
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
