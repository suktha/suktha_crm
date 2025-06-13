import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHistoryData {
  final DateTime timestamp;
  final LatLng location;

  // Named constructor to create LocationHistoryData instances
  LocationHistoryData._(this.timestamp, this.location);

  // Factory constructor to provide a more user-friendly way to create instances
  factory LocationHistoryData(DateTime timestamp, LatLng location) {
    return LocationHistoryData._(timestamp, location);
  }
}
