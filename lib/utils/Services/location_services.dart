// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:suktha_crm/utils/Services/permission_services.dart';
import 'package:suktha_crm/view/settings_module/tracking/admin/controller/location_controller.dart';
import 'package:suktha_crm/view/settings_module/tracking/admin/model/live_location_model.dart';

class LocationServices with WidgetsBindingObserver {
  Timer? _timer;
  Position? _currentPosition;
  int? _userId;

  LocationService() {
    print("--location--locationservicetriggered");
    WidgetsBinding.instance.addObserver(this);
    _startLocationFetching();
  }

  void setUserId(int userId) {
    log("--location -- set id$userId");
    _userId = userId;
  }

  final PermissionServices permissionService = Get.find<PermissionServices>();

  void _startLocationFetching() async {
    print("--location--startfetching location -- ");

    bool isGranted = await permissionService.checkLocationPermission();

    if (!isGranted) {
      isGranted = await permissionService.requestLocationPermission();
      if (isGranted) {
        Get.snackbar('Permission Granted', 'You can now access your location');
        if (isGranted) {
          // initBackgroundLocationFetch();
        }
      } else {
        Get.snackbar('Permission Denied', 'Location access is required for this feature');
      }
    } else {
      Get.snackbar('Permission Status', 'Location permission is already granted');
      if (isGranted) {
        // initBackgroundLocationFetch();
      }
    }
  }

  // Method to initiate location fetching for foreground
  void _initForegroundLocationFetch() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      _fetchAndSendLocation();
    });
  }

  // void initBackgroundLocationFetch() {
  //   print("--location--app in background location fetch");
  //   Workmanager().initialize(_fetchAndSendLocation, isInDebugMode: true);
  //   Workmanager().registerPeriodicTask(
  //     "1",
  //     fetchBackgroundTask,
  //     inputData: {"userId": _userId},
  //     frequency: Duration(minutes: 1),
  //   );
  // }

  Future<void> _fetchAndSendLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      _currentPosition = position;

      print("--location-- fetch and send location --" + _currentPosition!.latitude.toString());

      // _sendLocationToController(position);
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  void _sendLocationToController(Position position) {
    GeoLocationModel location = GeoLocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      eventDateTime: null,
      userId: _userId!,
    );

    print("--location--inside send loc to controller -- $location");

    GeoLocationController().saveLocation(location);
  }

  void stopForegroundLocationFetch() {
    _timer?.cancel();
  }

  // void stopBackgroundLocationFetch() {
  //   Workmanager().cancelAll();
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      stopForegroundLocationFetch();
      // initBackgroundLocationFetch();
    } else if (state == AppLifecycleState.resumed) {
      // stopBackgroundLocationFetch();
      _initForegroundLocationFetch();
    }
  }

// Clean up observer
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopForegroundLocationFetch();
    // stopBackgroundLocationFetch();
  }
}
