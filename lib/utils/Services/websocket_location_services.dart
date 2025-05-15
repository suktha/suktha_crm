// ignore_for_file: avoid_print, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:work_Force/Model/live_location_model.dart';
import 'package:work_Force/Model/login_model.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/Services/sharedpref_services.dart';
import 'package:work_Force/view/settings_module/tracking/admin/controller/filed_work_controller.dart';
import 'package:work_Force/view/settings_module/tracking/admin/controller/location_controller.dart';

class WebSocketService extends GetxService {
  StompClient? _stompClient;
  bool isUserConnected = false;
  final homeController = Get.find<HomeController>();
  final fieldworkController = Get.put(FieldWorkController());

  Future<void> initializeConnection({required int? userId, required String? leadId}) async {
    var prefs = SharedPreferencesService.instance;

    final logindecoded = json.decode(prefs.getValue('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    final token = loginDetails.token;

    print('📛 Token: $token');

    // Get the dynamic topic URL
    final response = await apiCallService("/getUrlForLocationTracking", "GET", {}, TheResponseType.map, {}, false);
    final urlPart = response.toString();
    String subscribeUrl = "$urlPart/${userId}";

    String stompUrl = "https://api.test.brainibooks.com/core-erp/ws";

    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: stompUrl,
        stompConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        onConnect: (StompFrame frame) async {
          print("✅ Connected: $frame");

          print("isLoginIdIsAdmin : " + homeController.isLoginIdIsAdmin.value.toString());
          if (homeController.isLoginIdIsAdmin.value) {
            fieldworkController.isAdminConnected.value = true;
            print(" topics : " + subscribeUrl);
            connectAdmin(subscribeUrl);
          } else {
            await connectUser(urlPart: urlPart, loginDetails: loginDetails, leadId: leadId!);
          }
        },
        onWebSocketError: (error) => print('❌ WebSocket Error: $error'),
        onStompError: (frame) {
          print('❌ STOMP Error commad: ${frame.command}');
          print('❌ STOMP Error body: ${frame.body}');
          print('❌ STOMP Error headers: ${frame.headers}');
        },
        onDisconnect: (frame) => print('🔌 Disconnected'),
        onWebSocketDone: () => print('🔁 WebSocket Closed.'),
        heartbeatOutgoing: Duration(seconds: 10),
        heartbeatIncoming: Duration(seconds: 10),
        reconnectDelay: Duration(milliseconds: 0),
      ),
    );

    _stompClient?.activate();
  }

  void connectAdmin(String subscribeUrl) {
    try {
      _stompClient!.subscribe(
        destination: subscribeUrl,
        callback: (StompFrame frame) {
          print("📩 Received: ${frame.body}");

          if (frame.body != null) {
            final data = jsonDecode(frame.body!);
            final location = LiveLocationModel.fromJson(data);
            print("Location data: ${location.toJson()}");
            Get.find<GeoLocationController>().addOrUpdateLocation(location);
          }
        },
      );
      print("✅ Subscribed successfully.");
    } catch (e) {
      print("❌ Subscription failed: $e");
    }
  }

  connectUser({
    required String urlPart,
    required String leadId,
    required LoginModel loginDetails,
  }) async {
    isUserConnected = true;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        print("❌ Location permission denied.");
        return;
      }
    }
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1, // only send if moved 10 meters
      ),
    ).listen((Position position) {
      // Send new location via WebSocket

      var mapValue = LiveLocationModel(
        id: null,
        eventDateTime: null,
        longitude: position.longitude,
        latitude: position.latitude,
        userId: loginDetails.user!.id!,
        userName: loginDetails.user!.name!,
        eventName: null,
        reasonId: null,
        message: null,
        transId: leadId,
        destinationUrl: urlPart,
      );

      final body = jsonEncode(mapValue.toJson());

      print('isconnected : ${_stompClient!.connected}');
      print('isactive : ${_stompClient!.isActive}');

      try {
        _stompClient!.send(destination: '/app/sendLocation', body: body, headers: {});

        print("📩 Location sent successfully.");
      } catch (e) {
        print("❌ Error sending location: $e");
      }
    });
  }
}
