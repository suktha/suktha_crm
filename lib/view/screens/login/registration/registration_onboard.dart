import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/utils/validations/validations.dart';
import 'package:work_Force/view/screens/login/registration/controller/registration_controller.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class RegistrationOnboard extends StatelessWidget {
  RegistrationOnboard({super.key});
  final controller = Get.put(RegistrationController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              Row(
                children: [
                  Image.asset(
                    "assets/Logos/Logo_black.png",
                    height: 4.h,
                  ),
                  SizedBox(width: 2.w),
                  const Text(
                    "Welcome aboard!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "We're excited to have you here. Let's get your company set up.",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
              ),

              // const Spacer(),

              Lottie.asset(
                "assets/lottie/register_lottie.json",
                height: 30.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Flexible(
                flex: 20,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        buildTextField(
                          isRequired: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Company Name is required";
                            }
                            return null;
                          },
                          titleController: controller.companyNameController,
                          label: "Company Name*",
                          keyboardType: TextInputType.text,
                        ),
                        buildTextField(
                          isRequired: true,
                          titleController: controller.gstTypeController,
                          label: "GST Type*",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "GST Type is required";
                            }
                            return null;
                          },
                        ),
                        buildTextField(
                          isRequired: true,
                          titleController: controller.gstNumberController,
                          label: "GST Number*",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "GST Number is required";
                            }
                            return null;
                          },
                        ),
                        buildTextField(
                          isRequired: true,
                          titleController: controller.nameController,
                          label: "Your Name*",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Your Name is required";
                            }
                            return null;
                          },
                        ),
                        buildTextField(
                          isRequired: true,
                          titleController: controller.phoneController,
                          label: "Phone Number*",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone Number is required";
                            }
                            if (Validate().validateMobile(value) == false) {
                              return "Invalid Phone Number";
                              
                            }
                            return null;
                          },
                        ),
                        buildTextField(
                          isRequired: true,
                          titleController: controller.stateController,
                          label: "State*",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "State is required";
                            }
                            return null;
                          },
                        ),
                        buildTextField(
                          isRequired: true,
                          titleController: controller.addressController,
                          label: "Address*",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Address is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.goToNextScreen();
                    } else {
                      Get.snackbar("Error", "Please fill in all fields",
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
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
