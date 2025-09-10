import 'package:get/get.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/utils/Services/websocket_location_services.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/controller/filed_work_controller.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/controller/location_controller.dart';
import 'package:work_Force/view/screens/field_work/tracking/user/user_field_work/user_management_controller.dart';
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
    Get.put(SettingsController());
    Get.put(GetLeadController());
    Get.put<NavigationController>(NavigationController());
    Get.put<GeoLocationController>(GeoLocationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FieldWorkController>(() => FieldWorkController());
    Get.put<UserManagementController>(UserManagementController(),
        permanent: true);
    Get.put<WebSocketService>(WebSocketService(), permanent: true);
  }
}
