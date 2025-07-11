import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();

  final List<String> _designations = [
    'Admin',
    'Manager',
    'Field Staff',
    'Sales Executive',
    'Support Agent',
  ];
  String? _selectedDesignation;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final profileData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'employeeId': _employeeIdController.text.trim(),
        'phone': _phoneController.text.trim(),
        'mobile': _mobileController.text.trim(),
        'designation': _selectedDesignation,
        'address': _addressController.text.trim(),
      };
      debugPrint('Saved => $profileData');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information saved')),
      );
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) =>
      InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kColorLightGrey),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorwhite,
      appBar: AppBar(
        title: const Text(
          'Personal Information',
        ),
        titleTextStyle: TextStyle(
            color: kColorblack, fontWeight: FontWeight.bold, fontSize: 19.sp),
        backgroundColor: kColorwhite,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.keyboard_arrow_left, size: 24.sp, color: kColorblack),
          onPressed: Get.back,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- Avatar & header --- //
                      
              
                      // --- Card with inputs --- //
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                          child: Column(
                            children: [
                              // Name
                              TextFormField(
                                controller: _nameController,
                                decoration: _inputDecoration(
                                    'Name', Icons.person_outline_rounded),
                                validator: (v) => (v == null || v.trim().isEmpty)
                                    ? 'Enter name'
                                    : null,
                              ),
                              SizedBox(height: 2.h),
              
                              // Email
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    _inputDecoration('Email', Icons.email_rounded),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Enter email';
                                  }
                                  final reg =
                                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
                                  return reg.hasMatch(v.trim())
                                      ? null
                                      : 'Invalid email';
                                },
                              ),
                              SizedBox(height: 2.h),
              
                              // Employee ID
                              TextFormField(
                                controller: _employeeIdController,
                                decoration: _inputDecoration(
                                    'Employee ID', Icons.badge_rounded),
                              ),
                              SizedBox(height: 2.h),
              
                              // Phone
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration:
                                    _inputDecoration('Phone', Icons.phone_rounded),
                              ),
                              SizedBox(height: 2.h),
              
                              // Mobile
                              TextFormField(
                                controller: _mobileController,
                                keyboardType: TextInputType.phone,
                                decoration: _inputDecoration(
                                    'Mobile Number', Icons.smartphone_rounded),
                                validator: (v) => (v == null || v.trim().isEmpty)
                                    ? 'Enter mobile'
                                    : null,
                              ),
                              SizedBox(height: 2.h),
              
                              // Designation
                              DropdownButtonFormField<String>(
                                value: _selectedDesignation,
                                items: _designations
                                    .map((d) =>
                                        DropdownMenuItem(value: d, child: Text(d)))
                                    .toList(),
                                decoration: _inputDecoration(
                                    'Designation', Icons.work_outline_rounded),
                                onChanged: (v) =>
                                    setState(() => _selectedDesignation = v),
                                validator: (v) =>
                                    v == null ? 'Select designation' : null,
                              ),
                              SizedBox(height: 2.h),
              
                              // Address
                              TextFormField(
                                controller: _addressController,
                                maxLines: 4,
                                decoration: _inputDecoration(
                                    'Address', Icons.home_work_outlined),
                                validator: (v) => (v == null || v.trim().isEmpty)
                                    ? 'Enter address'
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: 17.h),
              
                      // --- Save button --- //
                     
                    ],
                  ),
                ),
              ),
            ),
             Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 5.h,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kColorlightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 2,
                            ),
                            child: Text('Save', style: TextStyle(fontSize: 17.sp)),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
