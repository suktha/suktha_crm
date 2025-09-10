// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Constants/shared_pref_keys.dart';
import 'package:work_Force/Model/company_model.dart';
import 'package:work_Force/Model/login_model.dart' as loginModel;
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/utils/Services/sharedpref_services.dart';
import 'package:work_Force/view/screens/My_account/view/module/more/Refer_and_earn/view/refer_and_earn_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/more/personal_info_screen/personal_info_card.dart';
import 'package:work_Force/view/screens/My_account/view/module/more/settings/view/settings_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/more/subscribtion/view/subscription_screen.dart';
import 'package:work_Force/view/screens/My_account/view/widgets/master/master_container.dart';
import 'package:work_Force/view/screens/My_account/view/widgets/custom_activity_container.dart';
import 'package:work_Force/view/screens/My_account/view/module/Company%20Account%20Settings/company_details_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/Material%20Master/View%20Material%20Master/list_material_master.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/list_party_master.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/Service%20Master/View%20Service%20Master/list_service_master.dart';
import 'package:work_Force/view/screens/field_work/user_profile/view/user_profile_screen.dart';
import 'package:work_Force/view/screens/Task_Managment/view/add_task_screen.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:work_Force/view/widget/custom_settings_widget.dart';
import 'package:work_Force/view/widget/popup_with_lottie.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final globalController = Get.find<GlobalController>();
  final settingsController = Get.find<SettingsController>();

  CompanyModel? companyDetails;

  getCompanyLogo() async {
    print("inside--company logo loading ");
    String newvalue = SharedPreferencesService.instance
        .getValue(SharedPrefKeys().CompanyLogoKey);
    String? companyEncodedDetails = SharedPreferencesService.instance
        .getValue(SharedPrefKeys().CompanyDetailsKey);
    print("companyEncodedDetails -- $companyEncodedDetails");
    if (companyEncodedDetails != null) {
      companyDetails = CompanyModel.fromJson(jsonDecode(companyEncodedDetails));
      print("companyDetails Address -- ${companyDetails?.address}");
    }

    //decoding string to uint8list
    homeController.companyLogo.value = base64Decode(newvalue);
    print("isAdmin: ${homeController.isLoginIdIsAdmin}");
  }

  @override
  void initState() {
    super.initState();
    homeController.getCompanyDetails();
    homeController.getCompanyLogoName();
    settingsController.getcurrencyDetails();
    getdata();
    setState(() {
      Timer(Duration.zero, () => getCompanyLogo());
    });
  }

  bool? isAdmin;

  getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = loginModel.LoginModel.fromJson(logindecoded);

    setState(() {
      homeController.username.value = loginDetails.user!.username ?? "";
    });

    if (loginDetails.user!.roles != null) {
      for (var role in loginDetails.user!.roles!) {
        print("user role id-----${role.roleType!.id}");
        // bool isAdminIdmatches = userList.any(
        //   (element) => element.roleIds?.contains(role.id) ?? false,
        // );

        if (role.roleType!.id == 1) {
          homeController.isLoginIdIsAdmin.value = true;
          homeController.isLoginIdIsbranchmanger.value = true;
          print("Role admin ${role.roleType!.id} exists in userList.");
          isAdmin = homeController.isLoginIdIsAdmin.value;
        } else if (role.roleType!.id == 4) {
          homeController.isLoginIdIsbranchmanger.value = true;
          homeController.isLoginIdIsAdmin.value = false;
          print("Role branch  ${role.roleType!.id} exists in userList.");
          isAdmin = homeController.isLoginIdIsAdmin.value;
        } else {
          homeController.isLoginIdIsAdmin.value = false;
          homeController.isLoginIdIsbranchmanger.value = false;
          print("Role ID ${role.roleType!.id} doesn't exist in userList.");
          isAdmin = homeController.isLoginIdIsAdmin.value;
        }

        log("is admin logged in - ${homeController.isLoginIdIsAdmin.value}");

        sharedPreferences.setBool(
            "isAdmin", homeController.isLoginIdIsAdmin.value);
        isAdmin = homeController.isLoginIdIsAdmin.value;
      }
    } else {
      print("No roles assigned to the user.");
    }
    print("isAdmin: ${homeController.isLoginIdIsAdmin}");

    print("username ------------- ${homeController.username.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile"),
        titleTextStyle: TextStyle(
            color: kColorblack, fontWeight: FontWeight.bold, fontSize: 20.sp),
        // centerTitle: true,
        backgroundColor: kColorwhite,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(3.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AdminProfileCard(
              //   adminName: "Kavya",
              //   profileImageUrl:
              //       "https://as1.ftcdn.net/v2/jpg/03/27/38/68/1000_F_327386893_gwsXr7LjjicyMy1V03pYtgAY5YJiIGip.jpg",
              //   role: "Admin",
              // ),
              FadeInDown(
                delay: Duration.zero,
                duration: Duration(milliseconds: 800),
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 35.sp,
                            backgroundColor: Colors.grey.shade300,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(35.w),
                                child: Image.asset(
                                  "assets/Images/profile_pic.jpg",
                                  fit: BoxFit.fill,
                                  height: 35.w,
                                  width: 35.w,
                                )),
                          ),
                          SizedBox(height: 1.5.h),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(177, 142, 196, 240),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.upload_rounded)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              if (isAdmin == true)
                FadeInLeft(
                  delay: Duration.zero,
                  duration: Duration(milliseconds: 800),
                  child: Column(
                    children: [
                      ActivityContainer(
                        ontap: () {
                          Get.to(
                            () => const UserProfileScreen(),
                            duration: const Duration(milliseconds: 400),
                          );
                        },
                        activityText: "Users & Admins",
                        icon: Icons.person_add_alt,
                        color: kColorlightBlue,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      ActivityContainer(
                        ontap: () {
                          Get.to(
                              () => LeadManagementListScreen(
                                    isFromHomeScreen: false,
                                  ),
                              duration: const Duration(milliseconds: 400),
                              transition: Transition.rightToLeft);
                        },
                        activityText: "Assign Job",
                        icon: Icons.work_outline_outlined,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      ActivityContainer(
                        ontap: () {
                          Get.to(
                              () => AddTaskScreen(
                                    isEdit: false,
                                    Iscompleted: false,
                                  ),
                              duration: const Duration(milliseconds: 400),
                              transition: Transition.rightToLeft);
                        },
                        activityText: "Create Task",
                        icon: Icons.add_task_rounded,
                        color: Colors.indigoAccent,
                      )
                    ],
                  ),
                ),
              SizedBox(
                height: 1.h,
              ),
              FadeInRight(
                delay: Duration.zero,
                duration: Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Master",
                      style: TextStyle(
                          color: kColorblack,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MasterContainer(
                            onTapFunction: () {
                              Get.to(() => ServiceMasterScreen(),
                                  duration: const Duration(milliseconds: 400),
                                  transition: Transition.rightToLeft);
                            },
                            icons: Icons.construction_sharp,
                            title: "Service Master",
                            containerColor: Color.fromARGB(128, 252, 220, 179),
                            iconColor: Colors.amber,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          MasterContainer(
                            onTapFunction: () {
                              Get.to(() => PartyMasterScreen(),
                                  duration: const Duration(milliseconds: 400),
                                  transition: Transition.rightToLeft);
                            },
                            icons: Icons.supervisor_account,
                            title: " Party  Master",
                            containerColor: Color.fromARGB(42, 68, 137, 255),
                            iconColor: Colors.blue,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          MasterContainer(
                            onTapFunction: () {
                              Get.to(() => const MaterialMasterScreen(),
                                  duration: const Duration(milliseconds: 400),
                                  transition: Transition.rightToLeft);
                            },
                            icons: Icons.warehouse_outlined,
                            title: "Material Master",
                            containerColor:
                                const Color.fromARGB(35, 233, 30, 98),
                            iconColor: Colors.pink,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          MasterContainer(
                            onTapFunction: () {
                              Get.to(() => const GeneralMasterScreen(),
                                  duration: const Duration(milliseconds: 400),
                                  transition: Transition.rightToLeft);
                            },
                            icons: Icons.list_alt_rounded,
                            title: "General Master",
                            containerColor: Color.fromARGB(128, 252, 220, 179),
                            iconColor: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              FadeInLeft(
                delay: Duration.zero,
                duration: Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " More",
                      style: TextStyle(
                          color: kColorblack,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MoreListCustomWidgets(
                      width: 16.0,
                      title: "Personal Information",
                      icon: Icons.person_outline,
                      ontap: () {
                        Get.to(() => PersonalInformationScreen(),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    MoreListCustomWidgets(
                      width: 16.0,
                      title: "Company Profile",
                      icon: Icons.business_center_outlined,
                      ontap: () {
                        Get.to(
                            () => CompanyDetailsScreen(
                                companyDetails: companyDetails!),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    MoreListCustomWidgets(
                      width: 16.0,
                      title: "Refer & Earn",
                      icon: Icons.emoji_emotions_outlined,
                      ontap: () {
                        Get.to(() => ReferAndEarnScreen(),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    MoreListCustomWidgets(
                      width: 16.0,
                      title: "Subscription Details",
                      icon: Icons.subscriptions_outlined,
                      ontap: () {
                        Get.to(() => SunscriptionDetailsScreen(),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    MoreListCustomWidgets(
                      width: 16.0,
                      title: "Settings",
                      icon: Icons.settings_outlined,
                      ontap: () {
                        Get.to(() => SettingsScreen(),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    ListTile(
                      onTap: () {
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
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 16.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            color: kColorblack),
                      ),
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
