import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work_Force/view/screens/field_work/Task_Report/controller/task_report_controller.dart';

class TaskReportScreen extends StatelessWidget {
  TaskReportScreen({super.key});

  final TaskReportController controller = Get.put(TaskReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Report"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.dateList.length,
                itemBuilder: (context, index) {
                  var item = controller.dateList[index];
                  DateTime itemDate = DateTime.parse(item['fullDate']!);
                  DateTime selectedDate = controller.selectedDate.value;

                  // Compare only year, month, and day
                  bool isSelected = itemDate.year == selectedDate.year &&
                      itemDate.month == selectedDate.month &&
                      itemDate.day == selectedDate.day;

                  return GestureDetector(
                    onTap: () {
                      controller.selectDate(item['fullDate']!);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 55,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['day']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.red : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['weekday']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const Divider(),
          Obx(() {
            String formattedDate =
                DateFormat('yyyy-MM-dd').format(controller.selectedDate.value);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Selected Date: $formattedDate",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }),
        ],
      ),
    );
  }
}
