import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';

class TaskMapScreen extends StatefulWidget {
  const TaskMapScreen({super.key});

  @override
  State<TaskMapScreen> createState() => _TaskMapScreenState();
}

class _TaskMapScreenState extends State<TaskMapScreen> {
  GoogleMapController? mapController;
  StreamSubscription<Position>? positionStream;

  LatLng? currentLocation;
  LatLng? endLocation;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _listenToLocationChanges();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
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
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      _updateMarkers();
    });
  }

  /// Listen to live updates
  void _listenToLocationChanges() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        _updateMarkers();

        // Move camera with user
        mapController?.animateCamera(
          CameraUpdate.newLatLng(currentLocation!),
        );
      });
    });
  }

  /// Update markers
  void _updateMarkers() {
    markers.clear();

    if (currentLocation != null) {
      markers.add(Marker(
        markerId: const MarkerId("current"),
        position: currentLocation!,
        infoWindow: const InfoWindow(title: "You (Live)"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }

    if (endLocation != null) {
      markers.add(Marker(
        markerId: const MarkerId("end"),
        position: endLocation!,
        infoWindow: const InfoWindow(title: "Task End"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
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

      setState(() {
        polylines.clear();
        polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 4,
          patterns: const [PatternItem.dot], // 🔵 dotted route
        ));
      });
    }
  }

  /// When user ends task, mark end location
  void _endTask() {
    if (currentLocation == null) return;

    setState(() {
      endLocation = currentLocation;
      _updateMarkers();
    });

    if (endLocation != null && currentLocation != null) {
      _getPolyline(currentLocation!, endLocation!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Live"),
        elevation: 1,
        titleTextStyle: TextStyle(
            color: kColorblack, fontWeight: FontWeight.bold, fontSize: 18),
        backgroundColor: kColorwhite,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: kColorblack,
              size: 17.5.sp,
            ),
            onPressed: () {
              Get.to(
                () =>  BottomNavigationMainscreen(
                  initialIndex: 1,
                ),
                transition: Transition.rightToLeft,
              );
            },),
        actions: [
          TextButton(
            onPressed: _endTask,
            child: const Text("End Task",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 15,
              ),
              markers: markers,
              polylines: polylines,
              onMapCreated: (controller) => mapController = controller,
            ),
    );
  }
}
