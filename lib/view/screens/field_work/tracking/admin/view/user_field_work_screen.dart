// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Model/login_model.dart' as loginModel;
import 'package:work_Force/Model/user_model.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/utils/Services/websocket_location_services.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/controller/filed_work_controller.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/controller/location_controller.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/view/widgets.dart';
import 'package:work_Force/view/widget/snackbar.dart';

import '../../../../../../utils/responsive_utils.dart';
import 'geolocation_screen.dart';

class UserFieldWorkScreen extends StatefulWidget {
  const UserFieldWorkScreen({super.key});

  @override
  State<UserFieldWorkScreen> createState() => _UserFieldWorkScreenState();
}

class _UserFieldWorkScreenState extends State<UserFieldWorkScreen> {
  final FieldWorkController controller = Get.put(FieldWorkController());
  GeoLocationController geoLocationController =
      Get.find<GeoLocationController>();
  final homeController = Get.find<HomeController>();

  getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = loginModel.LoginModel.fromJson(logindecoded);

    setState(() {
      homeController.username.value = loginDetails.user!.username ?? "";
    });

    if (loginDetails.user!.roles != null) {
      print("role id----${loginDetails.user!.id}");
      print("role-name----${loginDetails.user!.name}");

      controller.loggedUserId.value = loginDetails.user!.id!;
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

        log("is admin logged in - ${homeController.isLoginIdIsAdmin.value}");

        sharedPreferences.setBool(
            "isAdmin", homeController.isLoginIdIsAdmin.value);
      }
    } else {
      print("No roles assigned to the user.");
    }
    print("isAdmin: ${homeController.isLoginIdIsAdmin}");

    print("username ------------- ${homeController.username.value}");
  }

  @override
  void initState() {
    super.initState();
    controller.getUserRoleList("");
    controller.getUserList(homeController.isLoginIdIsAdmin.value);
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);

    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
                title: const Text("Field Report"),
                titleTextStyle: TextStyle(
                    color: kColorblack,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.055),
                centerTitle: true,
                backgroundColor: kColorwhite,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        controller
                            .getUserList(homeController.isLoginIdIsAdmin.value);
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: kColorblack,
                      )),
                  Obx(
                    () => controller.isExpanded.value == true
                        ? SizedBox()
                        : IconButton(
                            onPressed: () {
                              controller.showSearchBarFunction();
                              // controller.toggleMapSize();
                            },
                            icon: Icon(
                              Icons.search,
                              color: kColorblack,
                            )),
                  )
                ],
                leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: kColorblack,
                    size: 25,
                  ),
                  onPressed: (() {
                    Get.back();
                    controller.isExpanded.value = false;
                  }),
                )),
            body: homeController.isLoginIdIsAdmin.value == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => controller.showSearchBar.value
                          ? Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(width * 0.02),
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                          BorderRadius.circular(width * 0.03),
                                    ),
                                    child: TextField(
                                      onChanged: (value) async {
                                        controller.filteredUserList.value =
                                            controller.userList
                                                .where((user) => user.name!
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase()))
                                                .toList();
                                      },
                                      // controller: controller.searchController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: 'Search Here',
                                        hintStyle:
                                            TextStyle(color: kColorblack45),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox()),
                      Obx(() {
                        controller.isExpanded.value
                            ? Text(" Track active field users",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey.shade600))
                            : SizedBox();
                        double availableHeight =
                            MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top -
                                kToolbarHeight;
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: controller.isExpanded.value
                              ? availableHeight / 1
                              : availableHeight / 4,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(37.7749, -122.4194),
                                  zoom: 12,
                                ),
                                markers: controller.activeUsers,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: true,
                                onTap: (_) => controller.clearSelection(),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: FloatingActionButton(
                                  mini: true,
                                  backgroundColor: kColorLightGrey,
                                  onPressed: () {
                                    controller.toggleMapSize();
                                    if (controller.isExpanded.value) {
                                      controller.loadActiveUsers();
                                    }
                                  },
                                  child: Icon(
                                    controller.isExpanded.value
                                        ? Icons.fullscreen_exit
                                        : Icons.fullscreen,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              Obx(() {
                                final selected = controller.selectedUser.value;
                                if (selected == null)
                                  return const SizedBox.shrink();

                                return Positioned(
                                  bottom: 20,
                                  left: 20,
                                  right: 20,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          child: Icon(Icons.person,
                                              color: Colors.white),
                                        ),
                                        title: Text(selected['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        subtitle: Text(selected['address']),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: controller.clearSelection,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      }),
                      Obx(() => Expanded(
                            child: userListView(
                              isAdmin: homeController.isLoginIdIsAdmin.value,
                              userList: controller.filteredUserList,
                              width: width,
                              controller: controller,
                              height: height,
                              onTapUser: (item, index) async {
                                controller.timelineItems.clear();
                                geoLocationController.userLocations.clear();
                                await Get.find<WebSocketService>()
                                    .initializeConnection(
                                        userId: item.id, leadId: null);

                                // controller.GetLeadEventByUser(userId: item.id!, eventDate: DateTime.now().toString());
                                showUserBottomSheet(
                                    context: context,
                                    item: item,
                                    index: index,
                                    width: width,
                                    height: height,
                                    isActive: true);
                              },
                              onDelete: (index) {
                                // controller.deleteLiveUser(index);
                              },
                            ),
                          )),
                    ],
                  )
                : Column(
                    children: [
                      Obx(() => Expanded(
                            child: userListView(
                              isAdmin: homeController.isLoginIdIsAdmin.value,
                              userList: controller.filteredUserList,
                              width: width,
                              controller: controller,
                              height: height,
                              onTapUser: (item, index) async {
                                controller.timelineItems.clear();
                                geoLocationController.userLocations.clear();
                                await Get.find<WebSocketService>()
                                    .initializeConnection(
                                        userId: item.id, leadId: null);

                                // controller.GetLeadEventByUser(userId: item.id!, eventDate: DateTime.now().toString());
                                showUserBottomSheet(
                                    context: context,
                                    item: item,
                                    index: index,
                                    width: width,
                                    height: height,
                                    isActive: true);
                              },
                              onDelete: (index) {
                                // controller.deleteLiveUser(index);
                              },
                            ),
                          )),
                    ],
                  )),
        Obx(() => Visibility(
              visible: controller.isPageLoading.value,
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
    );
  }

  String getImageForIndex(int index) {
    final List<String> images = [
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'https://images.unsplash.com/photo-1480455624313-e29b44bbfde1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D'
          'https://writestylesonline.com/wp-content/uploads/2018/11/Three-Statistics-That-Will-Make-You-Rethink-Your-Professional-Profile-Picture.jpg',
      'https://media.gettyimages.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=gi&k=20&c=LsB3LmCoN69U82LEYU78IC2tNwOMjy7LJlmEj30UOSs=',
    ];
    return images[
        index % images.length]; // Loops through images if index is large
  }

  void showUserBottomSheet(
      {required BuildContext context,
      required UserModel item,
      required int index,
      required double width,
      required double height,
      required bool isActive}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: kColorwhite,
          padding: EdgeInsets.all(width * 0.02),
          margin: EdgeInsets.only(top: height * 0.05),
          child: Column(
            children: [
              ListTile(
                  leading: CircleAvatar(
                      radius: width * 0.06,
                      backgroundImage: NetworkImage(getImageForIndex(index))),
                  title: Text(item.name!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.045)),
                  trailing: Text(
                    item.active == 1 ? "Active" : "Inactive",
                    style: TextStyle(
                        color: item.active == 1 ? Colors.green : kColorblack),
                  )),
              SizedBox(height: height * 0.02),

              DateHistoryWidget(
                onDateSelected: (selectedDate) async {
                  print(
                      "Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}");
                  await controller.GetLeadEventByUser(
                      userId: item.id!, eventDate: selectedDate.toString());
                },
              ),

              SizedBox(height: height * 0.02),

              Obx(() {
                if (controller.timelineItems.isEmpty) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      "No Timeline Data",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                } else {
                  final allItems = controller.timelineItems;
                  List<Widget> children = [];

                  List<Map<String, dynamic>> currentTripEvents =
                      []; // to store only events of current trip

                  for (int i = 0; i < allItems.length; i++) {
                    var item = allItems[i];

                    if (item['isHeader'] == true) {
                      // 🛡 If already have old trip events, draw them first
                      if (currentTripEvents.isNotEmpty) {
                        children.addAll(buildTripTimeline(currentTripEvents));
                        currentTripEvents.clear(); // reset for new trip
                      }

                      String transId = item['transId'] ?? '';
                      String leadNumber = transId.isNotEmpty
                          ? (controller.leadNames[transId] ?? "Loading Lead...")
                          : "Unknown Lead";

                      // 🛡 Now add header
                      children.add(
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                          child: Text(
                            "${item['title']} :  $leadNumber",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      );
                    } else {
                      // 🛡 Normal event, add to current trip events
                      currentTripEvents.add(item);
                    }
                  }

                  // 🛡 After loop, if any pending events (Trip 3 case), draw them
                  if (currentTripEvents.isNotEmpty) {
                    print("last one" "${currentTripEvents.length - 1}");
                    children.addAll(buildTripTimeline(currentTripEvents));
                  }

                  return Container(
                    constraints: BoxConstraints(maxHeight: height * 0.64),
                    margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  );
                }
              }),

              Spacer(),
              isActive
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customButtonUserProfile(
                            height: height,
                            width: width,
                            title: "Track Live Location",
                            icon: Icons.my_location_sharp,
                            ontap: () {
                              final allItems = controller.timelineItems;

                              int headerCount = 0;
                              final latestTripTimeline =
                                  <Map<String, dynamic>>[];

                              for (final item in allItems) {
                                if (item['isHeader'] == true) {
                                  headerCount++;
                                  if (headerCount == 2) break;
                                  continue;
                                }

                                if (headerCount == 1) {
                                  latestTripTimeline.add(item);
                                }
                                print(
                                    "latestTripTimeline: $latestTripTimeline");
                              }
                              var latestTrip = latestTripTimeline.last;
                              var latestTripDate = latestTrip['time'];
                              print("latestTripDate: $latestTripDate");

                              // LiveLocationModel locationModel = LiveLocationModel(
                              //   id: "",
                              //   eventDateTime: latestTripDate,
                              //   longitude: latestTrip['longitude'],
                              //   latitude: latestTrip['latitude'],
                              //   userId: null,
                              //   userName: null,
                              //   eventName: null,
                              //   message: "",
                              //   reasonId: null,
                              //   destinationUrl: "",
                              //   transId: "",
                              //   eventDisplayName: "",
                              // );

                              // geoLocationController.addOrUpdateLocation(locationModel);

                              final messages = [
                                "Connecting to user, please wait...",
                                "Still trying to fetch user location...",
                                "Connection is taking longer than usual...",
                              ];

                              final lottieFiles = [
                                connectUserLottie,
                                connectUserLottie,
                                connectUserPendingLottie,
                              ];

                              late Worker listener;
                              late Timer timeout;

                              void cancelConnection() {
                                timeout.cancel();
                                listener();
                                Get.back(); // Close dialog
                                customSnackbar(
                                    "Cancelled",
                                    "You cancelled the connection attempt.",
                                    "warning");
                              }

                              showLoadingDialogWithStages(
                                messages: messages,
                                lottieFiles: lottieFiles,
                                onCancel: cancelConnection,
                              );

                              timeout = Timer(const Duration(seconds: 40), () {
                                listener();
                                Get.back();
                                customSnackbar(
                                    "Timeout",
                                    "Unable to connect with user. Please try again later.",
                                    "error");
                              });

                              listener =
                                  ever(geoLocationController.userLocations,
                                      (list) async {
                                print(
                                    "Triggered! userLocations: $list"); // DEBUG LOG

                                if ((list as List).isNotEmpty) {
                                  timeout.cancel();
                                  listener();
                                  Get.back(); // Close loading

                                  showSuccessDialog();
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  Get.back(); // Close success

                                  Get.to(
                                    () => UserLocationScreen(
                                        timelineEvents: latestTripTimeline),
                                    transition: Transition.fade,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                  );
                                }
                              });

                              // print(geoLocationController.userLocations.length);

                              // if (geoLocationController.userLocations.isNotEmpty) {
                              //   Get.to(
                              //     () => UserLocationScreen(timelineEvents: latestTripTimeline),
                              //     transition: Transition.fade,
                              //     duration: const Duration(milliseconds: 1000),
                              //   );
                              // } else {
                              //   customSnackbar("Try Again", "Waiting for the Connection..", "normal");
                              // }

                              //   Get.to(
                              //     () => UserLocationScreen(timelineEvents: latestTripTimeline),
                              //     transition: Transition.fade,
                              //     duration: const Duration(milliseconds: 1000),
                              //   );
                            },
                            color: kColorlightBlue),
                      ],
                    )
                  : SizedBox(),
              SizedBox(height: 2)

              // You can paste your full bottom sheet UI here exactly as you had it.
              // I recommend extracting that to another widget too if it's long.
            ],
          ),
        );
      },
    );
  }

  void showLoadingDialogWithStages({
    required List<String> messages,
    required List<String> lottieFiles,
    required VoidCallback onCancel,
  }) {
    int currentIndex = 0;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          // Change message every 10 seconds
          Timer.periodic(const Duration(seconds: 10), (timer) {
            if (currentIndex < messages.length - 1) {
              setState(() {
                currentIndex++;
              });
            } else {
              timer.cancel();
            }
          });

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  lottieFiles[currentIndex],
                ),
                const SizedBox(height: 20),
                Text(
                  messages[currentIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                currentIndex == messages.length - 1
                    ? ElevatedButton.icon(
                        onPressed: onCancel,
                        icon: Icon(Icons.cancel, color: Colors.white),
                        label: Text("Cancel",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Rounded edges
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          elevation: 3,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
  }

  void showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              successLottie, // ✅ A green checkmark or success animation
              width: 150,
              height: 150,
              repeat: false,

              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              "Connected successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  List<Widget> buildTripTimeline(List<Map<String, dynamic>> tripEvents) {
    return List.generate(tripEvents.length, (index) {
      final event = tripEvents[index];
      final isFirst = index == 0;
      final isLast = index == tripEvents.length - 1;

      return TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: isFirst,
        isLast: isLast,
        endChild: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Text(
                  event['action'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "At ${DateFormat('h:mm a | dd-MM-yyyy').format(event['time'])}",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => controller.openGoogleMaps(
                    event['latitude'], event['longitude']),
                child: Text(
                  "View Location",
                  style: TextStyle(
                    shadows: [
                      Shadow(color: Colors.blue, offset: Offset(0, -5))
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        indicatorStyle: IndicatorStyle(
          width: 30,
          color: event['color'] ?? Colors.white,
          padding: EdgeInsets.all(8),
          iconStyle: IconStyle(
            color: Colors.white,
            iconData: event['icon'] ?? Icons.ac_unit_rounded,
          ),
        ),
      );
    });
  }
}

class detailsWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double width;
  final double height;

  const detailsWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.width,
    required this.height,
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
              size: width * 0.05,
            ),
            SizedBox(
              width: width * 0.05,
            ),
            SizedBox(
              width: width * 0.80,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.04,
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
  final double width;
  final double height;

  const customButtonUserProfile({
    super.key,
    required this.title,
    required this.icon,
    required this.ontap,
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
            ),
            borderRadius: BorderRadius.circular(width * 0.03)),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: width * 0.05,
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.04,
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
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: Colors.grey[400], // Background color of the tab
            borderRadius: BorderRadius.circular(35)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}
