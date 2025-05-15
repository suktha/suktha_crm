import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Model/lead_model.dart';
import 'package:work_Force/view/widget/snackbar.dart';

import 'package:url_launcher/url_launcher.dart';

class GetLocationController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  var currentPosition = Rxn<Position>();
  var _currentAddress = "".obs;

  var searchResults = <Location>[].obs;
  var searchedAddress = "".obs;
  var searchedLocation = Rxn<Position>();
  RxBool isGetCurrentLocationClicked = false.obs;

  // var addedLocationList = <LeadModel>[].obs;

  // Future<void> addPositionByIndex(int index, Position position, List<LeadModel>? addedLocationList) async {
  //   print("inside:$index");

  //   if (index >= 0 && index < addedLocationList!.length) {
  //     addedLocationList[index].location = position;
  //     print("lat---${position.latitude}");
  //     print("long---${position.longitude}");
  //     await saveUpdatedList(addedLocationList);
  //   }
  // }

  // Future<void> saveUpdatedList(List<LeadModel>? updatedList) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String jsonString = jsonEncode(updatedList!.map((item) => item.toJson()).toList());

  //   await prefs.setString('leadModelList', jsonString);
  //   customSnackbar("Success", "Location saved successfully", "success");

  //   print("List has been updated and saved to SharedPreferences!");
  // }

  // Future<List<LeadModel>> loadListFromSharedPreferences() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String? jsonString = prefs.getString('leadModelList');

  //   List<dynamic> jsonList = jsonDecode(jsonString!);
  //   return jsonList.map((jsonItem) => LeadModel.fromJson(jsonItem)).toList();
  // }

  // Future<void> displayLocationByIndex(int index) async {
  //   List<LeadModel> leadList = await loadListFromSharedPreferences();

  //   if (index >= 0 && index < leadList.length) {
  //     Position? position = leadList[index].location;

  //     if (position != null) {
  //       print("Latitude: ${position.latitude}");
  //       print("Longitude: ${position.longitude}");
  //       openGoogleMaps(position.latitude, position.longitude);
  //     } else {
  //       print("No location data found at index $index.");
  //     }
  //   } else {
  //     print("Invalid index: $index.");
  //   }
  // }

  var loading = false.obs;
  var isSearchClicked = false.obs;
  var isSaved = false.obs;

  Future<void> getCurrentLocation(index, List<LeadModel>? addedLocationList) async {
    try {
      loading.value = true;
      isSaved.value = false;
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        print(" permission is allowed");

        currentPosition.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        ).then((Position position) {
          GetAddressFromLatLng(position, index, addedLocationList!);
        });
        isSaved.value = true;
      }
    } catch (e) {
    } finally {
      loading.value = false;
    }
  }

  GetAddressFromLatLng(Position position, int index, List<LeadModel>? addedLocationList) async {
    await placemarkFromCoordinates(position.latitude, position.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      searchedAddress.value = "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
      latitudeController.text = position.latitude.toString();
      longitudeController.text = position.longitude.toString();
      // addPositionByIndex(index, position, addedLocationList);
      print("lat--2-${latitudeController.text}");
      print("long-2--${longitudeController.text}");
    }).catchError((e) {});
  }

  void searchLocation(String placeName) async {
    try {
      loading.value = true;
      isSearchClicked.value = false;
      List<Location> locations = await locationFromAddress(placeName);
//  searchResults.value = locations;
      if (locations.isNotEmpty || placeName.isNotEmpty) {
        // Store the first result's lat and long in the searchedLocation variable
        searchedLocation.value = Position(
          latitude: locations[0].latitude,
          longitude: locations[0].longitude,
          timestamp: locations[0].timestamp,
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        );

        // Optionally, get the human-readable address
        placemarkFromCoordinates(
          locations[0].latitude,
          locations[0].longitude,
        ).then((List<Placemark> placemarks) {
          Placemark place = placemarks[0];
          searchedAddress.value = "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
          print("Searched Address: " + searchedAddress.value);
        }).catchError((e) {
          print("Error getting address: $e");
        });

        longitudeController.text = searchedLocation.value!.longitude.toString();
        latitudeController.text = searchedLocation.value!.latitude.toString();

        print("Searched Location: Latitude = ${searchedLocation.value?.latitude}, Longitude = ${searchedLocation.value?.longitude}");
        print("controller Location: Latitude = ${latitudeController.text}, Longitude = ${longitudeController.text}");

        isSearchClicked.value = true;
      } else if (searchController.text.isEmpty || placeName.isEmpty) {
        customSnackbar("Error", "Enter your location", "error");
      }
    } catch (e) {
      print("Error searching location: $e");
    } finally {
      loading.value = false;
    }
  }

  // void openMap(double latitude, double longitude) async {
  //   final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //   final Uri url = Uri.parse(googleMapsUrl);

  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(
  //       url,
  //       mode: LaunchMode.platformDefault, // Very important!
  //     );
  //   } else {
  //     throw Exception('Could not launch $googleMapsUrl');
  //   }
  // }

  openGoogleMaps(double endLat, double endLng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$endLat,$endLng&travelmode=driving';
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("error ");
      throw 'Could not launch $url';
    }
  }
}
