import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController {
  DateTime today = DateTime.now();
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxList<Map<String, dynamic>> timeSlots = <Map<String, dynamic>>[].obs;
  RxList<Task> taskdetails = <Task>[].obs;

  RxString formattedSelectedDate = "".obs;
  RxBool isCompletedSelected = true.obs;
  RxBool isFromClockIn = true.obs;
  // late RecorderController recorderController;

  RxInt selectedIndex = (-1).obs;

  TextEditingController taskNameController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final TextEditingController taskTypeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController taskTimeController = TextEditingController();
  final TextEditingController assignToController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    formattedSelectedDate.value = DateFormat('dd/MM/yyyy').format(today);
    initializeTimeSlots();
  }

  void selectTime(
      BuildContext context, TextEditingController timeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      String formattedTime = pickedTime.hour > 12
          ? "${pickedTime.hour - 12}:${pickedTime.minute.toString().padLeft(2, '0')} PM"
          : "${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')} AM";
      timeController.text = formattedTime;

      print("selected time -- $timeController");
    }
  }

  void initializeTimeSlots() {
    for (int i = 0; i < 24; i++) {
      DateTime time = DateTime(today.year, today.month, today.day, i);
      String timeLabel = DateFormat('hh:mm a').format(time);
      timeSlots
          .add({'time': time, 'timeLabel': timeLabel, 'tasks': <Task>[].obs});
    }
    print("time slot  -- ${timeSlots.toJson()}");
  }

  void addTask(Task task) {
    DateTime taskTime = DateFormat('hh:mm a').parse(task.time);
    for (var slot in timeSlots) {
      if (slot['time'].hour == taskTime.hour) {
        (slot['tasks'] as RxList<Task>).add(task);
        update();
        return;
      }
    }
    print(
        "No matching time slot found for ${DateFormat('hh:mm a').format(taskTime)}");
  }

  void deleteTask(Task task) {
    for (var slot in timeSlots) {
      var tasks = slot['tasks'] as RxList<Task>;
      if (tasks.contains(task)) {
        tasks.remove(task);
        update();
        return;
      }
    }
    print("Task not found");
  }

  RxList<Task> tasksForSelectedDate = <Task>[].obs;
  List<Task> getTasksForSelectedDate(String SelectedDate) {
    timeSlots.clear();
    for (var slot in timeSlots) {
      tasksForSelectedDate.addAll((slot['tasks'] as RxList<Task>)
          .where((task) => task.date == SelectedDate)
          .toList());
    }

    return tasksForSelectedDate;
  }

  RxBool isRecording = false.obs;
  RxList<VoiceNote> voiceNotes = <VoiceNote>[].obs;
  DateTime? _recordingStartTime;

  final AudioRecorder _record = AudioRecorder();
  Future<void> startRecording() async {
    if (await Permission.microphone.request() != PermissionStatus.granted) {
      return;
    }

    final directory = Directory.systemTemp;
    final path =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';

    _recordingStartTime = DateTime.now();

    await _record.start(
      const RecordConfig(),
      path: path,
    );

    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    final path = await _record.stop();

    if (path != null && _recordingStartTime != null) {
      final duration = DateTime.now().difference(_recordingStartTime!);

      voiceNotes.add(
        VoiceNote(
          path: path,
          duration: duration,
        ),
      );
    }

    isRecording.value = false;
  }

  Future<void> toggleRecording() async {
    if (isRecording.value) {
      await stopRecording();
    } else {
      await startRecording();
    }
  }
}

class Task {
  final String title;
  final String? date;
  final String description;
  final String time;
  final Color? color;
  final String? priority;
  final Color? priorityColor;

  Task({
    required this.title,
    this.date,
    required this.description,
    required this.time,
    this.color,
    this.priority,
    this.priorityColor,
  });
}

class VoiceNote {
  final String path;
  final Duration duration;
  RxBool isPlaying = false.obs;

  VoiceNote({
    required this.path,
    required this.duration,
  });
}
