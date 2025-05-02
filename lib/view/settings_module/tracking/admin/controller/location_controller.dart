// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:suktha_crm/Model/live_location_model.dart';
import 'package:suktha_crm/Model/login_model.dart';
import 'package:suktha_crm/utils/Services/location_services.dart';
import 'package:suktha_crm/utils/Services/rest_api_services.dart';
import 'package:suktha_crm/view/settings_module/tracking/admin/model/live_location_model.dart';
import 'package:suktha_crm/view/settings_module/tracking/admin/model/location_history.dart';

class GeoLocationController extends GetxController {
  RxBool viewActivity = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getdata();
  }

  final LocationServices locService = LocationServices();
  var timelineItems = <Map<String, dynamic>>[].obs;

  getdata() async {
    print("--location printed--");

    timelineItems.add({
      "action": "Logged in",
      "time": DateTime.now(),
      // "latitude": currentLocation.value!.latitude,
      // "longitude": currentLocation.value!.longitude,
      "icon": Icons.task_alt,
      "color": Colors.green,
    });

    timelineItems.add({
      "action": "Travel Starts",
      "time": DateTime.now(),
      // "latitude": currentLocation.value!.latitude,
      // "longitude": currentLocation.value!.longitude,
      "icon": Icons.directions_car,
      "color": Colors.orange,
    });

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);

    if (logindecoded != null) {
      final loginDetails = LoginModel.fromJson(logindecoded);

      if (loginDetails.user!.id != 1000) {
        locService.setUserId(loginDetails.user!.id!);
      } else {
        print("not started location");
      }
    }
  }

  late GoogleMapController mapController;

  var currentLocation = Rxn<LocationData>();
  final Location locationService = Location();
  Set<Marker> markerValue = {};

  var polylines = <Polyline>{}.obs;

  var selectedMarkerPosition = Rxn<LatLng>();
  var selectedMarkerData = Rx<LiveLocationModel?>(null);

  RxBool isLocataionEnabled = false.obs;

  void addPolyline(List<LatLng> points) {
    final polyline = Polyline(
      polylineId: PolylineId('polyline_1'),
      color: Colors.blue,
      width: 5,
      points: points,
    );
    polylines.add(polyline);
  }

  void clearPolylines() {
    if (polylines.isNotEmpty) {
      polylines.clear();
    } else {
      print("clear polylines ");
    }
  }

  void zoomIn() {
    mapController.getZoomLevel().then((zoom) {
      mapController.animateCamera(CameraUpdate.zoomIn());
    });
  }

  // Method to zoom out
  void zoomOut() {
    mapController.getZoomLevel().then((zoom) {
      mapController.animateCamera(CameraUpdate.zoomOut());
    });
  }

  LatLngBounds calculateBounds() {
    double north = userLocations[0].latitude;
    double south = userLocations[0].latitude;
    double east = userLocations[0].longitude;
    double west = userLocations[0].longitude;

    for (var location in userLocations) {
      if (location.latitude > north) north = location.latitude;
      if (location.latitude < south) south = location.latitude;
      if (location.longitude > east) east = location.longitude;
      if (location.longitude < west) west = location.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  Future<void> initializeLocation() async {
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      // Check if location service is enabled
      _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      // Check location permission
      _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      // Get the current location
      final location = await locationService.getLocation();

      currentLocation.value = location;

      // _loadClientMarkers(); // Load client markers after getting the location
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    isLocataionEnabled.value = true;

    // ignore: unnecessary_null_comparison
    if (userLocations.length == 1) {
      final location = userLocations[0];
      mapController.moveCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(location.latitude, location.longitude),
          14.0, // Use a predefined zoom level
        ),
      );
    } else {
      LatLngBounds bounds = calculateBounds();
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 110),
      );
    }
  }

  RxList<LiveLocationModel> userLocations = <LiveLocationModel>[].obs;

  LatLng calculateCentroid() {
    if (userLocations.isEmpty) return LatLng(0, 0);

    double sumLatitude = 0;
    double sumLongitude = 0;

    for (var location in userLocations) {
      sumLatitude += location.latitude;
      sumLongitude += location.longitude;
    }

    double averageLatitude = sumLatitude / userLocations.length;
    double averageLongitude = sumLongitude / userLocations.length;

    return LatLng(averageLatitude, averageLongitude);
  }

  void addOrUpdateLocation(LiveLocationModel newLocation) {
    // Check if already exists by userId or transId
    int index = userLocations.indexWhere((item) => item.userId == newLocation.userId);

    if (index != -1) {
      // Update the existing entry
      userLocations[index] = newLocation;
    } else {
      // Add new entry
      userLocations.add(newLocation);
    }

    print(' 🚀 location added or updated: ${newLocation.toJson()}');
  }

  Future<Uint8List> getBytesFromNetworkImage(
      {required String url, required int size, required Color borderColor, required double borderWidth}) async {
    final http.Response response = await http.get(Uri.parse(url));
    final ui.Codec codec = await ui.instantiateImageCodec(
      response.bodyBytes,
      targetWidth: size,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();

    final ui.Image image = frameInfo.image;
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..isAntiAlias = true;

    final double radius = size / 2;
    final double borderRadius = radius + borderWidth;

    // Draw the circular border
    paint.color = borderColor;
    canvas.drawCircle(
      Offset(borderRadius, borderRadius),
      borderRadius,
      paint,
    );

    // Draw the circular image
    final Path clipPath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(borderRadius, borderRadius),
        radius: radius,
      ));
    canvas.clipPath(clipPath);

    paintImage(
      canvas: canvas,
      image: image,
      rect: Rect.fromLTWH(borderWidth, borderWidth, size.toDouble(), size.toDouble()),
      fit: BoxFit.cover,
    );

    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
          (borderRadius * 2).toInt(),
          (borderRadius * 2).toInt(),
        );
    final ByteData? byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<gc.Placemark?> getPlaceDetailsFromCoordinates(double latitude, double longitude) async {
    try {
      List<gc.Placemark> placemarks = await gc.placemarkFromCoordinates(latitude, longitude);
      return placemarks.isNotEmpty ? placemarks.first : null;
    } catch (e) {
      print("Error during reverse geocoding: $e");
      return null;
    }
  }

  final List<Map<String, dynamic>> locationHistory = [
    {
      "timestamp": DateTime(2024, 8, 28, 8, 30),
      "latitude": 37.7749,
      "longitude": -122.4194,
    },
    {
      "timestamp": DateTime(2024, 8, 28, 9, 0),
      "latitude": 37.7750,
      "longitude": -122.4180,
    },
    {
      "timestamp": DateTime(2024, 8, 28, 12, 30),
      "latitude": 37.7760,
      "longitude": -122.4170,
    },
    {
      "timestamp": DateTime(2024, 8, 29, 8, 30),
      "latitude": 37.7740,
      "longitude": -122.4190,
    },
    {
      "timestamp": DateTime(2024, 8, 29, 9, 0),
      "latitude": 37.7730,
      "longitude": -122.4200,
    },
    {
      "timestamp": DateTime(2024, 8, 29, 12, 30),
      "latitude": 37.7720,
      "longitude": -122.4210,
    },
  ];
  void showPolylineForDate(DateTime selectedDate) async {
    clearPolylines();
    List<LatLng> points = await getPolylinePointsForDate(selectedDate);
    if (points.isNotEmpty) {
      addPolyline(points);
    }
  }

  List<LatLng> getPolylinePointsForDate(DateTime selectedDate) {
    // Dummy data function, replace with actual data retrieval
    List<LocationHistoryData> dummyLocationHistoryData = [
      LocationHistoryData(DateTime.parse('2024-12-02 12:00:00'), LatLng(12.9716, 77.5946)),
      LocationHistoryData(DateTime.parse('2024-12-02 12:30:00'), LatLng(12.9950, 77.6000)),
      LocationHistoryData(DateTime.parse('2024-12-02 10:00:00'), LatLng(12.9920, 77.6100)),
      LocationHistoryData(DateTime.parse('2024-12-02 10:30:00'), LatLng(12.9900, 77.7200)),
      LocationHistoryData(DateTime.parse('2024-12-01 12:00:00'), LatLng(12.9716, 77.5946)),
      LocationHistoryData(DateTime.parse('2024-12-01 12:30:00'), LatLng(12.9750, 77.5900)),
      LocationHistoryData(DateTime.parse('2024-12-01 10:00:00'), LatLng(12.9800, 77.5850)),
      LocationHistoryData(DateTime.parse('2024-12-01 10:30:00'), LatLng(12.9850, 77.5800)),
    ];

    return dummyLocationHistoryData
        .where((data) =>
            data.timestamp.year == selectedDate.year &&
            data.timestamp.month == selectedDate.month &&
            data.timestamp.day == selectedDate.day)
        .map((data) => data.location)
        .toList();
  }

  DateTime? selectedDate = DateTime.now();

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  getLocation() async {
    var responseValue = await apiCallService(
        "/get-all-user-loc", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

    print(responseValue);
  }

  saveLocation(GeoLocationModel locModel) async {
    Map<String, dynamic>? value = {
      "eventDateTime": locModel.eventDateTime,
      "latitude": locModel.latitude,
      "longitude": locModel.longitude,
      "userId": locModel.userId
    };

    var responseValue = await apiCallService(
        "/save-user-loc", 'POST', value, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

    print(responseValue);
  }
}
