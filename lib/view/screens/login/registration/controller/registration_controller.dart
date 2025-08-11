import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/view/screens/login/registration/registration_screen.dart';

class RegistrationController extends GetxController {
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final gstTypeController = TextEditingController();
  final gstNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final nameController = TextEditingController();

  void goToNextScreen() {
    // if (companyNameController.text.isEmpty ||
    //     emailController.text.isEmpty ||
    //     phoneController.text.isEmpty) {
    //   Get.snackbar("Error", "Please fill in all fields");
    //   return;
    // }

    Get.to(() => const RegistrationScreen(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 600));
  }

  @override
  void onClose() {
    companyNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
