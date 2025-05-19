import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import '../../../../Model/user_model.dart';
import '../controller/user_profile_controller.dart';

AlertDialog UpdateLoginDetailsCustom(
    {required UserModel userProfileValue,
    required UserProfileController controller,
    required GlobalKey updateLoginFormKey,
    required VoidCallback onSave}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Text("Update Login Details for ${controller.nameController.text}"),
    content: Container(
      height: 35.h,
      width: 100.w,
      child: Form(
        key: updateLoginFormKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomTextField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter the valid email";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onchanged: (value) {
                    if (userProfileValue.isLogInRequired == null) {
                      print("if inside-----");

                      controller.checkEmail(value);
                    } else {
                      print("else inside-----");
                    }
                  },
                  obscure: false,
                  controller: controller.emailController,
                  label: "Email*"),
              CustomTextField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter the Username";
                    }
                    return null;
                  },
                  onchanged: (value) {
                    if (userProfileValue.isLogInRequired == null) {
                      print("if inside-----");

                      controller.checkUserName(value);
                    } else {
                      print("else inside-----");
                    }
                  },
                  textInputAction: TextInputAction.next,
                  obscure: false,
                  controller: controller.userNameController,
                  label: "Username*"),
              Obx(() => CustomTextField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter the valid password";
                    }
                    if (value.length < 5 || value.length > 12) {
                      return 'Password must be between 5 and 12 characters';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.isClicked.value = !controller.isClicked.value;
                      },
                      icon: controller.isClicked.value == true ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                  textInputAction: TextInputAction.next,
                  obscure: controller.isClicked.value,
                  controller: controller.newPasswordController,
                  multilines: 1,
                  maxLength: 12,
                  label: "New Password*")),
              Obx(() => CustomTextField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter the valid password";
                    }
                    if (value != controller.newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.isClicked2.value = !controller.isClicked2.value;
                      },
                      icon: controller.isClicked2.value == true ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                  obscure: controller.isClicked2.value,
                  multilines: 1,
                  maxLength: 12,
                  controller: controller.confirmPasswordController,
                  label: "Confirm Password*")),
            ],
          ),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
                controller.newPasswordController.text = "";
                controller.confirmPasswordController.text = "";
              },
              child: Container(
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(boxShadow: kElevationToShadow[2], color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                  "Back",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                )),
              ),
            ),
            GestureDetector(
              onTap: onSave,
              child: Container(
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(boxShadow: kElevationToShadow[2], color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                )),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
