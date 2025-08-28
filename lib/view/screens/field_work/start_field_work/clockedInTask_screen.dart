// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/designation_model.dart';
import 'package:work_Force/view/screens/Task_Managment/controllers/task_controller.dart';
import 'package:work_Force/view/screens/Task_Managment/new_task.dart';
import 'package:work_Force/view/screens/field_work/controller/checkInOut_controller.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class ClockedintaskScreen extends StatelessWidget {
  ClockedintaskScreen({super.key});
  CheckInOutController controller = Get.find<CheckInOutController>();
  final TaskController taskController = Get.put(TaskController());

  DesignationModel? designationValue;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Task – On Field Duty"),
        titleTextStyle: TextStyle(
            color: kColorblack, fontWeight: FontWeight.bold, fontSize: 18.sp),
        centerTitle: true,
        backgroundColor: kColorwhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kColorblack,
            size: 18.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 0.5.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: RichText(
                    text: TextSpan(
                  text: 'You are currently clocked in,',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.5.sp,
                      color: kColorlightBlue500),
                  children: [
                    TextSpan(
                      text: ' please complete your tasks.',
                      style: TextStyle(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600),
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.w),
                child: Column(
                  children: [
                    TypeAheadField<DesignationModel>(
                      debounceDuration: const Duration(milliseconds: 500),
                      controller: controller.designationController,
                      hideOnSelect: true,
                      hideWithKeyboard: true,
                      builder: (context, designationController,
                          designationfocusNode) {
                        return TextFormField(
                            enabled: true,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a designation';
                              }
                              return null;
                            },
                            controller: designationController,
                            focusNode: designationfocusNode,
                            decoration: InputDecoration(
                              labelText: "Select Designation*",
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: kColorblack,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0), // Default border
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue.shade300,
                                    width: 1.0), // Border when focused
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0), // Border on validation error
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                            ));
                      },
                      suggestionsCallback: (String pattern) =>
                          controller.getDesignationList(),
                      itemBuilder: (context, DesignationModel suggestion) {
                        final designationValue = suggestion;
                        return ListTile(
                          title: Text(designationValue.designationName),
                        );
                      },
                      loadingBuilder: (context) {
                        return SizedBox(
                            height: 10.h,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      },
                      emptyBuilder: (context) {
                        return SizedBox(
                          height: 10.h,
                          child: Center(
                            child: Text(
                              "No items Found",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            ),
                          ),
                        );
                      },
                      onSelected: (DesignationModel suggestion) {
                        designationValue = suggestion;

                        controller.designationController.text =
                            designationValue!.designationName.toString();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 20,
                  child: TaskTabContent(
                    controller: taskController,
                    isFromClockIn: true,
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorlightBlue500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (taskController.selectedIndex.value == -1) {
                            customSnackbar(
                                "Error", "Please select a task", "error");
                          } else {
                            controller.toggleCheck();
                          }
                        } else {
                          customSnackbar(
                              "Error", "Please fill all fields", "error");
                        }
                      },
                      child: Text("Start Field Work",
                          style: TextStyle(
                              fontSize: 16.5.sp,
                              fontWeight: FontWeight.w600,
                              color: kColorwhite))),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
