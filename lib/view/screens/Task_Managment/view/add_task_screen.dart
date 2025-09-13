// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/Task_Managment/controllers/task_controller.dart';
import 'package:work_Force/view/screens/Task_Managment/task_managment.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class AddTaskScreen extends StatelessWidget {
  final bool isEdit;
  bool Iscompleted = false;
  AddTaskScreen({super.key, required this.isEdit, required this.Iscompleted});
  final TaskController controller = Get.put(TaskController());
  Task? task;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit == true ? "Edit Task" : "Add New Task",
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: kColorwhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
              clearFunction(controller);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
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
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.textController,
                              decoration: const InputDecoration(
                                labelText: "Type or record voice",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  controller.isRecording.value
                                      ? Icons.stop
                                      : Icons.mic,
                                  color: controller.isRecording.value
                                      ? Colors.red
                                      : Colors.blue,
                                ),
                                onPressed: () => controller.toggleRecording(),
                              ),
                              if (controller.audioFilePath.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: () async {
                                    try {
                                      await player.setFilePath(
                                          controller.audioFilePath.value);
                                      player.play();
                                    } catch (e) {
                                      print("Error playing audio: $e");
                                    }
                                  },
                                )
                            ],
                          )
                        ],
                      );
                    }),
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
                        controller.selectTime(context,
                            controller.taskTimeController); // Open time picker
                      },
                      suffixIcon: IconButton(
                        splashColor: kColortransparent,
                        onPressed: () {
                          controller.selectTime(
                              context,
                              controller
                                  .taskTimeController); // Open time picker
                        },
                        icon: const Icon(Icons.access_time),
                      ),
                      validator: (value) {
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      obscure: false,
                      readonly: true,
                      controller: controller
                          .taskTimeController, // Use the time controller here
                      label: "Task Time*", // Label for the time input
                    ),
                    CustomTextField(
                        ontap: () {
                          DateClass().selectDate(
                              controller.dueDateController, false, true);
                        },
                        suffixIcon: IconButton(
                            splashColor: kColortransparent,
                            onPressed: () {
                              DateClass().selectDate(
                                  controller.dueDateController, false, true);
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
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                            color: kColorwhite),
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
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(14)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  isEdit == true ? "Update" : "Done",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: kColorwhite),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
