// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, deprecated_member_use, library_prefixes
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
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
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';
import 'package:work_Force/view/screens/My_account/more_module/tracking/user/user_field_work/user_management_controller.dart';
import 'package:work_Force/view/screens/Task_Managment/view/add_task_screen.dart';
import 'package:work_Force/view/screens/home_screen/view/checkInOut_screen.dart';
import 'package:work_Force/view/screens/home_screen/view/notification_screen.dart';
import 'package:work_Force/view/screens/home_screen/view/quick_task_screen.dart';
import 'package:work_Force/view/screens/home_screen/view/team_progress_screen.dart';
import 'package:work_Force/view/screens/home_screen/view/user_progress.dart';
import 'package:work_Force/view/screens/pre_sales/add_lead_from_contacts/contact_list_screen.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/add_lead_screen/add_new_lead_managment.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:work_Force/view/widget/popup_with_lottie.dart';
import '../../../../Model/login_model.dart' as loginModel;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var items = ['3', '6', '9', '12'];
  final Map<String, dynamic> userProgress = {
    "name": "Karan",
    "role": "Technician",
    "completed": 12,
    "pending": 3,
    "today": 2,
    "rating": 4.6,
  };

  final List<Map<String, dynamic>> teamData = [
    {
      "name": "Ajith",
      "completed": 18,
      "total": 20,
      "rating": 4.5,
    },
    {
      "name": "Prakash",
      "completed": 12,
      "total": 20,
      "rating": 3.8,
    },
    {
      "name": "Anjali",
      "completed": 20,
      "total": 20,
      "rating": 5.0,
    },
  ];

  late List<BarChartGroupData> showingBarGroups;
  final homeController = Get.put(HomeController());
  final initialController = Get.put(InitialController());
  final userManagementController = Get.put(UserManagementController());

  final leadController = Get.put(GetLeadController());
  final contactController = Get.put(LeadContactDetaisController());
  final settingsController = Get.put(SettingsController());
  final globalController = Get.put(GlobalController());

  final GlobalKey _checkInCardKey = GlobalKey();
  final GlobalKey _createTaskKey = GlobalKey();
  final GlobalKey _viewLeadKey = GlobalKey();
  bool showcaseStarted = false;

  @override
  void initState() {
    super.initState();
    homeController.getCompanyDetails();
    homeController.getCompanyLogoName();
    getdata();
    todayDetails();
    setState(() {
      Timer(Duration.zero, () => getCompanyLogo());
    });
  }

  Future<void> _checkAndStartShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstLaunch') ?? true;

    // if (isFirstTime) {
    //   await prefs.setBool('isFirstLaunch', false);
    //   ShowCaseWidget.of(context).startShowCase([
    //     _checkInCardKey,
    //     _createTaskKey,
    //     _viewLeadKey,
    //   ]);
    // }
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
        } else if (role.roleType!.id == 4) {
          homeController.isLoginIdIsbranchmanger.value = true;
          homeController.isLoginIdIsAdmin.value = false;
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
    print("isAdmin: ${homeController.isLoginIdIsAdmin}");

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
    return ShowCaseWidget(builder: (context) {
      if (!showcaseStarted) {
        showcaseStarted = true;

        // Delay the call to ensure context is ready
        // Future.delayed(Duration(milliseconds: 300), () {
        //   ShowCaseWidget.of(context).startShowCase([
        //     _createTaskKey,
        //     _viewLeadKey,
        //     _checkInCardKey
        //   ]);
        // });
      }
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
                  body: HomeWidget2(context),
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
    });
  }

  Widget HomeWidget2(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: kColorwhite,
          toolbarHeight: 8.h,
          pinned: true,
          floating: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading: Icon(Icons.menu),
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints raints) {
              double offset = raints.biggest.height;

              bool shouldShowWidget =
                  offset < 9.h; // Adjust this threshold as needed
              if (shouldShowWidget != homeController.showWidget.value) {
                // Only update the state if visibility changes
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // This code will be executed after the build is complete
                  setState(() {
                    homeController.showWidget.value = shouldShowWidget;
                  });
                });
              }
              return FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                  // color: Colors.red,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 3.w,
                          ),
                          Showcase(
                            key: _createTaskKey,
                            title: "Your Account",
                            description:
                                'Tap here to view your account details.',
                            child: GestureDetector(
                              onTap: () =>
                                  Get.find<NavigationController>().changeTab(3),
                              child: SizedBox(
                                width: 12.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.w),
                                  child: Image.asset(
                                    "assets/Images/profile_pic.jpg",
                                    fit: BoxFit.fill,
                                    height: 12.w,
                                    width: 12.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                        ],
                      ),
                      Spacer(),
                      Showcase(
                        key: _viewLeadKey,
                        title: "Notifications",
                        description: 'Tap here to view your notifications.',
                        child: CircleAvatar(
                          backgroundColor: kColorLightGrey,
                          child: IconButton(
                              onPressed: () {
                                Get.to(NotificationHistoryScreen());
                              },
                              icon: Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.grey.shade600,
                                // size: 20.sp,
                              )),
                        ),
                      )
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
                            GestureDetector(
                              onTap: () =>
                                  Get.find<NavigationController>().changeTab(3),
                              child: SizedBox(
                                width: 10.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.w),
                                  child: Image.asset(
                                    "assets/Images/profile_pic.jpg",
                                    fit: BoxFit.fill,
                                    height: 10.w,
                                    width: 10.w,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: kColorLightGrey,
                        child: IconButton(
                            onPressed: () {
                              Get.to(NotificationHistoryScreen(),
                                  duration: const Duration(milliseconds: 400),
                                  transition: Transition.rightToLeft);
                            },
                            icon: Icon(
                              Icons.notifications_none_rounded,
                              color: Colors.grey.shade600,
                              // size: 19.sp,
                            )),
                      )
                    ],
                  )
                : SizedBox(),
          ),
          expandedHeight: 12.h,
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                FadeInDown(
                  delay: Duration.zero,
                  duration: Duration(milliseconds: 800),
                  child: Showcase(
                    title: "Check In/Out",
                    description: 'Tap here to check in or out.',
                    key: _checkInCardKey,
                    child: Container(
                        // height: 30.h,
                        margin: EdgeInsets.all(1.w),
                        padding: EdgeInsets.only(bottom: 2.h),
                        //  color: Colors.blue,
                        child: CheckInOutCard(
                          homeController: homeController,
                        )),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                FadeInLeft(
                    delay: Duration.zero,
                    duration: Duration(milliseconds: 800),
                    child: Padding(
                      padding: EdgeInsets.only(left: 1.w, right: 1.w),
                      child: QuickTaskNotification(),
                    )),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInLeft(
                        delay: Duration(milliseconds: 600),
                        duration: Duration(milliseconds: 800),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customLeadCreateButton(
                              Icons.add_task,
                              "Create Task",
                              () async {
                                // await contactController
                                //     .fetchContacts();
                                Get.to(() => AddTaskScreen(
                                      isEdit: false,
                                      Iscompleted: false,
                                    ));
                              },
                              const Color.fromARGB(29, 255, 64, 128),
                              Colors.pink,
                            ),
                            customLeadCreateButton(
                              Icons.add,
                              "Create Lead",
                              () {
                                Get.to(
                                    () => NewLeadManagementAddScreen(
                                          isEdit: false,
                                          materialList:
                                              leadController.materialLists,
                                          serviceList:
                                              leadController.serviceLists,
                                          isFromHomeScreen: true,
                                        ),
                                    duration: const Duration(milliseconds: 500),
                                    transition: Transition.fadeIn);
                              },
                              const Color.fromARGB(36, 33, 149, 243),
                              Colors.blue,
                            ),
                            customLeadCreateButton(
                              Icons.contact_page_outlined,
                              "Import",
                              () async {
                                await contactController.fetchContacts();
                                Get.to(
                                  () => ContactListScreen(
                                    materialList: leadController.materialLists,
                                    serviceList: leadController.serviceLists,
                                    isFromHomeScreen: true,
                                  ),
                                );
                              },
                              const Color.fromARGB(38, 223, 64, 251),
                              const Color.fromARGB(195, 87, 57, 140),
                            ),
                            customLeadCreateButton(
                              Icons.arrow_forward_ios_rounded,
                              " View Lead",
                              () {
                                Get.to(
                                    LeadManagementListScreen(
                                      isFromHomeScreen: true,
                                    ),
                                    transition: Transition.fade,
                                    duration:
                                        const Duration(milliseconds: 600));
                              },
                              const Color.fromARGB(56, 255, 172, 64),
                              Colors.orange,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      homeController.isLoginIdIsAdmin.value == true
                          ? FadeInRight(
                              delay: Duration.zero,
                              duration: Duration(milliseconds: 800),
                              child: TeamProgressCard(
                                teamData: teamData,
                              ))
                          : FadeInRight(
                              delay: Duration.zero,
                              duration: Duration(milliseconds: 800),
                              child: UserProgressScreen(
                                  homeController: homeController,
                                  userProgress: userProgress)),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

SizedBox customLeadCreateButton(IconData icons, String titleName,
    VoidCallback onTap, Color bgColor, Color iconColor) {
  return SizedBox(
    // width: 25.w,
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: bgColor,
              radius: 6.w,
              child: Icon(
                icons,
                color: iconColor,
                size: 20.sp,
              )),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
              width: 20.w,
              child: Text(titleName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: kColorblack))),
        ],
      ),
    ),
  );
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
