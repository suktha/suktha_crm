import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_Force/Model/lead_model.dart';
import 'package:work_Force/Model/live_location_model.dart';
import 'package:work_Force/Model/login_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/view/settings_module/tracking/admin/controller/filed_work_controller.dart';

class UserManagementController extends GetxController {
  TextEditingController messageController = TextEditingController();

  final fieldWorkController = Get.find<FieldWorkController>();

  var timelineItems = <Map<String, dynamic>>[].obs;

  final Location locationService = Location();

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  var currentLocation = Rxn<LocationData>();

  Rxn<Map<String, String>> activeLeadData = Rxn<Map<String, String>>();

  bool get isFieldWorkActive => activeLeadData.value != null;

  bool isFieldWorkForThisLead(String leadId) => activeLeadData.value?['leadId'] == leadId;

  void startFieldWork({required String leadId, required String leadName, required String leadNumber}) async {
    activeLeadData.value = {
      'leadId': leadId,
      'leadName': leadName,
      'leadNumber': leadNumber,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the values to SharedPreferences
    await prefs.setString('liveLocLeadId', leadId);
    await prefs.setString('liveLocLeadName', leadName);
    await prefs.setString('liveLocLeadNumber', leadNumber);
  }

  void stopFieldWork() async {
    // Clear active lead data in memory
    activeLeadData.value = null;

    // Get SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the saved lead data from SharedPreferences
    await prefs.remove('liveLocLeadId');
    await prefs.remove('liveLocLeadName');
    await prefs.remove('liveLocLeadNumber');
  }

  Future<bool> checkLeadIsActive() async {
    print("🟢 started checking.....");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? leadId = prefs.getString('liveLocLeadId');
    String? leadName = prefs.getString('liveLocLeadName');
    String? leadNumber = prefs.getString('liveLocLeadNumber');

    final logindecoded = json.decode(prefs.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    print("userId: ${loginDetails.user!.id}");

    print("leadId: $leadId, leadName: $leadName, leadNumber: $leadNumber");
    if (leadId != null && leadName != null && leadNumber != null) {
      var value = await fieldWorkController.GetLeadEventByUser(
        userId: loginDetails.user!.id!,
        eventDate: DateTime.now().toString(),
        transId: leadId,
      );
      print("getleadevent " + value.toString());

      if (value != null && value.isNotEmpty) {
        // await Get.find<WebSocketService>().initializeConnection(leadId: leadId, userId: loginDetails.user!.id!);

        activeLeadData.value = {'leadId': leadId, 'leadName': leadName, 'leadNumber': leadNumber};
        final dataList = value['1'] as List;

        timelineItems.assignAll(
          dataList.map((eventJson) {
            final model = LiveLocationModel.fromJson(eventJson as Map<String, dynamic>);

            return {
              "action": model.eventDisplayName ?? model.eventName ?? "Unknown",
              "time": model.eventDateTime ?? DateTime.now(),
              "latitude": model.latitude,
              "longitude": model.longitude,
              "icon": getIconForEvent(model.eventName),
              "color": getColorForEvent(model.eventName),
            };
          }).toList(),
        );
        return true;
      } else {
        activeLeadData.value = null;
        return false;
      }
    } else
      return false;
  }

  IconData getIconForEvent(String? eventName) {
    switch (eventName) {
      case "Started":
        return Icons.task_alt;
      case "Ended":
        return Icons.logout;
      case "Task completed":
        return Icons.check_circle;
      case "Meeting Cancelled":
        return Icons.cancel;
      case "Reached Destination":
        return Icons.location_on;
      case "Travel Starts":
        return Icons.directions_car;
      case "Travel Ends":
        return Icons.flag;
      case "Meeting Started":
        return Icons.meeting_room;
      case "Meeting Ends":
        return Icons.meeting_room;
      default:
        return Icons.help_outline; // Default icon for unhandled cases
    }
  }

  Color getColorForEvent(String? eventName) {
    switch (eventName) {
      case "Started":
        return Colors.green;
      case "Ended":
        return Colors.red;
      case "Task completed":
        return Colors.green;
      case "Meeting Cancelled":
        return Colors.red;
      case "Reached Destination":
        return Colors.blue;
      case "Travel Starts":
        return Colors.orange;
      case "Travel Ends":
        return Colors.teal;
      case "Meeting Started":
        return Colors.green;
      case "Meeting Ends":
        return Colors.grey;
      default:
        return Colors.blueGrey; // Default color for unhandled cases
    }
  }

  String get activeLeadName => activeLeadData.value?['leadName'] ?? '';
  String get activeLeadNumber => activeLeadData.value?['leadNumber'] ?? '';

  RxBool isUserLoggedIn = false.obs;
  RxBool isLoading = false.obs;

  void addTimelineItem({
    required String action,
    required LeadModel leadValue,
  }) async {
    IconData icon;
    Color color;

    await getCurrentLocation();

    if (action == "Started") {
      isUserLoggedIn.value = true;
      timelineItems.clear();
    }

    switch (action) {
      case "Started":
        icon = Icons.task_alt;
        color = Colors.green;
        break;
      case "Ended":
        icon = Icons.logout;
        color = Colors.red;
        break;
      case "Task completed":
        icon = Icons.check_circle;
        color = Colors.green;
        break;

      case "Meeting Cancelled":
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case "Reached Destination":
        icon = Icons.location_on;
        color = Colors.blue;
        break;
      case "Travel Starts":
        icon = Icons.directions_car;
        color = Colors.orange;
        break;
      case "Travel Ends":
        icon = Icons.flag;
        color = Colors.teal;
        break;
      case "Meeting Started":
        icon = Icons.meeting_room;
        color = Colors.green;
        break;
      case "Meeting Ends":
        icon = Icons.meeting_room;
        color = Colors.grey;
        break;
      default:
        icon = Icons.help_outline; // Default icon for unhandled cases
        color = Colors.blueGrey;
        break;
    }

    timelineItems.add({
      "action": action,
      "time": DateTime.now(),
      "latitude": currentLocation.value!.latitude,
      "longitude": currentLocation.value!.longitude,
      "icon": icon,
      "color": color,
    });

    updateEvent(
      action: action,
      latitude: currentLocation.value!.latitude!,
      longitude: currentLocation.value!.longitude!,
      leadId: leadValue.id!,
    );
  }

  Future<void> updateEvent({
    required String action,
    required double latitude,
    required double longitude,
    required String leadId,
    String? reasonId,
  }) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);
    print("userId: ${loginDetails.user!.id}");

    String apiUrl = "/updateLocation";
    print("Calling API: $apiUrl");

    String? evntDisplayName;

    if (action == "Started") {
      evntDisplayName = "Started";
    } else if (action == "Travel Starts") {
      evntDisplayName = "Started Travel";
    } else if (action == "Travel Ends") {
      evntDisplayName = "Ended Travel";
    } else if (action == "Meeting Started") {
      evntDisplayName = "Started Meeting";
    } else if (action == "Meeting Ends") {
      evntDisplayName = "Ended Meeting";
    } else if (action == "Task completed") {
      evntDisplayName = "Task Completed";
    } else if (action == "Ended") {
      evntDisplayName = "Ended";
    } else if (action == "Meeting Cancelled") {
      evntDisplayName = "Meeting Cancelled";
    } else if (action == "Reached Destination") {
      evntDisplayName = "Reached Destination";
    }

    var mapValue = LiveLocationModel(
      id: null,
      eventDateTime: DateTime.now(),
      longitude: longitude,
      latitude: latitude,
      // latitude: 12.8806049, longitude: 77.5442035,
      userId: loginDetails.user!.id,
      userName: "",
      eventName: action,
      reasonId: null,
      message: "message",
      transId: leadId,
      eventDisplayName: evntDisplayName,
      destinationUrl: "",
    );

    dynamic result = await apiCallService(apiUrl, "POST", mapValue.toJson(), TheResponseType.map, {}, false);

    print("Update success: $result");
  }

