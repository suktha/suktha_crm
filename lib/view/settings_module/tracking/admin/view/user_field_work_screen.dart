// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, camel_case_types

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Model/user_model.dart';
import 'package:work_Force/utils/Services/websocket_location_services.dart';
import 'package:work_Force/view/settings_module/tracking/admin/controller/filed_work_controller.dart';
import 'package:work_Force/view/settings_module/tracking/admin/controller/location_controller.dart';
import 'package:work_Force/view/settings_module/tracking/admin/view/widgets.dart';
import 'package:work_Force/view/widget/snackbar.dart';

import '../../../../../utils/responsive_utils.dart';
import 'geolocation_screen.dart';
class UserFieldWorkScreen extends StatefulWidget {
  const UserFieldWorkScreen({super.key});

  @override
  State<UserFieldWorkScreen> createState() => _UserFieldWorkScreenState();
}

class _UserFieldWorkScreenState extends State<UserFieldWorkScreen> {
  final FieldWorkController controller = Get.put(FieldWorkController());
  GeoLocationController geoLocationController = Get.find<GeoLocationController>();

  @override
  void initState() {
    super.initState();
    controller.getUserList();
  }

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              title: const Text("Field Sales"),
              titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: width * 0.055),
              centerTitle: true,
              backgroundColor: kColorwhite,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      controller.getUserList();
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
                  size: 25,
                ),
                onPressed: (() {
                  Get.back();
                }),
              )),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(width * 0.02),
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                        child: TextField(
                          onChanged: (value) async {
                            controller.filteredUserList.value =
                                controller.userList.where((user) => user.name!.toLowerCase().contains(value.toLowerCase())).toList();
                          },
                          // controller: controller.searchController,
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
                  ],
                ),
                Obx(() => Expanded(
                      child: userListView(
                        userList: controller.filteredUserList,
                        width: width,
                        controller: controller,
                        height: height,
                        onTapUser: (item, index) async {
                          controller.timelineItems.clear();
                          geoLocationController.userLocations.clear();
                          await Get.find<WebSocketService>().initializeConnection(userId: item.id, leadId: null);

                          // controller.GetLeadEventByUser(userId: item.id!, eventDate: DateTime.now().toString());
                          showUserBottomSheet(context: context, item: item, index: index, width: width, height: height, isActive: true);
                        },
                        onDelete: (index) {
                          // controller.deleteLiveUser(index);
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
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

  Color getRandomLightColor(int index) {
    // Generate a unique hue based on the index
    double hue = (index * 137.5) % 360; // 137.5 degrees apart ensures good separation
    return HSVColor.fromAHSV(1, hue, 0.3, 0.5).toColor();
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
                      backgroundColor: getRandomLightColor(index),
                      child: Icon(Icons.person_pin, size: width * 0.07, color: kColorLightGrey)),
                  title: Text(item.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.045)),
                  trailing: Text(item.active == 1 ? "Active" : "Inactive")),
              SizedBox(height: height * 0.02),

              DateHistoryWidget(
                onDateSelected: (selectedDate) async {
                  print("Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}");
                  await controller.GetLeadEventByUser(userId: item.id!, eventDate: selectedDate.toString());
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

                  List<Map<String, dynamic>> currentTripEvents = []; // to store only events of current trip

                  for (int i = 0; i < allItems.length; i++) {
                    var item = allItems[i];

                    if (item['isHeader'] == true) {
                      // 🛡 If already have old trip events, draw them first
                      if (currentTripEvents.isNotEmpty) {
                        children.addAll(buildTripTimeline(currentTripEvents));
                        currentTripEvents.clear(); // reset for new trip
                      }

                      String transId = item['transId'] ?? '';
                      String leadNumber = transId.isNotEmpty ? (controller.leadNames[transId] ?? "Loading Lead...") : "Unknown Lead";

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
                    print("last one" + "${currentTripEvents.length - 1}");
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
                              final latestTripTimeline = <Map<String, dynamic>>[];

                              for (final item in allItems) {
                                if (item['isHeader'] == true) {
                                  headerCount++;
                                  if (headerCount == 2) break;
                                  continue;
                                }

                                if (headerCount == 1) {
                                  latestTripTimeline.add(item);
                                }
                                print("latestTripTimeline: $latestTripTimeline");
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
                                customSnackbar("Cancelled", "You cancelled the connection attempt.", "warning");
                              }

                              showLoadingDialogWithStages(
                                messages: messages,
                                lottieFiles: lottieFiles,
                                onCancel: cancelConnection,
                              );

                              timeout = Timer(const Duration(seconds: 40), () {
                                listener();
                                Get.back();
                                customSnackbar("Timeout", "Unable to connect with user. Please try again later.", "error");
                              });

                              listener = ever(geoLocationController.userLocations, (list) async {
                                if ((list as List).isNotEmpty) {
                                  timeout.cancel();
                                  listener();
                                  Get.back(); // Close loading

                                  showSuccessDialog();
                                  await Future.delayed(const Duration(seconds: 2));
                                  Get.back(); // Close success

                                  Get.to(
                                    () => UserLocationScreen(timelineEvents: latestTripTimeline),
                                    transition: Transition.fade,
                                    duration: const Duration(milliseconds: 1000),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                currentIndex == messages.length - 1
                    ? ElevatedButton.icon(
                        onPressed: onCancel,
                        icon: Icon(Icons.cancel, color: Colors.white),
                        label: Text("Cancel", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Rounded edges
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                onTap: () => controller.openGoogleMaps(event['latitude'], event['longitude']),
                child: Text(
                  "View Location",
                  style: TextStyle(
                    shadows: [Shadow(color: Colors.blue, offset: Offset(0, -5))],
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}
