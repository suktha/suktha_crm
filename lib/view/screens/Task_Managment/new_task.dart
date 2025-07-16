// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/Task_Managment/controllers/task_controller.dart';
import 'package:work_Force/view/screens/Task_Managment/task_managment.dart';
import 'package:work_Force/view/screens/Task_Managment/view/add_task_screen.dart';
import 'package:work_Force/view/screens/Task_Managment/view/task_card_screen.dart';

class NewTaskScreen extends StatefulWidget {
  bool? isFromHomeScreen;

  NewTaskScreen({super.key, this.isFromHomeScreen});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskController controller = Get.put(TaskController());
  // final AudioController audioController = Get.put(AudioController());

  void toggleRadioButton() {
    setState(() {
      controller.isCompletedSelected.value =
          !controller.isCompletedSelected.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: kColorLightGrey,
        appBar: AppBar(
          title:  Text("Tasks Managment",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          // centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,

          bottom: TabBar(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: kColorgreyShade400,
              isScrollable: true,
              labelColor: Colors.black,
              indicatorColor: kColorlightBlue,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Today’s Task'),
                Tab(text: 'Important'),
                Tab(text: 'Planned'),
                Tab(text: 'Assigned To Me'),
                 Tab(text: 'Completed'),
              ]),
        ),
        body: TabBarView(
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Insert the compact widget anywhere in your UI
                  // VoiceRecorderWidget(),
                ],
              ),
            ),
            TaskTabContent(
              controller: controller,
            ),
            const Center(child: Text('Important')),
            const Center(child: Text('Planned')),
            const Center(child: Text('Assigned To Me')),
            const Center(child: Text('Completed')),
          ],
        ),
      ),
    );
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
}

 
class TaskTabContent extends StatelessWidget {
  TaskController controller;
  TaskTabContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                   Text(
                    'Today’s Task',
                    style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Wednesday, 11 May',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => AddTaskScreen(isEdit: false,Iscompleted: false,));
                  // If you want to clear the fields after navigating
                  //
                clearFunction(controller);
                },
                
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blue.shade50,
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    side: BorderSide(
                      color: Colors.blue.shade100,
                    )
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'New Task',
                    style: TextStyle(color: Colors.blue.shade800, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TaskFilterChip(label: 'All', count: 35),
              // TaskFilterChip(label: 'Open', count: 14),
              // TaskFilterChip(label: 'Closed', count: 19),
              // TaskFilterChip(label: 'Archived', count: 2),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                TaskCard(
                  title: 'Client Review & Feedback',
                  subtitle: 'Crypto Wallet Redesign',
                  time: 'Today 10:00 AM',
                  completed: false,
                  isStarred: false,
                  assignedName: 'Unassigned',
                  tags: "High",
                  tagColor: Colors.red,
                ),
                TaskCard(
                  title: 'Adjust the width',
                  subtitle: 'This approach allows more control over ',
                  time: 'Today 04:00 PM',
                  completed: false,
                  isStarred: false,
                  assignedName: 'Ajith',
                  tags: "Low",
                  tagColor: Colors.amber,
                ),
                TaskCard(
                  title: 'Radio Button Toggle UI',
                  subtitle: 'Change color',
                  time: 'Today 01:00 PM',
                  completed: false,
                  isStarred: false,
                  assignedName: 'Kiran Test',
                  tags: "Medium",
                  tagColor: Colors.indigo,
                ),
                TaskCard(
                  title: 'Layout and functionality',
                  subtitle: 'Redesign',
                  time: 'Today 11:00 PM',
                  completed: false,
                  isStarred: false,
                  assignedName: 'Unassigned',
                  tags: "High",
                  tagColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

