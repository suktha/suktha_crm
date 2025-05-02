// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suktha_crm/Model/live_location_model.dart';
import 'package:suktha_crm/Model/user_model.dart';
import 'package:suktha_crm/Model/user_role_model.dart';
import 'package:suktha_crm/utils/Services/rest_api_services.dart';
import 'package:suktha_crm/utils/api/common_api.dart';
import 'package:url_launcher/url_launcher.dart';

class FieldWorkController extends GetxController {
  void onInit() {
    getUserRoleList("");
    super.onInit();
  }

  var timelineItems = <Map<String, dynamic>>[].obs;

  RxList<UserRoleModel> userRoleList = <UserRoleModel>[].obs;

  RxBool isUserLoggedIn = false.obs;
  RxBool isPageLoading = false.obs;
  RxBool isAdminConnected = false.obs;

  var selectedTitle = "Today".obs;
  var selectedDate = DateTime.now().obs;

  RxList<UserModel> userList = <UserModel>[].obs;
  var filteredUserList = <UserModel>[].obs;

  RxList<UserModel> liveUserList = <UserModel>[].obs;

  getUserList() async {
    print("getUserList called");
    isPageLoading.value = true;
    List<dynamic> responseValue = await apiCallService(
        "/users", 'GET', {}, TheResponseType.list, {}, false);

    List<UserModel> activeUsers = (responseValue)
        .map((e) => UserModel.fromJson(e))
        .where((user) => user.active == 1)
        .toList();
    activeUsers
        .sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

    userList.clear();

    userList.value = activeUsers;
    userList.refresh();

    filteredUserList.clear();
    filteredUserList.value = activeUsers;
    filteredUserList.refresh();

    isPageLoading.value = false;

    return userList;
  }

  Future<Map<String, dynamic>> GetLeadEventByUser({required int userId, required String eventDate}) async {
    if (userId == 0) {
      return {};
    }
    String apiUrl = "/getLeadEventByUser";

    var mapValue = {
      "userId": userId,
      "eventDateTime": eventDate,
      "transId": null,
      "eventName": "Started",
    };

    try {
      Map<String, dynamic> result = await apiCallService(apiUrl, "GET", mapValue, TheResponseType.map, {}, false);

      print(result);

      await loadEvents(result);

      return result;
    } catch (e) {
      print("Error in GetLeadEventByUser(): $e");
      return {};
    }
  }

  // Future<Map<String, dynamic>> GetLeadEventByUser(
  //     {required int userId, required String eventDate}) async {

  //   if (userId == 0) return {};
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String? token = sharedPreferences.getString('token');
  //   print("token ---- $token");
  //   String apiUrl = "/getLeadEventByUser";
  //   print("url--${"$baseUrl$apiUrl"}");

  //   Map<String, dynamic> queryParams = {
  //     "userId": userId,
  //     "eventDateTime": eventDate,
  //     "transId": null,
  //     "eventName": "Started",
  //   };

  //   try {
  //     final dio = Dio();
  //     final response = await dio.get(
  //       "$baseUrl$apiUrl",
  //       queryParameters: queryParams,
  //       options: Options(headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token"
  //       }),
  //     );

  //     log(response.statusCode.toString());

  //     if (response.statusCode == 200 && response.data) {
  //       Map<String, dynamic> result = response.data;
  //       log(result.toString());
  //       await loadEvents(result);
  //       return result;
  //     } else {
  //       log("Unexpected response type or status: ${response.statusCode}");
  //       return {};
  //     }
  //   } catch (e) {
  //     log("Error in GetLeadEventByUser(): $e");
  //     return {};
  //   }
  // }

  loadEvents(Map<String, dynamic> apiResponse) async {
    timelineItems.clear();

    Map<String, List<LiveLocationModel>> eventsByGroup = {};

    apiResponse.forEach((key, events) {
      List<LiveLocationModel> liveLocations = (events as List).map((eventJson) {
        return LiveLocationModel.fromJson(eventJson);
      }).toList();
      eventsByGroup[key] = liveLocations;
    });

    final sortedKeys = eventsByGroup.keys.map(int.parse).toList()..sort();

    for (var key in sortedKeys) {
      final events = eventsByGroup[key.toString()] ?? [];

      if (events.isNotEmpty) {
        String transId = events.first.transId ?? '';

        // 🆕 Fetch Lead details only if not already fetched
        if (transId.isNotEmpty && !leadNames.containsKey(transId)) {
          await getLeadDetails(transId: transId);
        }

        // 🆕 Save header with transId
        timelineItems.add({
          "isHeader": true,
          "title": "Status Tracker",
          "transId": transId, // Save transId with header
        });

        for (var event in events) {
          timelineItems.add({
            "action":
                event.eventDisplayName ?? event.eventName ?? "Unknown Event",
            "time": event.eventDateTime ?? DateTime.now(),
            "latitude": event.latitude,
            "longitude": event.longitude,
            "icon": getIconForEvent(event.eventName),
            "color": getColorForEvent(event.eventName),
          });
        }
      }
    }
  }

  IconData getIconForEvent(String? eventName) {
    switch (eventName) {
      case 'Started':
        return Icons.task_alt;
      case 'Logged out':
        return Icons.logout;
      case 'Task completed':
        return Icons.check_circle;
      case 'Meeting Cancelled':
        return Icons.cancel;
      case 'Reached Destination':
        return Icons.location_on;
      case 'Travel Starts':
        return Icons.directions_car;
      case 'Travel Ends':
        return Icons.flag;
      case 'Meeting Started':
        return Icons.meeting_room;
      case 'Meeting Ends':
        return Icons.meeting_room;
      default:
        return Icons.help_outline;
    }
  }

  Color getColorForEvent(String? eventName) {
    switch (eventName) {
      case 'Started':
        return Colors.green;
      case 'Logged out':
        return Colors.red;
      case 'Task completed':
        return Colors.green;
      case 'Meeting Cancelled':
        return Colors.red;
      case 'Reached Destination':
        return Colors.blue;
      case 'Travel Starts':
        return Colors.orange;
      case 'Travel Ends':
        return Colors.teal;
      case 'Meeting Started':
        return Colors.green;
      case 'Meeting Ends':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  var leadNames = <String, String>{}.obs;
// key = transId, value = lead name (from API)

  getLeadDetails({required String transId}) async {
    var responseValue = await apiCallService(
        "/lead-gen/$transId", 'GET', {}, TheResponseType.map, {}, false);

    if (responseValue != null && responseValue is Map<String, dynamic>) {
      String leadName = responseValue['leadName'] ?? "Unknown Lead";
      leadNames[transId] = leadName;
    }
  }

  void deleteTimelineItem(int index) {
    if (index == 0) {
      isUserLoggedIn.value = false;
    }
    timelineItems.removeAt(index);
    Get.back();
  }

  openGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("error");
      throw 'Could not launch $url';
    }
  }

  Future<List<UserRoleModel>> getUserRoleList(String query) async {
    List<dynamic> responseValue = await apiCallService(
        "/user-roles",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<UserRoleModel> userDatas =
        (responseValue).map((e) => UserRoleModel.fromJson(e)).toList();

    userRoleList.value = userDatas;
    userRoleList.refresh();

    return userRoleList;
  }

  String getUserRoleNames(List<dynamic> userRoleIds) {
    if (userRoleIds == "" || userRoleIds == "0") {
      return "";
    }

    return userRoleList
        .where((model) => userRoleIds.contains(model.id))
        .map((e) => e.role)
        .join(', ');
  }
}
