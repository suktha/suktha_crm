// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Model/login_model.dart' as loginModel;
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/view/screens/My_account/master/master_container.dart';
import 'package:work_Force/view/screens/My_account/widget/admin_profile.dart';
import 'package:work_Force/view/screens/My_account/widget/custom_activity_container.dart';
import 'package:work_Force/view/screens/more_module/user_profile/view/user_profile_screen.dart';
import 'package:work_Force/view/widget/custom_button.dart';
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

  bool? isAdmin;

  @override
  void initState() {
    getdata();
    super.initState();
  }

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
        title: Text((isAdmin ?? false) ? "Admin" : "Profile"),
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
              AdminProfileCard(
                adminName: "Kavya",
                profileImageUrl:
                    "https://as1.ftcdn.net/v2/jpg/03/27/38/68/1000_F_327386893_gwsXr7LjjicyMy1V03pYtgAY5YJiIGip.jpg",
                role: "Admin",
              ),
              SizedBox(
                height: 1.h,
              ),
              if (isAdmin == true)
                Column(
                  children: [
                    ActivityContainer(
                      activityText: "Users & Admins",
                      icon: Icons.person_add_alt,
                      color: kColorlightBlue,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ActivityContainer(
                        activityText: "Assign Job",
                        icon: Icons.work_outline_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ActivityContainer(
                        activityText: "Create Task",
                        icon: Icons.add_task_rounded,
                        color: Colors.indigoAccent,
                      ),
                    )
                  ],
                ),
              SizedBox(
                height: 1.h,
              ),
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
                      onTapFunction: () {},
                      icons: Icons.construction_sharp,
                      title: "Service Master",
                      containerColor: Color.fromARGB(128, 252, 220, 179),
                      iconColor: Colors.amber,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    MasterContainer(
                      onTapFunction: () {},
                      icons: Icons.supervisor_account,
                      title: " Party  Master",
                      containerColor: Color.fromARGB(42, 68, 137, 255),
                      iconColor: Colors.blue,
                    ),
                     SizedBox(
                      width: 3.w,
                    ),
                    MasterContainer(
                      onTapFunction: () {},
                      icons: Icons.warehouse_outlined,
                      title: "Material Master",
                      containerColor: const Color.fromARGB(35, 233, 30, 98),
                      iconColor: Colors.pink,
                    ),
                     SizedBox(
                      width: 3.w,
                    ),
                    MasterContainer(
                      onTapFunction: () {},
                      icons: Icons.list_alt_rounded,
                      title: "General Master",
                      containerColor: Color.fromARGB(128, 252, 220, 179),
                      iconColor: Colors.amber,
                    ),
                    
                  ],
                ),
              ),

              SizedBox(
                height: 1.h,
              ),
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
                title: "Company Profile",
                icon: Icons.business_center_outlined,
                ontap: () {},
              ),
              MoreListCustomWidgets(
                width: 16.0,
                title: "Personal Information",
                icon: Icons.person,
                ontap: () {},
              ),
              MoreListCustomWidgets(
                width: 16.0,
                title: "General Master",
                icon: Icons.receipt_long_rounded,
                ontap: () {},
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

              // MoreListCustomWidgets(
              //     height: 17.0,
              //     width: 17.0.sp,
              //     ontap: () {
              //       Get.to(() => const UserProfileScreen(),
              //           duration: const Duration(milliseconds: 400),
              //           transition: Transition.rightToLeft);
              //     },
              //     title: "User Profile",
              //     icon: Icons.person_outline)
            ],
          ),
        ),
      ),
    );
  }
}
