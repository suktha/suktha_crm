import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class ReportBugScreen extends StatelessWidget {
  ReportBugScreen({super.key});
  final _bugTitleController = TextEditingController();
  final _bugDescController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: kColorwhite,
      appBar: AppBar(
        backgroundColor: kColorwhite,
        elevation: 0,
        title: const Text(
          'Report a Bug',
        ),
        titleTextStyle: TextStyle(
            color: kColorblack, fontSize: 18.sp, fontWeight: FontWeight.w600),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a bug title';
                }
                return null;
              },
              label: "Bug Title",
              titleController: _bugTitleController,
            ),
            buildTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please describe the bug';
                }
                return null;
              },
              titleController: _bugDescController,
              label: "Describe the bug",
            ),
            const SizedBox(height: 20),
            CustomButton(
                title: "Submit Bug", ontap: () {
                  // Handle bug submission logic here
                  final bugTitle = _bugTitleController.text;
                  final bugDescription = _bugDescController.text;

                  if (bugTitle.isNotEmpty && bugDescription.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Bug report submitted ✅")),
                    );
                    _bugTitleController.clear();
                    _bugDescController.clear();
                  }
                }, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
