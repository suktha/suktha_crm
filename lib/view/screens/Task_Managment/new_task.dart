// ignore_for_file: avoid_print, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/Task_Managment/controllers/task_controller.dart';
import 'package:work_Force/view/screens/Task_Managment/task_managment.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskController controller = Get.put(TaskController());
  // final AudioController audioController = Get.put(AudioController());

  void toggleRadioButton() {
    setState(() {
      controller.isCompletedSelected.value = !controller.isCompletedSelected.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: kColorLightGrey,
        appBar: AppBar(
          title: const Text("Tasks Managment", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
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
 addTaskBottomSheet(BuildContext context, bool isEdit, TaskController controller, [Task? task, bool? Iscompleted]) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      // isDismissible: true,
      // isScrollControlled: true,
      // useSafeArea: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
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
                          isEdit == true ? "Edit Task" : "Add new tasks",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                              clearFunction(controller);
                              // controller.clearFunction();
                            },
                            icon: const Icon(
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
                    physics: const BouncingScrollPhysics(),
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
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Record your voice here:"),
                            SizedBox(height: 10),

                            // Insert the compact widget anywhere in your UI
                            // VoiceRecorderWidget(),

                            SizedBox(height: 20),
                            Text("Other UI Elements Below..."),
                          ],
                        ),
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
                            icon: const Icon(Icons.access_time),
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
                                icon: const Icon(Icons.date_range)),
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
                const Spacer(),
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
                            : const SizedBox.shrink(),
                        isEdit == true
                            ? const SizedBox(
                                width: 10,
                              )
                            : const SizedBox(),
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  const Text(
                    'Today’s Task',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Wednesday, 11 May',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  addTaskBottomSheet(context, false, controller);
                  clearFunction(controller);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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

class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;
  final String tags;
  Color tagColor;
  final String assignedName;

  bool completed;
  bool isStarred;

  TaskCard(
      {super.key, required this.title,
      required this.subtitle,
      required this.time,
      required this.completed,
      required this.isStarred,
      required this.assignedName,
      required this.tags,
      required this.tagColor});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.completed == false) {
                        widget.completed = true;
                      } else if (widget.completed == true) {
                        widget.completed = false;
                      }
                      print("completedd---${widget.completed}");
                    });
                  },
                  child: Icon(
                    Icons.check_circle,
                    color: widget.completed ? Colors.blue : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: widget.completed ? TextDecoration.lineThrough : TextDecoration.none,
                        decorationThickness: 1.5),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.isStarred == false) {
                        widget.isStarred = true;
                      } else if (widget.isStarred == true) {
                        widget.isStarred = false;
                      }
                      print("isStarredd---${widget.isStarred}");
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: widget.isStarred ? Colors.amber : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const Spacer(),
                Text(
                  widget.assignedName,
                  style: const TextStyle(color: Colors.green, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            Row(
              children: [
                Text(
                  widget.time,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.tags,
                  style: TextStyle(color: widget.tagColor, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                // SizedBox(
                //   width: 5.w,
                // ),

                const Icon(
                  Icons.loop,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.notifications,
                  color: Colors.pink,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
