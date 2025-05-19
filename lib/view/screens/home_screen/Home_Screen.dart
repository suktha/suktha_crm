// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Constants/shared_pref_keys.dart';
import 'package:work_Force/Model/company_model.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/controllers/initial_controller.dart';
import 'package:work_Force/controllers/lead_contact_details_controller.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/utils/Services/sharedpref_services.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/utils/responsive_utils.dart';
import 'package:work_Force/view/settings_module/Account%20Settings/company_details_screen.dart';
import 'package:work_Force/view/screens/home_screen/controller/home_screen_text_controller.dart';
import 'package:work_Force/view/screens/pre_sales/add_lead_from_contacts/contact_list_screen.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/add_lead_screen/add_new_lead_managment.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:work_Force/view/screens/pre_sales/pre_sale_screen.dart';
import 'package:work_Force/view/settings_module/tracking/user/user_field_work/user_management_controller.dart';
import 'package:work_Force/view/widget/popup_with_lottie.dart';
import '../../../../Model/login_model.dart' as loginModel;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var items = ['3', '6', '9', '12'];

  late List<BarChartGroupData> showingBarGroups;
  final homeController = Get.put(HomeController());
  final initialController = Get.put(InitialController());
  final userManagementController = Get.put(UserManagementController());

  final textWidgetController = Get.put(HomeScreenTextController());
  final leadController = Get.put(GetLeadController());
  final contactController = Get.put(LeadContactDetaisController());
  final settingsController = Get.put(SettingsController());

  // final GlobalController globalController = Get.find();

  final globalController = Get.put(GlobalController());
  // final settingsController = Get.put(SettingsController());
  // final generalMasterController = Get.put(GeneralMasterController());

  @override
  void initState() {
    super.initState();

    homeController.getCompanyDetails();
    homeController.getCompanyLogoName();
    // settingsController.onInit();
    // generalMasterController.onInit();
    // globalController.onInit();
    getdata();
    todayDetails();
    setState(() {
      Timer(Duration.zero, () => getCompanyLogo());
    });
  }

  todayDetails() async {
    await leadController.getLeadList(
        "", 1, "desc", "leadGenerationDate", "", false, "0", "0", "");
    print("lead length--${leadController.leadList.length}");
    leadController.filteredLeadList.value =
        leadController.leadList.where((item) {
      return item.followUpDate != null &&
          DateClass().showDate(item.followUpDate!) ==
              leadController.dataForSelectedDate.value;
    }).toList();
    var amt = leadController.filteredLeadList.fold(0.0, (sum, item) {
      return sum + item.amount!;
    });
    leadController.totalLeadAmt.value = amt.round();
    print("totalAmount-today-${leadController.totalLeadAmt.value}");
  }

  getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = loginModel.LoginModel.fromJson(logindecoded);

    setState(() {
      homeController.username.value = loginDetails.user!.username ?? "";
    });

    if (loginDetails!.user!.roles != null) {
      for (var role in loginDetails!.user!.roles!) {
        print("user role id-----${role.roleType!.id}");
        // bool isAdminIdmatches = userList.any(
        //   (element) => element.roleIds?.contains(role.id) ?? false,
        // );

        if (role.roleType!.id == 1) {
          homeController.isLoginIdIsAdmin.value = true;
          homeController.isLoginIdIsbranchmanger.value = true;
          print("Role admin ${role.roleType!.id} exists in userList.");
        } else if (role.roleType!.id == 4) {
          homeController.isLoginIdIsbranchmanger.value = true;
          print("Role branch  ${role.roleType!.id} exists in userList.");
        } else {
          homeController.isLoginIdIsAdmin.value = false;
          homeController.isLoginIdIsbranchmanger.value = false;
          print("Role ID ${role.roleType!.id} doesn't exist in userList.");
        }

        log("is admin logged in - " +
            homeController.isLoginIdIsAdmin.value.toString());

        sharedPreferences.setBool(
            "isAdmin", homeController.isLoginIdIsAdmin.value);
      }
    } else {
      print("No roles assigned to the user.");
    }

    print("username ------------- ${homeController.username.value}");
  }

  CompanyModel? companyDetails;

  getCompanyLogo() async {
    print("inside--company logo loading ");
    String newvalue = SharedPreferencesService.instance
        .getValue(SharedPrefKeys().CompanyLogoKey);
    //decoding string to uint8list
    homeController.companyLogo.value = base64Decode(newvalue);
  }

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
        child: SafeArea(
          child: Stack(
            children: [
              Scaffold(
                body: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: kColorwhite,
                      toolbarHeight: 7.h,
                      pinned: true,
                      floating: true,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      // leading: Icon(Icons.menu),
                      flexibleSpace: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints raints) {
                          double offset = raints.biggest.height;

                          bool shouldShowWidget =
                              offset < 8.h; // Adjust this threshold as needed
                          if (shouldShowWidget !=
                              homeController.showWidget.value) {
                            // Only update the state if visibility changes
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              // This code will be executed after the build is complete
                              setState(() {
                                homeController.showWidget.value =
                                    shouldShowWidget;
                              });
                            });
                          }
                          return FlexibleSpaceBar(
                            background: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 2.w),
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      // print("company profile loading");
                                      // await Get.to(CompanyDetailsScreen(
                                      //   companyDetails: companyDetails!,

                                      //   // companyLogo: companyLogo,
                                      // ));
                                      // ZoomDrawer.of(context)!.toggle();
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.w,
                                          child: Image.asset(logoIcon,
                                              fit: BoxFit.fill),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                          child: Text(
                                            "Welcome\n${homeController.username.value}..!!",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                color: kColorblack),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() {
                                    final imageData =
                                        homeController.companyLogo.value;
                                    if (imageData != null) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return UploadCompanyLogoWidget(
                                                buttonText: "Change Logo",
                                                ontap: () async {
                                                  var file =
                                                      await homeController
                                                          .obtainImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);

                                                  await homeController
                                                      .uploadImage(file!);

                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Hero(
                                          tag: 'company_image',
                                          child: Container(
                                            // padding: EdgeInsets.all(3.w),
                                            margin: EdgeInsets.all(2.w),
                                            height: 10.h,
                                            width: 35.w,
                                            // width: 25.w,
                                            decoration: BoxDecoration(
                                                // boxShadow: kElevationToShadow[2],
                                                // color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(5.w),
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                      homeController
                                                          .companyLogo.value!),
                                                  // fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return UploadCompanyLogoWidget(
                                                buttonText: "Upload Logo",
                                                ontap: () async {
                                                  var file =
                                                      await homeController
                                                          .obtainImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);

                                                  await homeController
                                                      .uploadImage(file!);

                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Hero(
                                          tag: 'company_image',
                                          child: Container(
                                            // padding: EdgeInsets.all(3.w),
                                            margin: EdgeInsets.all(2.w),
                                            height: 10.h,
                                            width: 35.w,
                                            // width: 25.w,
                                            decoration: BoxDecoration(
                                              // boxShadow: kElevationToShadow[2],
                                              // color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  })
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      title: AnimatedSwitcher(
                        duration: Duration(milliseconds: 1200),
                        child: homeController.showWidget.value
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("company profile loading 2");
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                          child: Image.asset(logoIcon,
                                              fit: BoxFit.fill),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        SizedBox(
                                            // width: 30.w,
                                            child: Text(
                                          "${homeController.username.value}..!!",
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              color: kColorblack),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() {
                                    final imageData =
                                        homeController.companyLogo.value;
                                    if (imageData != null) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return UploadCompanyLogoWidget(
                                                buttonText: "Change Logo",
                                                ontap: () async {
                                                  var file =
                                                      await homeController
                                                          .obtainImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);

                                                  await homeController
                                                      .uploadImage(file!);

                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Hero(
                                          tag: 'company_image',
                                          child: Container(
                                            // padding: EdgeInsets.all(3.w),
                                            margin: EdgeInsets.all(2.w),
                                            height: 10.h,
                                            width: 29.w,
                                            // width: 25.w,
                                            decoration: BoxDecoration(
                                                // boxShadow: kElevationToShadow[2],
                                                // color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(5.w),
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                      homeController
                                                          .companyLogo.value!),
                                                  // fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return UploadCompanyLogoWidget(
                                                buttonText: "Upload Logo",
                                                ontap: () async {
                                                  var file =
                                                      await homeController
                                                          .obtainImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);

                                                  await homeController
                                                      .uploadImage(file!);

                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Hero(
                                          tag: 'company_image',
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.amberAccent,
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  })
                                ],
                              )
                            : SizedBox(),
                      ),

                      // title: Text(homeController.username.value,style: TextStyle(color: kColorblack),),

                      expandedHeight: 14.h,
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            FadeInDown(
                              delay: Duration(milliseconds: 600),
                              duration: Duration(milliseconds: 800),
                              child: Container(
                                height: 30.h,
                                margin: EdgeInsets.all(1.w),
                                padding: EdgeInsets.only(bottom: 2.h),
                                //  color: Colors.blue,
                                child: Lottie.asset(
                                  transactionLottie,
                                  repeat: false,
                                  alignment: Alignment.centerLeft,
                                  addRepaintBoundary: false,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeInLeft(
                                    delay: Duration(milliseconds: 600),
                                    duration: Duration(milliseconds: 800),
                                    child: Row(
                                      children: [
                                        customLeadCreateButton(
                                            Icons.contact_page_rounded,
                                            "Import From Contacts", () async {
                                          await contactController
                                              .fetchContacts();
                                          Get.to(
                                            () => ContactListScreen(
                                              materialList:
                                                  leadController.materialLists,
                                              serviceList:
                                                  leadController.serviceLists,
                                              isFromHomeScreen: true,
                                            ),
                                          );
                                        }),
                                        customLeadCreateButton(
                                            Icons.add, "Create New Lead", () {
                                          Get.to(
                                              () => NewLeadManagementAddScreen(
                                                    isEdit: false,
                                                    materialList: leadController
                                                        .materialLists,
                                                    serviceList: leadController
                                                        .serviceLists,
                                                    isFromHomeScreen: true,
                                                  ),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              transition: Transition.fadeIn);
                                        }),
                                        customLeadCreateButton(
                                            Icons.arrow_forward_ios_rounded,
                                            " View Lead Management", () {
                                          Get.to(
                                              LeadManagementListScreen(
                                                isFromHomeScreen: true,
                                              ),
                                              transition: Transition.fade,
                                              duration: const Duration(
                                                  milliseconds: 600));
                                        }),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  FadeInUp(
                                    delay: Duration(milliseconds: 600),
                                    duration: Duration(milliseconds: 800),
                                    child: Container(
                                      // height: 80.h,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue[50],
                                        borderRadius:
                                            BorderRadius.circular(5.w),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    FadeInUp(
                                                      delay: Duration(
                                                          milliseconds: 400),
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                      child: ContainerCustom(
                                                        height: 21.9.h,
                                                        width: 45.w,
                                                        title:
                                                            "Today's Leads Amount",
                                                        textColor:
                                                            Colors.purple,
                                                        containerColor: const [
                                                          Colors.white,
                                                          Colors.white
                                                        ],
                                                        details: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Obx(() =>
                                                                  SizedBox(
                                                                    width: 35.w,
                                                                    child: Text(
                                                                      "₹ ${leadController.totalLeadAmt.toString()}",
                                                                      style: TextStyle(
                                                                          fontSize: 17
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Obx(() => Text(
                                                                    "Lead count - ${leadController.filteredLeadList.length.toString()}",
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  children: [
                                                    FadeInRight(
                                                      delay: Duration(
                                                          milliseconds: 400),
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          leadController
                                                              .StatusfromPreSalesScreen
                                                              .value = false;
                                                          leadController
                                                              .fromPreSalesScreen
                                                              .value = false;
                                                          Get.off(
                                                              () =>
                                                                  LeadManagementListScreen(
                                                                    isFromHomeScreen:
                                                                        true,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      600));
                                                        },
                                                        child: ContainerCustom(
                                                          height: 10.5.h,
                                                          width: 41.w,
                                                          title: "All Leads",
                                                          textColor:
                                                              Colors.amber,
                                                          containerColor: const [
                                                            Colors.white,
                                                            Colors.white
                                                          ],
                                                          details: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Obx(() => Text(
                                                                      leadController
                                                                          .totalLeadCount
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize: 18
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    FadeInRight(
                                                      delay: Duration(
                                                          milliseconds: 500),
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          leadController
                                                              .StatusfromPreSalesScreen
                                                              .value = true;
                                                          Get.to(
                                                              () =>
                                                                  LeadManagementListScreen(
                                                                    isFromHomeScreen:
                                                                        true,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      600));
                                                        },
                                                        child: ContainerCustom(
                                                          height: 10.5.h,
                                                          width: 41.w,
                                                          title: "New Leads",
                                                          textColor:
                                                              Colors.green,
                                                          containerColor: const [
                                                            Colors.white,
                                                            Colors.white
                                                          ],
                                                          details: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Obx(() => Text(
                                                                      leadController
                                                                          .totalNewLeadsCount
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize: 18
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.2.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                missedFollowUpBottomSheet(
                                                    context: context,
                                                    controller: leadController);
                                              },
                                              child: FadeInLeft(
                                                delay:
                                                    Duration(milliseconds: 600),
                                                duration:
                                                    Duration(milliseconds: 800),
                                                child: ContainerCustom(
                                                  height: 10.h,
                                                  width: double.infinity,
                                                  title: "Missed Status",
                                                  textColor: Colors.black,
                                                  containerColor: const [
                                                    Colors.white,
                                                    Colors.white
                                                  ],
                                                  details: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 35.w,
                                                          child: Text(
                                                            "Missed Follow Up",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .amber
                                                                    .shade900),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Obx(() => Text(
                                                              leadController
                                                                  .missedFollowUpCount
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                        SizedBox(
                                                          width: 2.h,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => Visibility(
                    visible: homeController.isPageLoading.value,
                    child: Positioned.fill(
                      child: Container(
                        color: kColorblack.withOpacity(0.5),
                        child: Center(
                          child: LoadingAnimationWidget.threeRotatingDots(
                            color: Colors.lightBlue,
                            size: 10.w,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  SizedBox customLeadCreateButton(
      IconData icons, String titleName, VoidCallback onTap) {
    return SizedBox(
      width: 30.w,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
                backgroundColor: Colors.lightBlue[100],
                radius: 7.w,
                child: Icon(
                  icons,
                  color: kColorblack,
                  size: 20.sp,
                )),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
                width: 25.w,
                child: Text(titleName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: kColorblack))),
          ],
        ),
      ),
    );
  }
}

class UploadCompanyLogoWidget extends StatelessWidget {
  const UploadCompanyLogoWidget({
    super.key,
    required this.ontap,
    required this.buttonText,
  });

  final VoidCallback ontap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.w))),
      title: Text('Upload Company Logo!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: ontap,
              child: Container(
                height: 6.h,
                width: 30.w,
                decoration: BoxDecoration(
                    color: kColorlightBlue,
                    borderRadius: BorderRadius.circular(5.w)),
                child: Center(
                    child: Text(
                  buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kColorwhite),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
