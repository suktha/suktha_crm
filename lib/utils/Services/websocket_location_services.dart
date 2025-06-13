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
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/view/screens/home_screen/settings_module/tracking/admin/controller/filed_work_controller.dart';
import 'package:work_Force/view/screens/home_screen/settings_module/tracking/admin/controller/location_controller.dart';

class WebSocketService extends GetxService {
  StompClient? stompClient;

  Timer? locationTimer;

  bool isUserConnected = false;
  final homeController = Get.find<HomeController>();
  final fieldworkController = Get.put(FieldWorkController());
  bool isWebSocketConnected = false;
  
  Future<void> initializeConnection(
      {required int? userId, required String? leadId}) async {
    var prefs = SharedPreferencesService.instance;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("❌ Location permission denied.");
        return;
      }
    }

    final logindecoded = json.decode(prefs.getValue('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    final token = loginDetails.token;

    print('📛 Token: $token');

    // Get the dynamic topic URL
    final response = await apiCallService("/getUrlForLocationTracking", "GET",
        {}, TheResponseType.map, {}, false);
    final urlPart = response.toString();
    String subscribeUrl = "$urlPart/$userId";

    String stompUrl = "$baseUrl/ws";
    print("stompUrl : " + stompUrl);

     print("isLoginIdIsAdmin 1 : " +
              homeController.isLoginIdIsAdmin.value.toString());

    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: stompUrl,
        stompConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        onConnect: (StompFrame frame) async {
          isWebSocketConnected = true;
          print("✅ Connected: $frame");

          print("isLoginIdIsAdmin : " +
              homeController.isLoginIdIsAdmin.value.toString());

          if (homeController.isLoginIdIsAdmin.value) {
            fieldworkController.isAdminConnected.value = true;
            print(" topics : " + subscribeUrl);
            connectAdmin(subscribeUrl);
          } else {
            print("else case topics : " + urlPart);
            await connectUser(
                urlPart: urlPart, loginDetails: loginDetails, leadId: leadId!);
          }
        },
        onWebSocketError: (error) => print('🔁 WebSocket Error: $error'),
        onStompError: (frame) {
          print('❌ STOMP Error commad: ${frame.command}');
          print('❌ STOMP Error body: ${frame.body}');
          print('❌ STOMP Error headers: ${frame.headers}');
        },
        onDisconnect: (frame) => print('🔁 WebSocket Disconnected'),
        onWebSocketDone: () => print('🔁 WebSocket Closed.'),
        heartbeatOutgoing: Duration(seconds: 10),
        heartbeatIncoming: Duration(seconds: 10),
        reconnectDelay: Duration(milliseconds: 0),
      ),
    );

    stompClient?.activate();
  }

  void disconnect() {
    try {
      if (stompClient != null && stompClient!.isActive) {
        stompClient!.deactivate();

        print("🛑 WebSocket disconnected successfully.");
      } else {
        print("⚠️ WebSocket is already inactive or not initialized.");
      }
      locationTimer?.cancel();
      locationTimer = null;

      isUserConnected = false;
      fieldworkController.isAdminConnected.value = false;
    } catch (e) {
      print("❌ Error during disconnection: $e");
    }
  }

  void connectAdmin(String subscribeUrl) {
    try {
      stompClient!.subscribe(
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

    locationTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

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

        print('isconnected : ${stompClient!.connected}');
        print('isactive : ${stompClient!.isActive}');

        if (stompClient!.connected && stompClient!.isActive) {
          stompClient!
              .send(destination: '/app/sendLocation', body: body, headers: {});
          print("📩 Location sent successfully.");
        } else {
          print("⚠️ STOMP client is not connected/active.");
        }
      } catch (e) {
        print("❌ Error fetching or sending location: $e");
      }
    });
  }
}
