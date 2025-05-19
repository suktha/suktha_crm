// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/user_model.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/settings_module/user_profile/controller/general_master_controller.dart';
import 'package:work_Force/view/settings_module/user_profile/controller/user_profile_controller.dart';
import 'package:work_Force/view/settings_module/user_profile/widgets/create_user_or_edit_custom.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import '../../../../Model/login_model.dart' as login;
import '../widgets/update_login_details_custom.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with SingleTickerProviderStateMixin {

  List<UserModel> _filteredItems = [];

  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    getLoginDetails();
    _filteredItems = controller.UserProfileList;

  
    controller.getCreatedByNames("", "name");
  }



  login.LoginModel? loginDetails;
  getLoginDetails() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    loginDetails = login.LoginModel.fromJson(logindecoded);

    print(loginDetails!.user!.id);
  }

  int selectedIndex = 0;

  UserProfileController controller = Get.put(UserProfileController());

  final generalController = Get.put(GeneralMasterController());

  final createUserFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateLoginFormkey = GlobalKey<FormState>();
  bool isEdit = false;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: const Text("User Profile"),
          titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 20.sp),
          centerTitle: true,
          backgroundColor: kColorwhite,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  controller.UserProfileList.clear();
                  controller.getCreatedByNames("", 'name');
                },
                icon: Icon(
                  Icons.refresh,
                  color: kColorblack,
                ))
          ],
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: kColorblack,
              size: 25.sp,
            ),
            onPressed: (() {
              Get.back();
            }),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: TextField(
                      onChanged: (value) async {
                        controller.UserProfileList.clear();
                        await controller.getCreatedByNames(controller.searchController.text, "name");
                      },
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search Here',
                        hintStyle: TextStyle(color: kColorblack45),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //     onPressed: () {
                //       bool isFilterEnabled = true;
                //     },
                //     icon: Icon(
                //       Icons.filter_alt,
                //       color: Colors.grey,
                //     ))
              ],
            ),
            GestureDetector(
              onTap: () async {
                isEdit = false;
                controller.clearFunction();

                showModalBottomSheet(
                  isDismissible: true,
                  isScrollControlled: true,
                  useSafeArea: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return CreateUserOrEditCustom(
                        createUserFormKey: createUserFormKey,
                        title: "Create User Profile",
                        controller: controller,
                        buttonText: "Save",
                        buttonPress: () {
                          if (createUserFormKey.currentState!.validate()) {
                            print("inside else  if--- save");
                            controller.saveUserProfile();
                            Get.back();
                          } else {
                            controller.validationMessage.value = 'Please select Prefix';
                            controller.validationMessageGender.value = 'Please select gender';
                            controller.validationMessageemployeeType.value = 'Please select employee Type';

                            print("not validated");
                          }
                        });
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Add User",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.5.sp),
                  ),
                  leading: CircleAvatar(
                    radius: 6.w,
                    backgroundColor: Colors.grey[400],
                    child: Icon(Icons.add_circle, size: 7.w, color: kColorLightGrey),
                  ),
                ),
              ),
            ),
            Obx(
              () => _filteredItems.isEmpty
                  ? Expanded(
                      // flex: 1,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        FadeIn(
                            delay: const Duration(milliseconds: 300),
                            duration: const Duration(milliseconds: 300),
                            child: LottieBuilder.asset("assets/lottie/empty.json")),
                        SizedBox(
                          height: 3.h,
                        ),
                        FadeIn(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            "Your User Profile is Empty",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ),
                        Spacer()
                      ],
                    ))
                  : Expanded(
                      flex: 19,
                      child: Scrollbar(
                        interactive: true,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            return SwipeActionCell(
                              key: UniqueKey(),
                              trailingActions: <SwipeAction>[
                                SwipeAction(
                                    performsFirstActionWithFullSwipe: false,
                                    backgroundRadius: 6.w,
                                    widthSpace: 20.w,
                                    title: "Delete",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
                                    onTap: (CompletionHandler handler) async {
                                      customDeleteAlertDialogue(
                                        context,
                                        () async {
                                          print(item.id);
                                          await controller.deleteUserList(item.id);
                                          Get.back();
                                        },
                                      );
                                    },
                                    color: Colors.red),
                              ],
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      print(item.id);
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(7.w)),
                                        ),
                                        // isScrollControlled: true,

                                        context: context,
                                        builder: (context) {
                                          return Wrap(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(2.w),
                                                child: Column(children: [
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                      radius: 6.w,
                                                      backgroundColor: getRandomLightColor(index),
                                                      child: Icon(Icons.person_pin, size: 7.w, color: kColorLightGrey),
                                                    ),
                                                    title: Text(
                                                      item.name!.capitalizeFirst ?? "",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 17.sp,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      "${controller.getUserRoleNames(item.roleIds!)}  ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                    trailing: Text(
                                                      item.active == 1 ? "Active" : "Disabled",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: item.active == 1 ? Colors.green : kColorRed,
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    " ${item.dateOfJoin != null ? "Joined " + controller.datePareser(item.dateOfJoin) : ""}",
                                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black54),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      customButtonUserProfile(
                                                        title: "Edit",
                                                        icon: Icons.edit,
                                                        ontap: () {
                                                          editFunction(item);

                                                          showModalBottomSheet(
                                                            isDismissible: false,
                                                            isScrollControlled: true,
                                                            useSafeArea: true,
                                                            backgroundColor: Colors.transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return CreateUserOrEditCustom(
                                                                  createUserFormKey: createUserFormKey,
                                                                  title: "Update User Profile",
                                                                  controller: controller,
                                                                  buttonText: "Update",
                                                                  buttonPress: () {
                                                                    if (createUserFormKey.currentState!.validate()) {
                                                                      // print(item.id);

                                                                      controller.updateUserProfile(item);
                                                                      // Get.back();
                                                                    } else {
                                                                      controller.validationMessage.value = 'Please select Prefix';
                                                                      controller.validationMessageGender.value = 'Please select gender';
                                                                      controller.validationMessageemployeeType.value =
                                                                          'Please select employee Type';

                                                                      print("not validated");
                                                                    }
                                                                  });
                                                            },
                                                          );
                                                        },
                                                        color: Colors.black54,
                                                      ),

                                                      //if its active there will be disable button and login details button
                                                      // if its is disabled there won't be a two button just enable button
                                                      //active 0 - active 1 - disabled

                                                      item.active == 0
                                                          ? customButtonUserProfile(
                                                              title: "Enable Login",
                                                              icon: Icons.account_circle_sharp,
                                                              ontap: () {
                                                                controller.userNameController.text = item.username ?? "";
                                                                controller.emailController.text = item.email ?? "";
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return UpdateLoginDetailsCustom(
                                                                      userProfileValue: item,
                                                                      controller: controller,
                                                                      updateLoginFormKey: updateLoginFormkey,
                                                                      onSave: () {
                                                                        if (updateLoginFormkey.currentState!.validate()) {
                                                                          print(item.isLogInRequired);
                                                                          if (item.isLogInRequired == null) {
                                                                            print("--1--");
                                                                            controller.newEmployeeCheck(item);
                                                                            Get.back();
                                                                          } else if (item.isLogInRequired == 0) {
                                                                            print("--2--");
                                                                            controller.passwordChange(item.id);

                                                                            controller.newPasswordController.text = "";
                                                                            controller.confirmPasswordController.text = "";
                                                                          }
                                                                        } else {
                                                                          print("not validate");
                                                                        }
                                                                      },
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              color: Colors.green)
                                                          : loginDetails!.user!.id != item.id
                                                              ? customButtonUserProfile(
                                                                  title: "Disable",
                                                                  icon: Icons.no_accounts,
                                                                  ontap: () {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (context) => AlertDialog(
                                                                              shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                              title: Text('Notice!',
                                                                                  style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  )),
                                                                              content: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Text(
                                                                                    'Do you want to disable the login of',
                                                                                    style: TextStyle(fontSize: 13.sp),
                                                                                  ),
                                                                                  SizedBox(height: 2.w),
                                                                                  Text(
                                                                                    item.username ?? "",
                                                                                    style: TextStyle(
                                                                                        fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  // SizedBox(height: 2.w),
                                                                                ],
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    controller.disableLogin(item);
                                                                                  },
                                                                                  child: Text('Confirm',
                                                                                      style: TextStyle(fontSize: 19, color: kColorRed)),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text('Cancel', style: TextStyle(fontSize: 18)),
                                                                                ),
                                                                              ],
                                                                            ));
                                                                  },
                                                                  color: item.active == 1 ? Colors.red : Colors.green)
                                                              : SizedBox(),
                                                      item.active == 1
                                                          ? customButtonUserProfile(
                                                              title: "Login Details",
                                                              icon: Icons.login_rounded,
                                                              ontap: () {
                                                                controller.userNameController.text = item.username ?? "";
                                                                controller.emailController.text = item.email ?? "";
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return UpdateLoginDetailsCustom(
                                                                      userProfileValue: item,
                                                                      controller: controller,
                                                                      updateLoginFormKey: updateLoginFormkey,
                                                                      onSave: () {
                                                                        if (updateLoginFormkey.currentState!.validate()) {
                                                                          if (item.isLogInRequired == null) {
                                                                            controller.newEmployeeCheck(item);
                                                                            Get.back();
                                                                          } else if (item.isLogInRequired == 1) {
                                                                            controller.passwordChange(item.id);

                                                                            Get.back();
                                                                            controller.newPasswordController.text = "";
                                                                            controller.confirmPasswordController.text = "";
                                                                          }
                                                                        } else {
                                                                          print("not validate");
                                                                        }
                                                                      },
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              color: Colors.black54)
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    item.comments ?? "",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                  ),
                                                  Visibility(
                                                      visible: item.mobileNumber != null ? true : false,
                                                      child:
                                                          InkWell(child: detailsWidget(title: item.mobileNumber ?? "", icon: Icons.phone))),
                                                  Tooltip(
                                                      triggerMode: TooltipTriggerMode.tap,
                                                      message: "Permanent Address",
                                                      child: detailsWidget(
                                                          title: item.permanentAddress ?? "Field is Empty",
                                                          icon: Icons.location_on_rounded)),
                                                  Tooltip(
                                                      triggerMode: TooltipTriggerMode.tap,
                                                      message: "Employee-code",
                                                      child: detailsWidget(
                                                          title: item.employeeNumber ?? "Field is Empty",
                                                          icon: Icons.account_circle_sharp)),
                                                  // Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                                  //   children: [
                                                  //     customButtonUserProfile(
                                                  //         title: "View Current Location",
                                                  //         icon: Icons.my_location_sharp,
                                                  //         ontap: () {
                                                  //           var value = [
                                                  //             UserLocation(
                                                  //                 id: '1',
                                                  //                 name: 'John Doe',
                                                  //                 latitude: 12.9716,
                                                  //                 longitude: 77.5946,
                                                  //                 imageUrl:
                                                  //                     "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"),
                                                  //           ];
                                                  //           Get.to(
                                                  //               () => UserLocationScreen(
                                                  //                     userLocList: value,
                                                  //                   ),
                                                  //               transition: Transition.fade,
                                                  //               duration: const Duration(milliseconds: 1000));
                                                  //         },
                                                  //         color: kColorlightBlue),
                                                  //   ],
                                                  // ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  )
                                                ]),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                        child: ListTile(
                                      title: Text(
                                        "${item.name!.capitalizeFirst}",
                                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.5.sp),
                                      ),
                                      subtitle: Text(
                                        controller.getUserRoleNames(item.roleIds!),
                                        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.5.sp),
                                      ),
                                      leading: CircleAvatar(
                                        radius: 6.w,
                                        backgroundColor: getRandomLightColor(index),
                                        child: Icon(Icons.person_pin, size: 7.w, color: kColorLightGrey),
                                      ),
                                      // trailing: loginDetails!.user!.id != item.id
                                      //     ? Text(
                                      //         item.active == 1 ? "Active" : "Login Disabled",
                                      //         style: TextStyle(
                                      //           fontWeight: FontWeight.bold,
                                      //           color: item.active == 1 ? Colors.green : kColorRed,
                                      //           fontSize: 13.sp,
                                      //         ),
                                      //       )
                                      //     : SizedBox(),
                                    )),
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
            ),
            // homeController.isLoginIdIsAdmin.value
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           InkWell(
            //             onTap: () async {
            //               PermissionStatus status = await Permission.location.request();

            //               if (status.isGranted) {
            //                 var value = [
            //                   UserLocation(
            //                       id: '1',
            //                       name: 'John Doe',
            //                       latitude: 12.9716,
            //                       longitude: 77.5946,
            //                       imageUrl: "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"),
            //                   UserLocation(
            //                     id: '2',
            //                     name: 'Jane Smith',
            //                     latitude: 12.9768,
            //                     longitude: 77.5910,
            //                     imageUrl:
            //                         'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600', // Replace with real URLs
            //                   ),
            //                   UserLocation(
            //                     id: '3',
            //                     name: 'Alice Johnson',
            //                     latitude: 12.9760,
            //                     longitude: 77.5990,
            //                     imageUrl:
            //                         'https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Replace with real URLs
            //                   ),
            //                 ];
            //                 Get.to(
            //                     () => UserLocationScreen(
            //                           userLocList: value,
            //                         ),
            //                     transition: Transition.fade,
            //                     duration: const Duration(milliseconds: 1000));
            //               } else {
            //                 // Permission denied, handle accordingly
            //               }
            //             },
            //             child: Container(
            //               margin: EdgeInsets.symmetric(horizontal: 2.w),
            //               padding: EdgeInsets.all(3.5.w),
            //               decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(3.w)),
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.my_location_outlined,
            //                     color: Colors.white,
            //                     size: 5.w,
            //                   ),
            //                   SizedBox(
            //                     width: 2.w,
            //                   ),
            //                   Text(
            //                     "Track Users Location",
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: 12.sp,
            //                       color: kColorwhite,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           )
            //         ],
            //       )
            //     : SizedBox()
          ],
        ),
      ),
    );
  }

  Color getRandomLightColor(int index) {
    // Generate a unique hue based on the index
    double hue = (index * 137.5) % 360; // 137.5 degrees apart ensures good separation
    return HSVColor.fromAHSV(1, hue, 0.3, 0.5).toColor();
  }

  editFunction(UserModel item) async {
    await controller.getBranchList();
    isEdit = true;

    controller.prefixId.value = item.prefixId?.toString() ?? "";

    controller.prefixName.value = item.prefixId == null
        ? ""
        : controller.prefixList.firstWhere((element) {
            return element.id.toString() == controller.prefixId.value;
          }).name!;

    controller.getBranchId.value = item.reportingTo?.toString() ?? "";

    if (item.roleIds!.contains(8)) {
      controller.isStaffSelected.value = true;
    } else {
      controller.isStaffSelected.value = false;
    }

    print("item.reportingTo --${item.reportingTo}");
    print("selected staff ---${controller.isStaffSelected.value}");

    controller.genderId.value = item.genderId?.toString() ?? "";
    controller.genderName.value = item.genderId == null
        ? ""
        : controller.genderList.firstWhere((element) {
            return element.id.toString() == controller.genderId.value;
          }).name!;
    controller.stateId.value = item.stateId?.toString() ?? "";
    controller.stateController.text = item.stateId == null
        ? ""
        : generalController.state_master_items.firstWhere((element) {
              return element.id.toString() == controller.stateId.value;
            }).name ??
            "";
    controller.cityId.value = item.cityId?.toString() ?? "";
    controller.cityController.text = item.cityId == null
        ? ""
        : generalController.city_master_items.firstWhere((element) {
              return element.id.toString() == controller.cityId.value;
            }).name ??
            "";
    controller.areaId.value = item.areaId?.toString() ?? "";

    print("controller.areaId.value ---${controller.areaId.value}");

    controller.areaController.text = item.areaId == null
        ? ""
        : generalController.area_master_items.firstWhere((element) {
              return element.id.toString() == controller.areaId.value;
            }).name ??
            "";

    controller.countryId.value = item.countryId?.toString() ?? "";
    controller.countryController.text = item.countryId == null
        ? ""
        : generalController.country_master_items.firstWhere((element) {
            return element.id.toString() == controller.countryId.value;
          }).name!;

    if (item.employeeTypeId != null && controller.employeeTypeList.isNotEmpty) {
      controller.employeeTypeId.value = item.employeeTypeId.toString();

      print(controller.employeeTypeId.value);

      controller.employeeTypeName.value =
          controller.employeeTypeList.firstWhere((item) => item.id.toString() == controller.employeeTypeId.value).name!;
    }

    if (item.roleIds != null && item.roleIds!.isNotEmpty) {
      List selectedUserRole = item.roleIds!;

      controller.selectedUserRoleList.clear();

      for (var item in controller.userRoleList) {
        if (selectedUserRole.contains(item.id)) {
          controller.selectedUserRoleList.add(item);
        }
      }
      controller.userRoleController.text = controller.selectedUserRoleList.map((item) => item.role).join(', ');
    }
    // controller.userRoleController.text = item.roleIds == null ? "" : controller.getUserRoleNames(item.roleIds.toString());

    controller.nameController.text = item.name ?? "";
    controller.pincodeController.text = item.pinCode ?? "";
    controller.dateOfJoiningController.text = item.dateOfJoin == null ? "" : DateClass().parseDate(item.dateOfJoin ?? "");
    controller.dateOfLeavingController.text = item.dateOfLeaving == null ? "" : DateClass().parseDate(item.dateOfLeaving ?? "");
    controller.DOBController.text = item.dateOfBirth == null ? "" : DateClass().parseDate(item.dateOfBirth ?? "");
    controller.mobileNumController.text = item.mobileNumber ?? "";
    controller.telePhoneNumController.text = item.telephoneNumber ?? "";
    controller.employeeCodeController.text = item.employeeNumber ?? "";
    controller.permaentAddressController.text = item.permanentAddress ?? "";
    controller.currentAddressController.text = item.currentAddress ?? "";
    controller.commentsController.text = item.comments ?? "";
    controller.emailController.text = item.email ?? "";
    controller.validationMessage.value = '';
    controller.validationMessageGender.value = "";
    controller.validationMessageemployeeType.value = "";
    controller.userNameController.text = item.username ?? "";

    print("emmail${controller.emailController.text}");
    print("username--${controller.userNameController.text}");
  }
}

class detailsWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const detailsWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black54,
              size: 5.w,
            ),
            SizedBox(
              width: 5.w,
            ), 
            SizedBox(
              width: 80.w,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}

class customButtonUserProfile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback ontap;
  final Color color;
  const customButtonUserProfile({
    super.key,
    required this.title,
    required this.icon,
    required this.ontap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
            ),
            borderRadius: BorderRadius.circular(3.w)),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 5.w,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class customTabBarWidget extends StatelessWidget {
  final String title;
  final int selectedIndex;
  const customTabBarWidget({
    super.key,
    required this.title,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
            color: Colors.grey[400], // Background color of the tab
            borderRadius: BorderRadius.circular(35.w)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ),
    );
  }
}
