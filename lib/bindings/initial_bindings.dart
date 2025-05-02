import 'package:get/get.dart';
import 'package:suktha_crm/controllers/Home_controller.dart';
import 'package:suktha_crm/utils/Services/websocket_location_services.dart';
import 'package:suktha_crm/view/settings_module/tracking/user/user_field_work/user_management_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<UserManagementController>(UserManagementController(), permanent: true);
    Get.put<WebSocketService>(WebSocketService(), permanent: true);
  }
}
