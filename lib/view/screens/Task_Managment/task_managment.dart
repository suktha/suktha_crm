import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/Task_Managment/controllers/task_controller.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
class TaskManagmentScreen extends StatefulWidget {
  @override
  State<TaskManagmentScreen> createState() => _TaskManagmentScreenState();
}

class _TaskManagmentScreenState extends State<TaskManagmentScreen> {
  DateTime today = DateTime.now();
  DateTime? selectedDate;
  List<DateTime> datesOfMonth = [];
  late final String formattedToday;
  late final DateTime sundayOfThisWeek;
  final ScrollController _scrollController = ScrollController();
  late Task taskitem;

  TaskController controller = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    selectedDate = today;
    print(selectedDate);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentTime());

    formattedToday = DateFormat('MMMM yyyy').format(today);
  }

  void _scrollToCurrentTime() {
    final currentTime = TimeOfDay.now();
    final currentIndex = controller.timeSlots.indexWhere((slot) {
      final timeLabel = slot['timeLabel'] as String;
      final timeParts = timeLabel.split(":");
      final hour = int.parse(timeParts[0]);
      return hour == currentTime.hour;
    });

    if (currentIndex != -1) {
      _scrollController.animateTo(
        currentIndex * 100.0,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks Managment", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 17,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: today, // Use a variable for the focused day
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                      today = selectedDay; // Set the focused day to the selected day
                      print("selected day --$selectedDay");
                      controller.formattedSelectedDate.value = DateFormat('dd/MM/yyyy').format(today);
                      print("selected date --${controller.formattedSelectedDate.value}");
                      // controller.getTasksForSelectedDate(controller.formattedSelectedDate.value);
                      // print("date based data --${controller.tasksForSelectedDate.toJson()}");
                    });
                  },
                  onFormatChanged: (format) {
                    // Toggle between week and month views
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: false,
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    formatButtonVisible: true,
                    formatButtonTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leftChevronMargin: EdgeInsets.only(left: 0, right: 10),
                    rightChevronMargin: EdgeInsets.only(right: 0.0, left: 10),
                    leftChevronPadding: EdgeInsets.zero,
                    rightChevronPadding: EdgeInsets.zero,
                    headerMargin: EdgeInsets.only(bottom: 20.0),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(weekendStyle: TextStyle(color: kColorRed)),
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: kColorlightBlue),
                    weekendTextStyle: TextStyle(color: kColorRed),
                    defaultDecoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kColorgreyShade300)),
                    todayDecoration: BoxDecoration(
                      border: Border.all(color: kColorlightBlue),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  // headerVisible: false,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: Obx(() => ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.timeSlots.length,
                    itemBuilder: (context, index) {
                      var item = controller.timeSlots[index];
                      var tasks = (item['tasks'] as RxList<Task>).where((task) {
                        print("list inside task date ${task.date}");
                        print("list inside selected  date ${controller.formattedSelectedDate.value}");

                        return task.date == controller.formattedSelectedDate.value;
                      }).toList();

                      TimeOfDay timeNow = TimeOfDay.now();
                      String currentTimeLabel =
                          '${timeNow.hourOfPeriod.toString().padLeft(2, '0')}:00 ${timeNow.period == DayPeriod.am ? 'AM' : 'PM'}';

                      bool isCurrentTime = item["timeLabel"] == currentTimeLabel;
                      print("timeee current time --$currentTimeLabel");

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 60,
                                    alignment: Alignment.centerRight,
                                    child: Text(item["timeLabel"]),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: tasks.isEmpty
                                        ? Container(
                                            child: Divider(
                                              color: isCurrentTime ? Colors.transparent : Colors.grey.shade300,
                                              thickness: BorderSide.strokeAlignOutside,
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: tasks.map((task) {
                                              taskitem = task;
                                              return FadeInRight(
                                                duration: Duration(milliseconds: 200),
                                                delay: Duration(milliseconds: index * 100),
                                                child: AppointmentCard(
                                                  task: task,
                                                  controller: controller,
                                                ),
                                              );
                                            }).toList(),
                                          )),
                              ],
                            ),
                            isCurrentTime == true
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: kColorRed,
                                        radius: 5,
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: kColorRed,
                                          // indent: 10.w,
                                          thickness: BorderSide.strokeAlignOutside,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.dueDateController.text = DateFormat('dd/MM/yyyy').format(today);
          final timeNow = TimeOfDay.now();
          String formattedTime =
              '${timeNow.hourOfPeriod}:${timeNow.minute.toString().padLeft(2, '0')} ${timeNow.period == DayPeriod.am ? 'AM' : 'PM'}';
          controller.taskTimeController.text = formattedTime;
          print("time --${controller.taskTimeController.text}");
          addTaskBottomSheet(context, false, controller);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Task task;
  bool? isCompleted;
  TaskController controller;

  AppointmentCard({
    Key? key,
    required this.task,
    this.isCompleted,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[1],
        color: task.color,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              controller.taskNameController.text = task.title;
              controller.descriptionController.text = task.description;
              controller.dueDateController.text = task.date ?? "";
              controller.statusController.text = task.priority ?? "";

              addTaskBottomSheet(context, true, controller, task);
            },
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: isCompleted == true ? Colors.white : task.color,
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, decoration: isCompleted == true ? TextDecoration.lineThrough : null),
                      ),
                      // Spacer(),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined, size: 18, color: Colors.grey[700]),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "${task.time}",
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      if (task.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(width: 55.w, child: Text(task.description, style: TextStyle(fontSize: 14))),
                        ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    task.priority ?? "",
                    style: TextStyle(color: task.priorityColor, fontWeight: FontWeight.bold),
                  )
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Text("${task.date}"),
                  //     SizedBox(
                  //       height: 5,
                  //     ),
                  //     Text(
                  //       task.priority ?? "",
                  //       style: TextStyle(color: task.priorityColor, fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

