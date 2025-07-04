import 'dart:async';
import 'package:get/get.dart';

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
}
