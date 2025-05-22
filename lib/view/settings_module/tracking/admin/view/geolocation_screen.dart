// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' as lt;
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/utils/share_helper.dart';
import 'package:work_Force/view/settings_module/tracking/admin/controller/location_controller.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class UserLocationScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? timelineEvents;

  const UserLocationScreen({
    super.key,
    this.timelineEvents,
  });

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  final controller = Get.put(GeoLocationController());

  Placemark? placemark;
  String placeName = "";

  List<Map<String, dynamic>> get timeline => widget.timelineEvents ?? [];

  void setMarkers() async {
    Set<Marker> markerSet = {};

    for (var user in controller.userLocations) {
      final String firstLetter = user.userName!.isNotEmpty ? user.userName![0].toUpperCase() : '?';
      final Uint8List markerIcon = await createMarkerFromText(firstLetter);

      final BitmapDescriptor customIcon = BitmapDescriptor.fromBytes(markerIcon);

      markerSet.add(
        Marker(
          infoWindow: InfoWindow(title: user.userName),
          markerId: MarkerId(user.userId.toString()),
          position: LatLng(user.latitude, user.longitude),
          onTap: () async {
            placemark = await controller.getPlaceDetailsFromCoordinates(user.latitude, user.longitude);

            placeName = '${placemark!.name}, '
                '${placemark!.street}, '
                '${placemark!.subLocality != null ? placemark!.subLocality! + ', ' : ''}'
                '${placemark!.locality}, '
                '${placemark!.administrativeArea}, '
                '${placemark!.postalCode}';

            controller.clearPolylines();
            setState(() {});

            print("ajith kk-- " + placeName);
            controller.selectedMarkerPosition.value = LatLng(user.latitude, user.longitude);
            controller.selectedMarkerData.value = user;
          },
          icon: customIcon,
        ),
      );
    }
    for (var event in timeline) {
      markerSet.add(
        Marker(
          markerId: MarkerId('event_${event['action']}_${event['time']}'),
          position: LatLng(event['latitude'], event['longitude']),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(
            title: event['action'],
            snippet: DateFormat('h:mm a | dd-MM-yyyy').format(event['time']),
          ),
        ),
      );
    }

    setState(() {
      controller.markerValue = markerSet;
    });
  }

  void updateUserLocations() {
    print("--updating");
    controller.userLocations.refresh();

    setMarkers();
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();

    // controller.userLocations.value = widget.userLocList;
    controller.initializeLocation();
    setMarkers();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => updateUserLocations());
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        LatLng center = controller.calculateCentroid();

        return controller.currentLocation.value == null
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeIn(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 300),
                    child: lt.LottieBuilder.asset("assets/lottie/geolocation.json"),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  FadeIn(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Updating user locations,\nJust a sec...",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 16.sp),
                    ),
                  )
                ],
              )) // Show loading indicator while fetching location
            : Stack(
                children: [
                  GoogleMap(
                    onTap: (argument) {
                      if (controller.polylines.isEmpty) {
                        controller.selectedMarkerPosition.value = null;
                        controller.viewActivity.value = false;
                      }
                    },
                    mapToolbarEnabled: false,
                    onMapCreated: controller.onMapCreated,
                    markers: controller.markerValue,
                    initialCameraPosition: CameraPosition(target: center, zoom: 15.0),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    polylines: controller.polylines,
                  ),
                  if (controller.isLocataionEnabled.value) customHeaderWidget(),
                  if (controller.isLocataionEnabled.value) customZoomWidget(controller: controller),
                  if (controller.isLocataionEnabled.value) customCurrentLocationWidget(controller: controller),
                  Obx(
                    () {
                      return controller.selectedMarkerPosition.value != null
                          ? Visibility(
                              visible: controller.selectedMarkerPosition.value != null,
                              child: Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: controller.polylines.isNotEmpty

                                      //polylines details
                                      ? FadeIn(
                                          child: Container(
                                            padding: EdgeInsets.all(2.w),
                                            margin: EdgeInsets.all(4.w),
                                            decoration: BoxDecoration(
                                              color: kColorwhite,
                                              boxShadow: kElevationToShadow[2],
                                              borderRadius: BorderRadius.circular(4.w),
                                            ),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: Container(
                                                    width: 13.w,
                                                    // height: 7.h,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                                        )),
                                                  ),
                                                  title: Text(
                                                    controller.selectedMarkerData.value?.userName ?? "",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                  ),
                                                  trailing: IconButton(
                                                      onPressed: () {
                                                        controller.clearPolylines();
                                                        setState(() {});
                                                      },
                                                      icon: Icon(Icons.close)),
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Selected Date : "),
                                                    TextButton(
                                                        onPressed: () async {
                                                          controller.selectedDate = await showDatePicker(
                                                              context: context,
                                                              initialDate: DateTime.now(),
                                                              firstDate: DateTime(2022, 1),
                                                              lastDate: DateTime(2025, 12));

                                                          if (controller.selectedDate != null &&
                                                              controller.selectedDate != DateTime.now()) {
                                                            controller.showPolylineForDate(controller.selectedDate!);
                                                          }
                                                        },
                                                        child: Text(
                                                          DateClass().showDate(controller.selectedDate!.toString()),
                                                          style: TextStyle(fontSize: 13.sp),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )

                                      //full details user
                                      : FadeIn(
                                          child: Column(
                                            children: [
                                              Obx(() => AnimatedContainer(
                                                    duration: Duration(milliseconds: 400),
                                                    height: controller.viewActivity == true ? 70.h : 38.h,
                                                    padding: EdgeInsets.all(5.w),
                                                    margin: EdgeInsets.all(4.w),
                                                    decoration: BoxDecoration(
                                                      color: kColorwhite,
                                                      boxShadow: kElevationToShadow[2],
                                                      borderRadius: BorderRadius.circular(4.w),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                                width: 20.w,
                                                                height: 9.h,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  image: DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: NetworkImage(
                                                                          'https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
                                                                )),
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 1.5.h),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    controller.selectedMarkerData.value?.userName ?? "",
                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                                  ),
                                                                  SizedBox(
                                                                    height: .5.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.mail,
                                                                        color: Colors.blue,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 1.w,
                                                                      ),
                                                                      Text(
                                                                        textAlign: TextAlign.left,
                                                                        "John@email.com",
                                                                        style: TextStyle(fontSize: 10.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color: Colors.green,
                                                            ),
                                                            Text(
                                                              textAlign: TextAlign.left,
                                                              "Available",
                                                              style: TextStyle(
                                                                  fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 2.h, left: 2.w, bottom: .5.h),
                                                          child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "Location",
                                                                    style: TextStyle(fontSize: 10.sp, color: kColorgrey),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Text(
                                                                    "|  Oct 10, 2024 at 11:31 am",
                                                                    style: TextStyle(
                                                                      fontSize: 10.sp,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        controller.selectedMarkerPosition.value != null
                                                            ? Container(
                                                                padding: EdgeInsets.all(1.w),
                                                                margin: EdgeInsets.only(bottom: 1.h),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(color: kColorgreyShade300),
                                                                    borderRadius: BorderRadius.circular(4.w)),
                                                                child: ListTile(
                                                                  minLeadingWidth: 0,
                                                                  leading: Icon(Icons.location_on_rounded),
                                                                  title: Text(
                                                                    placeName,
                                                                    style: TextStyle(fontSize: 10.sp),
                                                                  ),
                                                                  trailing: Wrap(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius: 5.w,
                                                                        backgroundColor: kColorlightBlue,
                                                                        child: CircleAvatar(
                                                                            backgroundColor: kColorwhite,
                                                                            child: IconButton(
                                                                                onPressed: () {
                                                                                  ShareHelper.share(placeName, "text");
                                                                                },
                                                                                icon: Icon(Icons.share))),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 2.w,
                                                                      ),
                                                                      CircleAvatar(
                                                                        child: IconButton(
                                                                          onPressed: () async {
                                                                            final String url =
                                                                                'https://www.google.com/maps/?q=${controller.selectedMarkerData.value!.latitude},${controller.selectedMarkerData.value!.longitude}';

                                                                            if (await canLaunchUrl(Uri.parse(url))) {
                                                                              await launchUrl(Uri.parse(url));
                                                                            } else {
                                                                              throw 'Could not launch ';
                                                                            }
                                                                          },
                                                                          icon: Icon(Icons.directions),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () async {
                                                                controller.selectedDate = await showDatePicker(
                                                                    context: context,
                                                                    initialDate: DateTime.now(),
                                                                    firstDate: DateTime(2022, 1),
                                                                    lastDate: DateTime(2025, 12));

                                                                if (controller.selectedDate != null &&
                                                                    controller.selectedDate != DateTime.now()) {
                                                                  setState(() {
                                                                    controller.showPolylineForDate(controller.selectedDate!);
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                "Track History",
                                                                style: TextStyle(fontSize: 12.sp),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () async {
                                                                if (controller.viewActivity.value) {
                                                                  controller.viewActivity.value = false;
                                                                } else {
                                                                  controller.viewActivity.value = true;
                                                                }
                                                              },
                                                              child: Text(
                                                                "Activity",
                                                                style: TextStyle(fontSize: 12.sp),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        controller.viewActivity.value
                                                            ? Expanded(
                                                                child: Container(
                                                                  child: SingleChildScrollView(
                                                                    physics: BouncingScrollPhysics(),
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        for (int i = 0; i < controller.timelineItems.length; i++)
                                                                          TimelineTile(
                                                                            alignment: TimelineAlign.start,
                                                                            isFirst: i == 0,
                                                                            isLast: i == controller.timelineItems.length - 1,
                                                                            endChild: Container(
                                                                              padding: EdgeInsets.symmetric(
                                                                                vertical: 2.h,
                                                                                horizontal: 5.w,
                                                                              ),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  // Display the action and time
                                                                                  InkWell(
                                                                                    onTap: () => customDeleteAlertDialogue(
                                                                                      context,
                                                                                      () {
                                                                                        // controller.deleteTimelineItem(i);
                                                                                      },
                                                                                    ),
                                                                                    child: Text(
                                                                                      controller.timelineItems[i]['action'],
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 5.w,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(height: 5),
                                                                                  Text(
                                                                                    "At ${DateFormat('h:mm a | dd-MM-yyyy').format(controller.timelineItems[i]['time'])}",
                                                                                    style: TextStyle(fontSize: 3.5.w),
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  // Clickable location text
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      // Here, you can open a map or show location details
                                                                                      // Get.snackbar(
                                                                                      //   "Location",
                                                                                      //   "Location: ${controller.timelineItems[i]['location']}",
                                                                                      //   snackPosition: SnackPosition.BOTTOM,
                                                                                      // );

                                                                                      // controller.openGoogleMaps(controller.timelineItems[i]['latitude'],
                                                                                      //     controller.timelineItems[i]['longitude']);
                                                                                    },
                                                                                    child: Text(
                                                                                      "View Location",
                                                                                      style: TextStyle(
                                                                                        shadows:const [
                                                                                          Shadow(
                                                                                            color: Colors.blue,
                                                                                            offset: Offset(0, -5),
                                                                                          )
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
                                                                              color: controller.timelineItems[i]['color'] ?? Colors.white,
                                                                              padding: EdgeInsets.all(8),
                                                                              iconStyle: IconStyle(
                                                                                  color: Colors.white,
                                                                                  iconData: controller.timelineItems[i]['icon'] ??
                                                                                      Icons.ac_unit_rounded),
                                                                            ),
                                                                          )
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  // child: Timeline.tileBuilder(
                                                                  //     builder: TimelineTileBuilder.fromStyle(
                                                                  //   contentsAlign: ContentsAlign.alternating,
                                                                  //   itemCount: 3,
                                                                  //   indicatorStyle: IndicatorStyle.outlined,
                                                                  //   connectorStyle: ConnectorStyle.solidLine,
                                                                  //   contentsBuilder: (context, index) => Padding(
                                                                  //     padding: const EdgeInsets.all(24.0),
                                                                  //     child: Text('Logged In $index'),
                                                                  //   ),
                                                                  // )),
                                                                ),
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )),
                            )
                          : SizedBox();
                    },
                  ),
                ],
              );
      }),
    );
  }

  Future<Uint8List> createMarkerFromText(String text) async {
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final double size = 100.0;

    final Paint paint = Paint()..color = Colors.blueAccent;
    final Radius radius = Radius.circular(size / 2);

    final Rect rect = Rect.fromLTWH(0, 0, size, size);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
    );

    final img = await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}

// class customBottomWidget extends StatefulWidget {
//   customBottomWidget({
//     super.key,
//     required this.controller,
//     required this.placeName,
//   });

//   final GeoLocationController controller;
//   final String placeName;

//   @override
//   State<customBottomWidget> createState() => _customBottomWidgetState();
// }

// class _customBottomWidgetState extends State<customBottomWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class customHeaderWidget extends StatelessWidget {
  const customHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: SizedBox(
          // height: 30,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(color: kColorwhite, borderRadius: BorderRadius.circular(4.w), boxShadow: kElevationToShadow[2]),
                  padding: EdgeInsets.all(2.w),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 5.w,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Exit Map",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 11.w,
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: kElevationToShadow[2]),
                child: IconButton(
                    iconSize: 5.w,
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      color: kColorblack,
                    )),
              )
            ],
          ),
        ));
  }
}

class customZoomWidget extends StatelessWidget {
  const customZoomWidget({
    super.key,
    required this.controller,
  });

  final GeoLocationController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 110,
        right: 20,
        child: SizedBox(
          // height: 30,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  boxShadow: kElevationToShadow[2],
                  color: kColorwhite,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            controller.zoomIn();
                          },
                          child: Icon(Icons.add)),
                    ),
                    // Divider(),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            controller.zoomOut();
                          },
                          child: Icon(Icons.remove)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class customCurrentLocationWidget extends StatelessWidget {
  const customCurrentLocationWidget({
    super.key,
    required this.controller,
  });

  final GeoLocationController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        right: 0,
        child: FadeIn(
          child: Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: SizedBox(
              // height: 30,
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 13.w,
                    decoration: BoxDecoration(color: Colors.lightBlue, shape: BoxShape.circle, boxShadow: kElevationToShadow[2]),
                    child: IconButton(
                        iconSize: 6.w,
                        onPressed: () {
                          if (controller.userLocations.length == 1) {
                            final location = controller.userLocations[0];
                            controller.mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                LatLng(location.latitude, location.longitude),
                                14.0, // Use a predefined zoom level
                              ),
                            );
                          } else {
                            LatLngBounds bounds = controller.calculateBounds();
                            controller.mapController.animateCamera(
                              CameraUpdate.newLatLngBounds(bounds, 110), // 50 is padding around the bounds
                            );
                          }
                        },
                        icon: Icon(
                          Icons.my_location_rounded,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

// class CustomPolyLineWidget extends StatelessWidget {
//   final GeoLocationController controller;
//   const CustomPolyLineWidget({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
