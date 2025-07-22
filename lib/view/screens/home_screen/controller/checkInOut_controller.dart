import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:work_Force/Model/designation_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/view/screens/home_screen/view/clockedInTask_screen.dart';

class CheckInOutController extends GetxController {
  var isClockedIn = false.obs;
  var startTime = DateTime.now().obs;
  var workedDuration = Duration.zero.obs;

  final Rx<Duration> elapsedTime = Duration.zero.obs;
  Timer? _timer;

  void toggleCheck() {
    if (isClockedIn.value) {
      // Clocking out
      _timer?.cancel();
      workedDuration.value = DateTime.now().difference(startTime.value);
    } else {
      // Clocking in
      startTime.value = DateTime.now();
      elapsedTime.value = Duration.zero;
      Get.to(() => ClockedintaskScreen());

      _timer?.cancel();

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsedTime.value = DateTime.now().difference(startTime.value);
      });
    }
    isClockedIn.toggle();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void onInit() {
    super.onInit();
    getDesignationList();
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
