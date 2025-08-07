import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/login/registration/controller/registration_controller.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class RegistrationOnboard extends StatelessWidget {
  RegistrationOnboard({super.key});
  final controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Spacer(),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Welcome aboard!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We're excited to have you here. Let's get your company set up.",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
              ),
              
              // const Spacer(),

              Lottie.asset(
                "assets/lottie/register_lottie.json",
                height: 35.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
             
              Flexible(
                flex: 20,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                       SizedBox(
                height: 2.h,
              ),
                      buildTextField(
                        isRequired: false,
                        titleController: controller.companyNameController,
                        label: "Company Name",
                        keyboardType: TextInputType.text,
                      ),
                      buildTextField(
                        isRequired: false,
                        titleController: controller.emailController,
                        label: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      buildTextField(
                        isRequired: false,
                        titleController: controller.phoneController,
                        label: "Phone Number",
                        keyboardType: TextInputType.phone,
                      ),
                      buildTextField(
                        isRequired: false,
                        titleController: controller.companyNameController,
                        label: "Company Name",
                        keyboardType: TextInputType.text,
                      ),
                      buildTextField(
                        isRequired: false,
                        titleController: controller.emailController,
                        label: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      buildTextField(
                        isRequired: false,
                        titleController: controller.phoneController,
                        label: "Phone Number",
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.goToNextScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorlightBlue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                  ),
                  child: Text("Next",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
