import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:work_Force/Model/designation_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/view/screens/field_work/start_field_work/start_field_work_screen.dart';
import 'package:work_Force/view/screens/field_work/start_field_work/clockedInTask_screen.dart';

class CheckInOutController extends GetxController {
  var isClockedIn = false.obs;
  var startTime = DateTime.now().obs;
  var workedDuration = Duration.zero.obs;

  final Rx<Duration> elapsedTime = Duration.zero.obs;
  Timer? _timer;

  GoogleMapController? mapController;
  StreamSubscription<Position>? positionStream;

  var currentLocation = Rxn<LatLng>();
  var endLocation = Rxn<LatLng>();

  var markers = <Marker>{}.obs;
  var polylines = <Polyline>{}.obs;
  var polylineCoordinates = <LatLng>[].obs;
  var taskTimeline = <String>[].obs;

  var actionList = [
    "Meeting Started",
    "Meeting Completed",
    "Break",
    "Discussion",
  ];
  var selectedAction = "".obs;
  @override
  void onInit() {
    super.onInit();
    getDesignationList();
    _getCurrentLocation();
    _listenToLocationChanges();
    taskTimeline.add("Task Started");
  }

  @override
  void onClose() {
    _timer?.cancel();
    positionStream?.cancel();
    super.onClose();
  }

   void addTimeline(String event) {
    final time = DateTime.now();
    final formatted =
        "$event at ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    taskTimeline.add(formatted);
  }

  /// Get current user location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    currentLocation.value = LatLng(position.latitude, position.longitude);
    _updateMarkers();
  }

  /// Listen to live updates
  void _listenToLocationChanges() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
    ).listen((Position position) {
      currentLocation.value = LatLng(position.latitude, position.longitude);
      _updateMarkers();

      // Move camera with user
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(currentLocation.value!),
        );
      }
    });
  }

  /// Update markers
  void _updateMarkers() {
    final newMarkers = <Marker>{};

    if (currentLocation.value != null) {
      newMarkers.add(Marker(
        markerId: const MarkerId("current"),
        position: currentLocation.value!,
        infoWindow: const InfoWindow(title: "You (Live)"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }

    if (endLocation.value != null) {
      newMarkers.add(Marker(
        markerId: const MarkerId("end"),
        position: endLocation.value!,
        infoWindow: const InfoWindow(title: "Task End"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }

    markers.value = newMarkers;
  }

  /// Draw dotted polyline from start to end
  Future<void> _getPolyline(LatLng start, LatLng end) async {
    PolylinePoints polylinePoints = PolylinePoints(apiKey: googleApiKey);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(start.latitude, start.longitude),
        destination: PointLatLng(end.latitude, end.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      polylines.value = {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 4,
          patterns: const [PatternItem.dot], // dotted route
        )
      };
    }
  }

  /// When user ends task
  void endTask() {
    if (currentLocation.value == null) return;

    endLocation.value = currentLocation.value;
    _updateMarkers();

    if (endLocation.value != null && currentLocation.value != null) {
      _getPolyline(currentLocation.value!, endLocation.value!);
      designationIdName.value = "";
    }
    taskTimeline.add("Task Ended");
  }

  void toggleCheck() {
    if (isClockedIn.value) {
      // Clocking out
      print("Clocked1 : ${isClockedIn.value}");

      _timer?.cancel();
      workedDuration.value = DateTime.now().difference(startTime.value);
    } else {
      // Clocking in
      startTime.value = DateTime.now();
      elapsedTime.value = Duration.zero;

      Get.to(() => TaskMapScreen(), transition: Transition.rightToLeft);
      print("Clocked2 : ${isClockedIn.value}");
      _timer?.cancel();

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsedTime.value = DateTime.now().difference(startTime.value);
      });
    }
    isClockedIn.toggle();
  }

  RxList<DesignationModel> designationList = <DesignationModel>[].obs;
  RxString designationIdName = "".obs;
  TextEditingController designationController = TextEditingController();

  Future<List<DesignationModel>> getDesignationList() async {
    List<dynamic> responseValue = await apiCallService(
        "/designations",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DesignationModel> designation =
        (responseValue).map((e) => DesignationModel.fromJson(e)).toList();
    designationList.value = designation;
    designationList.refresh();

    return designationList;
  }
}
