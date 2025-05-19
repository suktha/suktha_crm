import 'package:get/get.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/utils/Services/websocket_location_services.dart';
import 'package:work_Force/view/settings_module/tracking/admin/controller/filed_work_controller.dart';
import 'package:work_Force/view/settings_module/tracking/user/user_field_work/user_management_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FieldWorkController>(() => FieldWorkController());
    Get.put<UserManagementController>(UserManagementController(), permanent: true);
    Get.put<WebSocketService>(WebSocketService(), permanent: true);
  }
}
