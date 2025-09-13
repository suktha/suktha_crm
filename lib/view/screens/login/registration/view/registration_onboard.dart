import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/utils/validations/validations.dart';
import 'package:work_Force/view/screens/login/registration/controller/registration_controller.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

class RegistrationOnboard extends StatelessWidget {
  RegistrationOnboard({super.key});
  final controller = Get.put(RegistrationController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 17.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Flexible(
                flex: 20,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/lottie/register_lottie.json",
                          height: 30.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        buildTextField(
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

                       DropdownButtonFormField<int>(
                            validator: (value) {
                              if (value == null || value == 0) {
                                return "GST Type is required";
                              }
                              return null;
                            },
                            decoration:
                                customInputDecoration("GST Registration Type"),
                           
                            items: controller.registrationTypeList.map((gstType) {
                              return DropdownMenuItem<int>(
                                value: gstType['id'],
                                child: Text(gstType['name'] ?? ""),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedRegistrationId.value =
                                    value;
                                print("Selected id: $value");
                              }
                            },
                          ),
                        
                        //  Obx(() => DropdownButtonFormField(
                        //       validator: (value) {
                        //         if (value == null) {
                        //           return "State is required";
                        //         }
                        //         return null;
                        //       },
                        //       decoration: customInputDecoration("State*"),
                        //       items: controller.stateList.map(
                        //         (state) {
                        //           return DropdownMenuItem(
                        //               value: state.id,
                        //               child: Text(state.name ?? ""));
                        //         },
                        //       ).toList(),
                        //       onChanged: (value) {
                        //         controller.stateId.value = value ?? 0;
                        //         print("id---$value");
                        //       },
                        //     )),
                        SizedBox(
                          height: 3.w,
                        ),
                        buildTextField(
                          titleController: controller.gstNumberController,
                          label: "GST Number(eg: 22AAAAA0000A1Z5)",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            if (!Validate().validateGST(value)) {
                              return "Invalid GST Number";
                            }
                            return null;
                          },
                        ),
                        buildTextField(
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
                        Obx(() => DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return "State is required";
                                }
                                return null;
                              },
                              decoration: customInputDecoration("State*"),
                              items: controller.stateList.map(
                                (state) {
                                  return DropdownMenuItem(
                                      value: state.id,
                                      child: Text(state.name ?? ""));
                                },
                              ).toList(),
                              onChanged: (value) {
                                controller.stateId.value = value ?? 0;
                                print("id---$value");
                              },
                            )),
                        SizedBox(
                          height: 3.w,
                        ),

                        // buildTextField(
                        //   titleController: controller.stateController,
                        //   label: "State*",
                        //   keyboardType: TextInputType.text,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "State is required";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        buildTextField(
                          titleController: controller.addressController,
                          label: "Address*",
                          maxLengthCount: 200,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Address is required";
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                  title: "Next",
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      controller.goToNextScreen();
                    } else {
                      Get.snackbar("Error", "Please fill in all fields",
                          snackPosition: SnackPosition.TOP);
                    }
                  },
                  width: double.infinity),
           
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration customInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(3.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue.shade300,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(3.w),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(3.w),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.orange,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(3.w),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.w),
    ),
  );
}