clearFunction(
  TaskController controller,
) {
  controller.taskNameController.clear();
  controller.descriptionController.clear();
  controller.dueDateController.clear();
  controller.statusController.clear();
  controller.reminderController.clear();
  controller.taskTypeController.clear();
}

addTaskBottomSheet(BuildContext context, bool isEdit, TaskController controller, [Task? task, bool? Iscompleted]) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return Container(
        height: 75.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(top: 1.h, left: 3.w, right: 3.w, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              FadeIn(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        isEdit == true ? "Edit Task" : "Add new task",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                            clearFunction(controller);
                            // controller.clearFunction();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CustomTextField(
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: controller.taskNameController,
                          label: "Task Name*"),
                      CustomTextField(
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: controller.taskTypeController,
                          label: "Task Type"),
                      CustomTextField(
                          maxLength: 500,
                          multilines: 2,
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          obscure: false,
                          controller: controller.descriptionController,
                          label: "Description"),
                      CustomTextField(
                        ontap: () {
                          controller.selectTime(context, controller.taskTimeController); // Open time picker
                        },
                        suffixIcon: IconButton(
                          splashColor: kColortransparent,
                          onPressed: () {
                            controller.selectTime(context, controller.taskTimeController); // Open time picker
                          },
                          icon: Icon(Icons.access_time),
                        ),
                        validator: (value) {
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        obscure: false,
                        readonly: true,
                        controller: controller.taskTimeController, // Use the time controller here
                        label: "Task Time*", // Label for the time input
                      ),
                      CustomTextField(
                          ontap: () {
                            DateClass().selectDate(controller.dueDateController, false, true);
                          },
                          suffixIcon: IconButton(
                              splashColor: kColortransparent,
                              onPressed: () {
                                DateClass().selectDate(controller.dueDateController, false, true);
                              },
                              icon: Icon(Icons.date_range)),
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          readonly: true,
                          controller: controller.dueDateController,
                          label: "Due Date*"),
                      CustomTextField(
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: controller.reminderController,
                          label: "Reminder*"),
                      CustomTextField(
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: controller.priorityController,
                          label: "Priority*"),
                      CustomTextField(
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: controller.statusController,
                          label: "Status*"),
                      CustomTextField(
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: controller.assignToController,
                          label: "Assign To*"),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 1.0, right: 1, bottom: 8),
                child: GestureDetector(
                  onTap: () async {
                    if (isEdit == true) {
                      Get.back();
                    }
                    Task newTask = Task(
                        title: controller.taskNameController.text,
                        description: controller.descriptionController.text,
                        time: controller.taskTimeController.text,
                        color: controller.statusController.text == "High"
                            ? Colors.red.shade100
                            : controller.statusController.text == "Low"
                                ? Colors.amber.shade100
                                : controller.statusController.text == "Medium"
                                    ? Colors.blue.shade100
                                    : Iscompleted == true
                                        ? Colors.white
                                        : Colors.white,
                        priority: controller.statusController.text,
                        priorityColor: controller.statusController.text == "High"
                            ? Colors.red
                            : controller.statusController.text == "Low"
                                ? Colors.amber.shade900
                                : controller.statusController.text == "Medium"
                                    ? Colors.blue
                                    : Colors.black,
                        date: controller.dueDateController.text);
                    controller.addTask(newTask);
                    Get.back();
                    clearFunction(controller);
                  },
                  child: Row(
                    children: [
                      isEdit == true
                          ? Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.deleteTask(task!);
                                  Get.back();
                                },
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(14)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: kColorwhite),
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          : SizedBox.shrink(),
                      isEdit == true
                          ? SizedBox(
                              width: 10,
                            )
                          : SizedBox(),
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(14)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  isEdit == true ? "Update" : "Done",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: kColorwhite),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