  logIn(String location) async {
    isUserLoggedIn.value = true;

    await getCurrentLocation();
    timelineItems.clear();
    timelineItems.add({
      "action": "Logged in",
      "time": DateTime.now(),
      "latitude": currentLocation.value!.latitude,
      "longitude": currentLocation.value!.longitude,
      "icon": Icons.task_alt,
      "color": Colors.green,
    });
    print("In the login funcition -- " + isLoading.value.toString());
  }

  logOut(String location) {
    isUserLoggedIn.value = false;
    timelineItems.add({
      "action": "Logged Out",
      "time": DateTime.now(),
      "latitude": currentLocation.value!.latitude,
      "longitude": currentLocation.value!.longitude,
      "icon": Icons.logout,
      "color": Colors.red,
    });
  }

  void deleteTimelineItem(int index) {
    if (index == 0) {
      isUserLoggedIn.value = false;
    }
    timelineItems.removeAt(index);
    Get.back();
  }

  getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        print('Location services are disabled.');
        return;
      }
    }

    // Check for location permission
    _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location permission denied.');
        return;
      }
    }

    // Get the current location
    final location = await locationService.getLocation();

    currentLocation.value = location;

    print('Current location: ${location.latitude}, ${location.longitude}');
    isLoading.value = false;
    btnController.success();
  }

  openGoogleMaps(double endLat, double endLng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$endLat,$endLng&travelmode=driving';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("error");
      throw 'Could not launch $url';
    }
  }
}
