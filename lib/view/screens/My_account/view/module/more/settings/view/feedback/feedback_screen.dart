
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  
  final _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

 

  void _submitFeedback() {
    final feedback = _feedbackController.text;

    if (feedback.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Feedback submitted ✅")),
      );
      _feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorwhite,
      appBar: AppBar(
        backgroundColor: kColorwhite,
        elevation: 0,
        title: const Text(
          'Notification Settings',
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
                  return 'Please enter your feedback';
                }
                return null;
              },
              label: "Your Feedback",
              titleController: _feedbackController,
             
            ),
            const SizedBox(height: 20),
            CustomButton(title: "Send Feedback", ontap: _submitFeedback, width: double.infinity),
            // ElevatedButton.icon(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.green,
            //     minimumSize: const Size.fromHeight(50),
            //   ),
            //   onPressed: _submitFeedback,
            //   icon: const Icon(Icons.send),
            //   label: const Text("Send Feedback"),
            // ),
          ],
        ),
      ),
    );
  }
}