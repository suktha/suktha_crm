import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskReportController extends GetxController {
  var dateList = <Map<String, String>>[].obs;
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    generateLast30Days();
  }

  void generateLast30Days() {
    dateList.clear();
    DateTime today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      DateTime date = today.subtract(Duration(days: i));
      String day = DateFormat('dd').format(date);
      String weekday = DateFormat('E').format(date);
      dateList.add({
        'day': day,
        'weekday': weekday,
        'fullDate': date.toIso8601String(),
      });
    }
  }

  void selectDate(String fullDate) {
    selectedDate.value = DateTime.parse(fullDate);
  }
}
