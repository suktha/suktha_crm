import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionServices extends GetxService {
  Future<PermissionServices> init() async {
    return this;
  }

  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<bool> checkLocationPermission() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }
}
