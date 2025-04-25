// ignore_for_file: must_be_immutable, prefer_const_constructors, library_prefixes, prefer_final_fields, avoid_print, unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Model/login_model.dart' as loginModel;
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Model/Industry_Segment_Model.dart';
import 'package:suktha_crm/Model/Lead_designation_Model.dart';
import 'package:suktha_crm/Model/area_model.dart';
import 'package:suktha_crm/Model/city_model.dart';
import 'package:suktha_crm/Model/customer_model.dart';
import 'package:suktha_crm/Model/financial_year_model.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/Model/material_models.dart';
import 'package:suktha_crm/Model/name_id_model.dart';
import 'package:suktha_crm/Model/state_model.dart';
import 'package:suktha_crm/Model/status_model.dart';
import 'package:suktha_crm/Model/user_model.dart';
import 'package:suktha_crm/controllers/lead_contact_details_controller.dart';
import 'package:suktha_crm/controllers/lead_controller.dart';
import 'package:suktha_crm/utils/Services/sharedpref_services.dart';
import 'package:suktha_crm/utils/Date.dart';
import 'package:suktha_crm/utils/validations/validations.dart';
import 'package:suktha_crm/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:suktha_crm/view/screens/pre_sales/get_location/controller/get_location_controller.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:suktha_crm/view/widget/custom_button.dart';
import 'package:suktha_crm/view/widget/custom_textfield.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

class NewLeadManagementAddScreen extends StatefulWidget {
  final bool isEdit;
  final bool? isEditFromLeadGen;
  final bool? AddFromContacts;
  final bool? editFromContacts;
  bool? isFromHomeScreen;

  LeadModel? leadValue;

  LeadModel? leadGenerationValue;
  final List<MaterialModel> materialList;
  final List<MaterialModel> serviceList;

  int? IndexOfMandatoryField;

  NewLeadManagementAddScreen({
    super.key,
    this.leadValue,
    required this.isEdit,
    required this.materialList,
    required this.serviceList,
    this.isEditFromLeadGen,
    this.leadGenerationValue,
    this.AddFromContacts,
    this.IndexOfMandatoryField,
    this.editFromContacts,
    this.isFromHomeScreen,
  });

  @override
  State<NewLeadManagementAddScreen> createState() => _NewLeadManagementAddScreenState();
}

class _NewLeadManagementAddScreenState extends State<NewLeadManagementAddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  final GetLocationController locationController = Get.put(GetLocationController());
  final controller = Get.put(LeadController());
  final contactController = Get.put(LeadContactDetaisController());
  FinancialYearModel? financialYear;
  final FocusNode _leadOwnerfocusNode = FocusNode();
  final FocusNode _leadNamefocusNode = FocusNode();
  final FocusNode _leadCategoryfocusNode = FocusNode();
  final FocusNode _reasonConversionfocusNode = FocusNode();
  final FocusNode _customerNamefocusNode = FocusNode();
  final FocusNode _contactPersonNamefocusNode = FocusNode();
  final FocusNode _leadStatusfocusNode = FocusNode();
  final FocusNode _industrySegmentfocusNode = FocusNode();
  final FocusNode _designationfocusNode = FocusNode();
  final FocusNode _assingTofocusNode = FocusNode();
  final FocusNode _sourcefocusNode = FocusNode();
  final FocusNode _priorityfocusNode = FocusNode();
  final FocusNode _conversionChancefocusNode = FocusNode();
  final FocusNode _areafocusNode = FocusNode();
  final FocusNode _cityfocusNode = FocusNode();
  final FocusNode _statefocusNode = FocusNode();
  final FocusNode _countryfocusNode = FocusNode();

  // final texttospeechController = Get.put(TextToSpeechController());

  @override
  void initState() {
    super.initState();

    print("status id --${controller.statusId.value}");

    Timer(Duration.zero, () {
      if (widget.isEdit == true) {
        EditFunction();
      } else if (widget.isEditFromLeadGen == true) {
        EditFunction();
      } else if (widget.AddFromContacts == true) {
        print("inside----from contact");
        controller.nameController.text = widget.leadValue!.leadName ?? "";
        controller.mobileNoController.text = contactController.cleanPhoneNumber(widget.leadValue!.mobileNo ?? "");
        controller.checkLeadNumById();
      } else if (widget.editFromContacts == true) {
        editFromContactsFunction(widget.IndexOfMandatoryField ?? 0);
      } else {
        controller.checkLeadNumById();
      }
    });
  }

  @override
  void dispose() {
    _leadNamefocusNode.dispose();
    _customerNamefocusNode.dispose();
    _contactPersonNamefocusNode.dispose();
    _leadStatusfocusNode.dispose();
    _assingTofocusNode.dispose();
    _sourcefocusNode.dispose();
    _priorityfocusNode.dispose();
    _leadOwnerfocusNode.dispose();
    _leadCategoryfocusNode.dispose();
    _reasonConversionfocusNode.dispose();
    _conversionChancefocusNode.dispose();
    _areafocusNode.dispose();
    _cityfocusNode.dispose();
    _statefocusNode.dispose();
    _countryfocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _leadNamefocusNode.unfocus();
            _customerNamefocusNode.unfocus();
            _contactPersonNamefocusNode.unfocus();
            _leadStatusfocusNode.unfocus();
            _assingTofocusNode.unfocus();
            _sourcefocusNode.unfocus();
            _priorityfocusNode.unfocus();
            _conversionChancefocusNode.unfocus();
            _areafocusNode.unfocus();
            _cityfocusNode.unfocus();
            _statefocusNode.unfocus();
            _countryfocusNode.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
                title: const Text("Lead Management"),
                titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 19.sp),
                centerTitle: true,
                backgroundColor: kColorwhite,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: kColorblack,
                    size: 25.sp,
                  ),
                  onPressed: (() {
                    // Get.back();
                    widget.isFromHomeScreen == true ? Get.offAll(() => const BottomNavigationMainscreen(initialIndex: 1)) : Get.offAll(() => LeadManagementListScreen());

                    controller.leadGenerationNumController.clear();
                    controller.leadDateController.clear();
                    controller.nameController.clear();
                    controller.contactPersonController.clear();
                    controller.mobileNoController.clear();
                    controller.emailController.clear();
                    controller.addressController.clear();
                    controller.intrestedProductController.clear();
                    controller.intrestedServiceController.clear();
                    controller.statusController.clear();
                    controller.followUpDateController.clear();
                    controller.followUpTimecontroller.clear();
                    controller.amountController.clear();
                    controller.leadCommentsControler.clear();
                    controller.userCommentsController.clear();
                    controller.assignController.clear();
                    controller.sourceController.clear();
                    controller.priorityController.clear();
                    controller.conversionChanceController.clear();
                    controller.areaController.clear();
                    controller.cityController.clear();
                    controller.stateController.clear();
                    controller.countryController.clear();
                  }),
                )),
            body: Theme(
              data: ThemeData(canvasColor: kColorwhite),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Material(
                                  color: kColorwhite,
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(3.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        splashColor: kColortransparent,
                                        onTap: () {
                                          controller.isNewcustomer.value = true;
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5.w,
                                              child: Radio(
                                                value: true,
                                                activeColor: kColorlightBlue,
                                                groupValue: controller.isNewcustomer.value,
                                                onChanged: (value) {
                                                  controller.isNewcustomer.value = value!;
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text("New"),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: kColortransparent,
                                        onTap: () {
                                          controller.isNewcustomer.value = false;
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5.w,
                                              child: Radio(
                                                value: false,
                                                activeColor: kColorlightBlue,
                                                groupValue: controller.isNewcustomer.value,
                                                onChanged: (value) {
                                                  controller.isNewcustomer.value = value!;
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text("Existing"),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: kColorwhite,
                                    boxShadow: kElevationToShadow[2],
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Quick Lead",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                        ),
                                        Spacer(),
                                        Obx(() => Switch(
                                              activeColor: Colors.lightBlue,
                                              value: controller.quickLeadisSelected.value,
                                              onChanged: (value) {
                                                if (widget.AddFromContacts == true) {
                                                  controller.quickLeadisSelected.value = true;
                                                } else {
                                                  controller.quickLeadisSelected.value = value;
                                                  print("quick lead bool --${controller.quickLeadisSelected.value}");
                                                  print("status id --${controller.statusId}");
                                                }
                                              },
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  controller.quickLeadisSelected.value == true
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                widget.AddFromContacts == true
                                                    ? Expanded(
                                                        child: Obx(
                                                        () => SizedBox(
                                                            child: controller.autoNum.value == 0
                                                                ? CustomTextField(
                                                                    multilines: 1,
                                                                    height: 7.h,
                                                                    validator: (value) {
                                                                      if (value!.isEmpty) {
                                                                        return "Please enter lead no";
                                                                      }
                                                                      return null;
                                                                    },
                                                                    textInputAction: TextInputAction.next,
                                                                    obscure: false,
                                                                    enabled: widget.isEdit ? false : true,
                                                                    controller: controller.leadGenerationNumController,
                                                                    label: "Lead No*")
                                                                : SizedBox()),
                                                      ))
                                                    : Expanded(
                                                        child: CustomTextField(
                                                            multilines: 1,
                                                            height: 7.h,
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return "Please enter lead no";
                                                              }
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            enabled: widget.isEdit ? false : true,
                                                            controller: controller.leadGenerationNumController,
                                                            label: "Lead No*"),
                                                      ),
                                                Expanded(
                                                  child: CustomTextField(
                                                      multilines: 1,
                                                      suffixIcon: IconButton(
                                                          splashColor: kColortransparent,
                                                          onPressed: () {
                                                            DateClass().selectDate(controller.leadDateController, false, false);
                                                          },
                                                          icon: Icon(Icons.date_range)),
                                                      height: 7.h,
                                                      controller: controller.leadDateController,
                                                      validator: (value) {
                                                        return null;
                                                      },
                                                      textInputAction: TextInputAction.next,
                                                      obscure: false,
                                                      enabled: widget.isEdit ? false : true,
                                                      label: "Date*"),
                                                ),
                                              ],
                                            ),
                                            Obx(() {
                                              return controller.isNewcustomer.value
                                                  ? Column(
                                                      children: [
                                                        SizedBox(height: 2.h),
                                                        Text(
                                                          "*Click on the below Button to Capture or Extract details from the Business Card",
                                                          textAlign: TextAlign.right,
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox();
                                            }),
                                            Obx(() => Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                  child: controller.isNewcustomer.value
                                                      ? TypeAheadField(
                                                          // textFieldConfiguration: TextFieldConfiguration(
                                                          focusNode: _leadNamefocusNode,
                                                          controller: controller.nameController,
                                                          builder: (context, leadNamecontrollers, LeadNamefocusNode) {
                                                            return TextFormField(
                                                              controller: leadNamecontrollers,
                                                              focusNode: LeadNamefocusNode,
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return controller.nameList.isNotEmpty ? "Please Select or Enter Lead Name" : "Please Enter Lead Name";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: InputDecoration(
                                                                  suffixIcon: CircleAvatar(
                                                                    backgroundColor: kColorlightBlue300,
                                                                    child: IconButton(
                                                                        onPressed: () async {
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return AlertDialog(
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                                title: Text('Upload the Card!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                content: SizedBox(
                                                                                  width: 100.w,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () async {
                                                                                          final imgPath = await controller.obtainImage(source: ImageSource.gallery);
                                                                                          print(imgPath);

                                                                                          if (imgPath != null) {
                                                                                            controller.processImage(imgPath: imgPath);
                                                                                          }
                                                                                          Get.back();
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 6.h,
                                                                                          width: 30.w,
                                                                                          decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            "Gallery",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                      GestureDetector(
                                                                                        onTap: () async {
                                                                                          final imgPath = await controller.obtainImage(source: ImageSource.camera);
                                                                                          print(imgPath);

                                                                                          if (imgPath != null) {
                                                                                            controller.processImage(imgPath: imgPath);
                                                                                          }
                                                                                          Get.back();
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 6.h,
                                                                                          width: 30.w,
                                                                                          decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            "Camera",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        icon: Icon(
                                                                          Icons.qr_code_scanner,
                                                                          color: kColorwhite,
                                                                        )),
                                                                  ),
                                                                  label: Text("Lead Name*")),
                                                            );
                                                          },
                                                          // ),
                                                          itemBuilder: (context, itemData) {
                                                            return ListTile(
                                                              title: Text(itemData),
                                                            );
                                                          },
                                                          emptyBuilder: (context) {
                                                            return SizedBox();
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.nameList.toList();
                                                          },
                                                          onSelected: (suggestion) {
                                                            print("suggestion --$suggestion");
                                                            controller.nameController.text = suggestion;
                                                          },
                                                        )
                                                      : TypeAheadField<CustomerModel?>(
                                                          debounceDuration: Duration(milliseconds: 500),
                                                          controller: controller.nameController,
                                                          focusNode: _customerNamefocusNode,
                                                          suggestionsCallback: (search) => controller.getCustomerList(search),
                                                          builder: (context, fieldController, fieldFocusNode) {
                                                            return TextFormField(
                                                              controller: fieldController,
                                                              focusNode: fieldFocusNode,
                                                              decoration: InputDecoration(
                                                                labelText: "Customer Name",
                                                                hintText: "Start Typing to search for customer",
                                                              ),
                                                            );
                                                          },
                                                          itemBuilder: (context, suggestion) {
                                                            if (suggestion == null) return SizedBox();
                                                            return ListTile(title: Text(suggestion.name ?? "No Name"));
                                                          },
                                                          loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
                                                          emptyBuilder: (context) => Center(child: Text("No Customer Found")),
                                                          onSelected: (suggestion) {
                                                            if (suggestion == null) return;
                                                            controller.selectedCustomerValue = suggestion;
                                                            controller.nameController.text = suggestion.name ?? '';
                                                            controller.addressController.text = suggestion.address ?? '';
                                                            _customerNamefocusNode.unfocus();
                                                          },
                                                        ),
                                                )),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: TypeAheadField(
                                                autoFlipDirection: true,
                                                focusNode: _leadOwnerfocusNode,
                                                controller: controller.leadOwnerController,
                                                itemBuilder: (context, UserModel itemData) {
                                                  return ListTile(
                                                    title: Text(itemData.name!),
                                                  );
                                                },
                                                suggestionsCallback: (pattern) {
                                                  return controller.userList
                                                      .where(
                                                        (element) => element.id != 9999,
                                                      )
                                                      .toList();
                                                },
                                                builder: (context, controllers, fieldFocusNode) {
                                                  return TextFormField(
                                                    readOnly: true,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please Select Lead Owner";
                                                      }
                                                      return null;
                                                    },
                                                    controller: controllers,
                                                    focusNode: fieldFocusNode,
                                                    decoration: InputDecoration(
                                                      labelText: "Lead Owner*",
                                                    ),
                                                  );
                                                },
                                                onSelected: (suggestion) {
                                                  controller.selectedUserValue = suggestion;
                                                  controller.leadOwnerController.text = suggestion.name!;

                                                  print(suggestion.id);
                                                },
                                              ),
                                            ),

                                            CustomTextField(
                                                multilines: null,
                                                height: 7.h,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "Please Enter Mobile No";
                                                  } else if (!Validate().validateMobile(value)) {
                                                    return "Please Enter Valid Mobile Number";
                                                  }
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                textInputType: TextInputType.phone,
                                                controller: controller.mobileNoController,
                                                label: "Mobile Number*"),

                                            CustomTextField(
                                                multilines: null,
                                                height: 7.h,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Company Name";
                                                  }
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                textInputType: TextInputType.emailAddress,
                                                controller: controller.companyNameController,
                                                label: "Company Name*"),

                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: TypeAheadField(
                                                autoFlipDirection: true,
                                                focusNode: _leadStatusfocusNode,
                                                controller: controller.statusController,
                                                itemBuilder: (context, StatusModel itemData) {
                                                  return ListTile(
                                                    title: Text(itemData.name!),
                                                  );
                                                },
                                                suggestionsCallback: (pattern) {
                                                  return controller.statusList;
                                                },
                                                builder: (context, controllers, fieldFocusNode) {
                                                  return TextFormField(
                                                    readOnly: true,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please Select Lead Status";
                                                      }
                                                      return null;
                                                    },
                                                    controller: controllers,
                                                    focusNode: fieldFocusNode,
                                                    decoration: InputDecoration(
                                                      labelText: "Lead Status*",
                                                      suffixIcon: Icon(Icons.list),
                                                    ),
                                                  );
                                                },
                                                onSelected: (suggestion) {
                                                  controller.selectedStatusValue = suggestion;
                                                  controller.statusController.text = suggestion.name!;
                                                  controller.statusId.value = suggestion.id ?? 0;
                                                  if (suggestion.id != 0 || suggestion.id != 176) {
                                                    controller.followUpDateController.clear();
                                                  }
                                                  print(controller.statusId.value);
                                                },
                                              ),
                                            ),

                                            (controller.statusId.value == 0 || controller.statusId.value == 176)
                                                ? SizedBox()
                                                : Column(
                                                    children: [
                                                      CustomTextField(
                                                          ontap: () {
                                                            DateClass().selectDate(controller.followUpDateController, false, true);
                                                          },
                                                          multilines: 1,
                                                          height: 6.h,
                                                          // enabled: false,
                                                          readonly: true,
                                                          suffixIcon: IconButton(
                                                              splashColor: kColortransparent,
                                                              onPressed: () {
                                                                DateClass().selectDate(controller.followUpDateController, false, true);
                                                              },
                                                              icon: Icon(Icons.date_range)),
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return "Please enter Follow up date";
                                                            }
                                                            return null;
                                                          },
                                                          textInputAction: TextInputAction.next,
                                                          obscure: false,
                                                          controller: controller.followUpDateController,
                                                          label: "FollowUp Date"),
                                                    ],
                                                  ),
                                            GestureDetector(
                                              onTap: () {
                                                _showBottomTimePicker(context, controller.followUpTimecontroller, "Select the Follow Up Time", true);
                                              },
                                              child: CustomTextField(
                                                  readonly: true,
                                                  suffixIcon: IconButton(
                                                      onPressed: () {
                                                        _showBottomTimePicker(context, controller.followUpTimecontroller, "Select the Follow Up Time", true);
                                                      },
                                                      icon: Icon(Icons.watch_later_outlined)),
                                                  multilines: 1,
                                                  height: 6.h,
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  textInputAction: TextInputAction.next,
                                                  obscure: false,
                                                  controller: controller.followUpTimecontroller,
                                                  label: "Follow Up Time"),
                                            ),

                                            if (controller.statusId.value == 178)
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                child: TypeAheadField(
                                                  autoFlipDirection: true,
                                                  focusNode: _reasonConversionfocusNode,
                                                  controller: controller.notConvertedReasonController,
                                                  itemBuilder: (context, IndustrySegmentModel itemData) {
                                                    return ListTile(
                                                      title: Text(itemData.name!),
                                                    );
                                                  },
                                                  builder: (context, notConvertedcontrollers, notConvertedfocusNode) {
                                                    return TextFormField(
                                                      readOnly: true,
                                                      focusNode: notConvertedfocusNode,
                                                      controller: notConvertedcontrollers,
                                                      decoration: InputDecoration(
                                                        suffixIcon: Icon(Icons.list),
                                                        labelText: "Not Converted Reason",
                                                      ),
                                                    );
                                                  },
                                                  suggestionsCallback: (pattern) {
                                                    return controller.reasonConversionList;
                                                  },
                                                  onSelected: (suggestion) {
                                                    controller.selectedReasonConversionValue = suggestion;
                                                    controller.notConvertedReasonController.text = suggestion.name!;

                                                    print(suggestion.id);
                                                  },
                                                ),
                                              ),

                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: TypeAheadField(
                                                autoFlipDirection: true,
                                                focusNode: _industrySegmentfocusNode,
                                                controller: controller.industrySegmentController,
                                                builder: (context, indsutSegcontrollers, indusSegfocusNode) {
                                                  return TextFormField(
                                                    readOnly: true,
                                                    focusNode: indusSegfocusNode,
                                                    controller: indsutSegcontrollers,
                                                    decoration: InputDecoration(
                                                      suffixIcon: Icon(Icons.list),
                                                      labelText: "Insustry Segment",
                                                    ),
                                                  );
                                                },
                                                // decoration: InputDecoration(
                                                //   suffixIcon: Icon(Icons.list),
                                                //   label: Text("Industry Segment"),
                                                // )),
                                                itemBuilder: (context, IndustrySegmentModel itemData) {
                                                  return ListTile(
                                                    title: Text(itemData.name!),
                                                  );
                                                },
                                                suggestionsCallback: (pattern) {
                                                  return controller.industrySegmentList;
                                                },
                                                onSelected: (suggestion) {
                                                  controller.selectedindusSegmentValue = suggestion;
                                                  controller.industrySegmentController.text = suggestion.name!;

                                                  print(suggestion.id);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: TypeAheadField(
                                                autoFlipDirection: true,
                                                focusNode: _leadCategoryfocusNode,
                                                controller: controller.categoryController,
                                                builder: (context, categorycontrollers, categoryfocusNode) {
                                                  return TextFormField(
                                                    readOnly: true,
                                                    focusNode: categoryfocusNode,
                                                    controller: categorycontrollers,
                                                    decoration: InputDecoration(
                                                      suffixIcon: Icon(Icons.list),
                                                      labelText: "Lead Category",
                                                    ),
                                                  );
                                                },
                                                itemBuilder: (context, IndustrySegmentModel itemData) {
                                                  return ListTile(
                                                    title: Text(itemData.name!),
                                                  );
                                                },
                                                suggestionsCallback: (pattern) {
                                                  return controller.leadCategoryList;
                                                },
                                                onSelected: (suggestion) {
                                                  controller.selectedCategoryuValue = suggestion;
                                                  controller.categoryController.text = suggestion.name!;

                                                  print(suggestion.id);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: TypeAheadField(
                                                focusNode: _sourcefocusNode,
                                                controller: controller.sourceController,
                                                builder: (context, sourcecontrollers, sourcefocusNode) {
                                                  return TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please Select Lead Source";
                                                      }
                                                      return null;
                                                    },
                                                    readOnly: true,
                                                    focusNode: sourcefocusNode,
                                                    controller: sourcecontrollers,
                                                    decoration: InputDecoration(
                                                      suffixIcon: Icon(Icons.list),
                                                      labelText: "Lead Source*",
                                                    ),
                                                  );
                                                },
                                                itemBuilder: (context, NameIdModel itemData) {
                                                  return ListTile(
                                                    title: Text(itemData.name!),
                                                  );
                                                },
                                                suggestionsCallback: (pattern) {
                                                  return controller.sourceList;
                                                },
                                                onSelected: (suggestion) {
                                                  controller.selectedSourceValue = suggestion;

                                                  controller.sourceController.text = suggestion.name!;
                                                  print(suggestion.id);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: TextFormField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                onTap: () {
                                                  controller.filteredItems.assignAll(widget.materialList);

                                                  _showInterestProductBottomSheet(context: context, isMaterial: true, materialList: widget.materialList, serviceList: widget.serviceList);
                                                },
                                                readOnly: true, // Make the text field non-editable

                                                enableInteractiveSelection: false,
                                                controller: controller.intrestedProductController,
                                                decoration: InputDecoration(
                                                  suffixIcon: Icon(
                                                    Icons.list,
                                                    color: Colors.blue,
                                                  ),
                                                  labelText: 'Interested product',
                                                ),
                                                style: TextStyle(overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: TextFormField(
                                                validator: (value) {
                                                  return null;
                                                },
                                                onTap: () {
                                                  controller.filteredItems.assignAll(widget.serviceList);
                                                  _showInterestProductBottomSheet(context: context, isMaterial: false, materialList: widget.materialList, serviceList: widget.serviceList);
                                                },
                                                readOnly: true, // Make the text field non-editable

                                                enableInteractiveSelection: false,
                                                controller: controller.intrestedServiceController,
                                                decoration: InputDecoration(
                                                  suffixIcon: Icon(
                                                    Icons.list,
                                                    color: Colors.blue,
                                                  ),
                                                  labelText: 'Interested Services',
                                                ),
                                                style: TextStyle(overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                            CustomTextField(
                                                multilines: null,
                                                height: 7.h,
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                textInputType: TextInputType.emailAddress,
                                                controller: controller.leadDescriptionController,
                                                label: "Lead Description"),
                                            CustomTextField(
                                                multilines: null,
                                                height: 7.h,
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                textInputType: TextInputType.emailAddress,
                                                controller: controller.contactPersonController,
                                                label: "Contact Person Name"),

                                            // Padding(
                                            //   padding: EdgeInsets.symmetric(horizontal: 2.w),
                                            //   child: TypeAheadField(
                                            //     validator: (value) {
                                            //       return null;
                                            //     },
                                            //     hideKeyboard: true,
                                            //     autoFlipDirection: true,
                                            //     textFieldConfiguration: TextFieldConfiguration(
                                            //         focusNode: _designationfocusNode,
                                            //         controller: controller.designationController,
                                            //         decoration: InputDecoration(
                                            //           suffixIcon: Icon(Icons.list),
                                            //           label: Text("Designation"),
                                            //         )),
                                            //     itemBuilder: (context, LeadDesignationModel itemData) {
                                            //       return ListTile(
                                            //         title: Text(itemData.designationName ?? ""),
                                            //       );
                                            //     },
                                            //     suggestionsCallback: (pattern) {
                                            //       return controller.leadDesignationList;
                                            //     },
                                            //     onSelected: (suggestion) {
                                            //       controller.selectedDesignationValue = suggestion;
                                            //       controller.designationController.text = suggestion.designationName!;

                                            //       print(suggestion.id);
                                            //     },
                                            //   ),
                                            // ),
                                            // CustomTextField(
                                            //     multilines: null,
                                            //     height: 7.h,
                                            //     validator: (value) {
                                            //       return null;
                                            //     },
                                            //     textInputAction: TextInputAction.next,
                                            //     obscure: false,
                                            //     textInputType: TextInputType.emailAddress,
                                            //     controller: controller.designationController,
                                            //     label: "Designation"),
                                            CustomTextField(
                                                multilines: null,
                                                height: 7.h,
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                textInputType: TextInputType.emailAddress,
                                                controller: controller.emailController,
                                                label: "Email Address"),
                                            CustomTextField(
                                                multilines: null,
                                                maxLength: 2500,
                                                // height: 6.h,
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                controller: controller.internalCommentsControler,
                                                label: "Internal comment"),
                                            CustomTextField(
                                                multilines: null,
                                                maxLength: 2500,
                                                // height: 6.h,
                                                validator: (value) {
                                                  return null;
                                                },
                                                textInputAction: TextInputAction.next,
                                                obscure: false,
                                                controller: controller.leadCommentsControler,
                                                label: "Lead comment"),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Obx(
                                              () => InkWell(
                                                hoverColor: kColortransparent,
                                                onTap: () {
                                                  controller.isGeneralInfoSelected.value = !controller.isGeneralInfoSelected.value;

                                                  Timer(Duration(milliseconds: 300), () {
                                                    if (controller.isGeneralInfoSelected.value == true) {
                                                      // Scroll to reveal the hidden widgets
                                                      _scrollController.animateTo(
                                                        _scrollController.offset + 500,
                                                        duration: Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(3.w),
                                                      margin: EdgeInsets.all(1.w),
                                                      // decoration: BoxDecoration(
                                                      //     border: controller.isGeneralInfoSelected.value == true ? Border.all(color: kColorlightBlue) : null,
                                                      //     borderRadius: BorderRadius.circular(2.w),
                                                      //     boxShadow: kElevationToShadow[2],
                                                      //     color: kColorwhite),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Icon(
                                                            Icons.info_outline_rounded,
                                                            color: controller.isGeneralInfoSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                          ),
                                                          SizedBox(
                                                            width: 1.h,
                                                          ),
                                                          Text(
                                                            "General Information",
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                color: controller.isGeneralInfoSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          // SizedBox(
                                                          //   width: 2.w,
                                                          // ),
                                                          Spacer(),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                border: controller.isGeneralInfoSelected.value == true ? Border.all(color: kColorlightBlue) : null,
                                                                borderRadius: BorderRadius.circular(2.w),
                                                                boxShadow: kElevationToShadow[2],
                                                                color: kColorwhite),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(1.0),
                                                              child: Icon(
                                                                controller.isGeneralInfoSelected.value ? Icons.remove : Icons.add,
                                                                color: controller.isGeneralInfoSelected.value == true ? Colors.blue : Colors.indigo,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: controller.isGeneralInfoSelected.value == false ? 0.2.h : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(() => Visibility(
                                                  visible: controller.isGeneralInfoSelected.value,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          widget.AddFromContacts == true
                                                              ? Expanded(
                                                                  child: Obx(
                                                                  () => SizedBox(
                                                                      child: controller.autoNum.value == 0
                                                                          ? CustomTextField(
                                                                              multilines: 1,
                                                                              height: 7.h,
                                                                              validator: (value) {
                                                                                if (value!.isEmpty) {
                                                                                  return "Please enter lead no";
                                                                                }
                                                                                return null;
                                                                              },
                                                                              textInputAction: TextInputAction.next,
                                                                              obscure: false,
                                                                              enabled: widget.isEdit ? false : true,
                                                                              controller: controller.leadGenerationNumController,
                                                                              label: "Lead No*")
                                                                          : SizedBox()),
                                                                ))
                                                              : Expanded(
                                                                  child: CustomTextField(
                                                                      multilines: 1,
                                                                      height: 7.h,
                                                                      validator: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return "Please enter lead no";
                                                                        }
                                                                        return null;
                                                                      },
                                                                      textInputAction: TextInputAction.next,
                                                                      obscure: false,
                                                                      enabled: widget.isEdit ? false : true,
                                                                      controller: controller.leadGenerationNumController,
                                                                      label: "Lead No*"),
                                                                ),
                                                          Expanded(
                                                            child: CustomTextField(
                                                                validator: (value) {
                                                                  return null;
                                                                },
                                                                multilines: 1,
                                                                suffixIcon: IconButton(
                                                                    splashColor: kColortransparent,
                                                                    onPressed: () {
                                                                      DateClass().selectDate(controller.leadDateController, false, false);
                                                                    },
                                                                    icon: Icon(Icons.date_range)),
                                                                height: 7.h,
                                                                controller: controller.leadDateController,
                                                                textInputAction: TextInputAction.next,
                                                                obscure: false,
                                                                enabled: widget.isEdit ? false : true,
                                                                label: "Date*"),
                                                          ),
                                                        ],
                                                      ),
                                                      Obx(() {
                                                        return controller.isNewcustomer.value
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(height: 2.h),
                                                                  Text(
                                                                    "*Click on the below Button to Capture or Extract details from the Business Card",
                                                                    textAlign: TextAlign.right,
                                                                  )
                                                                ],
                                                              )
                                                            : SizedBox();
                                                      }),
                                                      Obx(() => Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                            child: controller.isNewcustomer.value
                                                                ? TypeAheadField(
                                                                    focusNode: _leadNamefocusNode,
                                                                    controller: controller.nameController,
                                                                    builder: (context, leadNamecontrollers, leadNamefocusNode) {
                                                                      return TextFormField(
                                                                          controller: leadNamecontrollers,
                                                                          focusNode: leadNamefocusNode,
                                                                          validator: (value) {
                                                                            if (value!.isEmpty) {
                                                                              return controller.nameList.isNotEmpty ? "Please Select or Enter Lead Name" : "Please Enter Lead Name";
                                                                            }
                                                                            return null;
                                                                          },
                                                                          decoration: InputDecoration(
                                                                              suffixIcon: CircleAvatar(
                                                                                backgroundColor: kColorlightBlue300,
                                                                                child: IconButton(
                                                                                    onPressed: () async {
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return AlertDialog(
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                                            title: Text('Upload the Card!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                            content: SizedBox(
                                                                                              width: 100.w,
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                children: [
                                                                                                  GestureDetector(
                                                                                                    onTap: () async {
                                                                                                      final imgPath = await controller.obtainImage(source: ImageSource.gallery);
                                                                                                      print(imgPath);

                                                                                                      if (imgPath != null) {
                                                                                                        controller.processImage(imgPath: imgPath);
                                                                                                      }
                                                                                                      Get.back();
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 6.h,
                                                                                                      width: 30.w,
                                                                                                      decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "Gallery",
                                                                                                        style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ),
                                                                                                  GestureDetector(
                                                                                                    onTap: () async {
                                                                                                      final imgPath = await controller.obtainImage(source: ImageSource.camera);
                                                                                                      print(imgPath);

                                                                                                      if (imgPath != null) {
                                                                                                        controller.processImage(imgPath: imgPath);
                                                                                                      }
                                                                                                      Get.back();
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 6.h,
                                                                                                      width: 30.w,
                                                                                                      decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "Camera",
                                                                                                        style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    icon: Icon(
                                                                                      Icons.qr_code_scanner,
                                                                                      color: kColorwhite,
                                                                                    )),
                                                                              ),
                                                                              labelText: "Lead Name"));
                                                                    },
                                                                    itemBuilder: (context, itemData) {
                                                                      return ListTile(
                                                                        title: Text(itemData),
                                                                      );
                                                                    },
                                                                    emptyBuilder: (context) {
                                                                      return SizedBox();
                                                                    },
                                                                    suggestionsCallback: (pattern) {
                                                                      return controller.nameList.toList();
                                                                    },
                                                                    onSelected: (suggestion) {
                                                                      controller.nameController.text = suggestion;
                                                                    },
                                                                  )
                                                                : TypeAheadField<CustomerModel?>(
                                                                    debounceDuration: Duration(milliseconds: 500),
                                                                    controller: controller.nameController,
                                                                    focusNode: _customerNamefocusNode,
                                                                    suggestionsCallback: (search) => controller.getCustomerList(search),
                                                                    builder: (context, fieldController, fieldFocusNode) {
                                                                      return TextFormField(
                                                                        controller: fieldController,
                                                                        focusNode: fieldFocusNode,
                                                                        decoration: InputDecoration(
                                                                          labelText: "Customer Name",
                                                                          suffixIcon: Icon(Icons.list),
                                                                          hintText: "Start Typing to search for customer",
                                                                        ),
                                                                      );
                                                                    },
                                                                    itemBuilder: (context, suggestion) {
                                                                      if (suggestion == null) return SizedBox();
                                                                      return ListTile(title: Text(suggestion.name ?? "No Name"));
                                                                    },
                                                                    loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
                                                                    emptyBuilder: (context) => Center(child: Text("No Customer Found")),
                                                                    onSelected: (suggestion) {
                                                                      if (suggestion == null) return;
                                                                      controller.selectedCustomerValue = suggestion;
                                                                      controller.nameController.text = suggestion.name ?? '';
                                                                      controller.addressController.text = suggestion.address ?? '';
                                                                      _customerNamefocusNode.unfocus();
                                                                    },
                                                                  ),
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          autoFlipDirection: true,
                                                          hideOnSelect: true,
                                                          focusNode: _leadOwnerfocusNode,
                                                          controller: controller.leadOwnerController,
                                                          itemBuilder: (context, UserModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          builder: (context, controllers, fieldFocusNode) {
                                                            return TextFormField(
                                                              readOnly: true,
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return "Please Select Lead Owner";
                                                                }
                                                                return null;
                                                              },
                                                              controller: controllers,
                                                              focusNode: fieldFocusNode,
                                                              decoration: InputDecoration(
                                                                labelText: "Lead Owner*",
                                                              ),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.userList
                                                                .where(
                                                                  (element) => element.id != 9999,
                                                                )
                                                                .toList();
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedUserValue = suggestion;
                                                            controller.leadOwnerController.text = suggestion.name!;
                                                            // _leadOwnerfocusNode.unfocus();

                                                            print(suggestion.id);
                                                          },
                                                        ),
                                                      ),
                                                      CustomTextField(
                                                          multilines: null,
                                                          height: 7.h,
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return "Please enter Company Name";
                                                            }
                                                            return null;
                                                          },
                                                          textInputAction: TextInputAction.next,
                                                          obscure: false,
                                                          textInputType: TextInputType.emailAddress,
                                                          controller: controller.companyNameController,
                                                          label: "Company Name*"),
                                                      CustomTextField(
                                                          multilines: 1,
                                                          height: 6.h,
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "Please Enter Mobile No";
                                                            } else if (!Validate().validateMobile(value)) {
                                                              return "Please Enter Valid Mobile Number";
                                                            }

                                                            return null;
                                                          },
                                                          textInputAction: TextInputAction.next,
                                                          obscure: false,
                                                          textInputType: TextInputType.phone,
                                                          controller: controller.mobileNoController,
                                                          label: "Mobile Number*"),
                                                      CustomTextField(
                                                        multilines: null,
                                                        height: 7.h,
                                                        textInputAction: TextInputAction.next,
                                                        obscure: false,
                                                        suffixIcon: Icon(Icons.currency_rupee),
                                                        textInputType: TextInputType.number,
                                                        controller: controller.amountController,
                                                        label: "Lead Amount",
                                                        validator: (value) {
                                                          return null;
                                                        },
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          autoFlipDirection: true,
                                                          focusNode: _leadStatusfocusNode,
                                                          controller: controller.statusController,
                                                          itemBuilder: (context, StatusModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.statusList;
                                                          },
                                                          builder: (context, controllers, fieldFocusNode) {
                                                            return TextFormField(
                                                              readOnly: true,
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return "Please Select Lead Status";
                                                                }
                                                                return null;
                                                              },
                                                              controller: controllers,
                                                              focusNode: fieldFocusNode,
                                                              decoration: InputDecoration(
                                                                labelText: "Lead Status*",
                                                                suffixIcon: Icon(Icons.list),
                                                              ),
                                                            );
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedStatusValue = suggestion;
                                                            controller.statusController.text = suggestion.name!;
                                                            controller.statusId.value = suggestion.id!;
                                                            if (suggestion.id != 0 || suggestion.id != 176) {
                                                              controller.followUpDateController.clear();
                                                            }
                                                            print(suggestion.id);
                                                          },
                                                        ),
                                                      ),
                                                      (controller.statusId.value == 0 || controller.statusId.value == 176)
                                                          ? SizedBox()
                                                          : Column(
                                                              children: [
                                                                CustomTextField(
                                                                    ontap: () {
                                                                      DateClass().selectDate(controller.followUpDateController, false, true);
                                                                    },
                                                                    multilines: 1,
                                                                    height: 6.h,
                                                                    // enabled: false,
                                                                    readonly: true,
                                                                    suffixIcon: IconButton(
                                                                        splashColor: kColortransparent,
                                                                        onPressed: () {
                                                                          DateClass().selectDate(controller.followUpDateController, false, true);
                                                                        },
                                                                        icon: Icon(Icons.date_range)),
                                                                    validator: (value) {
                                                                      if (value!.isEmpty) {
                                                                        return "Please Select Date";
                                                                      }
                                                                      return null;
                                                                    },
                                                                    textInputAction: TextInputAction.next,
                                                                    obscure: false,
                                                                    controller: controller.followUpDateController,
                                                                    label: "FollowUp Date*"),
                                                              ],
                                                            ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          autoFlipDirection: true,
                                                          focusNode: _assingTofocusNode,
                                                          controller: controller.assignController,
                                                          builder: (context, assignTocontrollers, assignTofocusNode) {
                                                            return TextFormField(
                                                              readOnly: true,
                                                              focusNode: assignTofocusNode,
                                                              controller: assignTocontrollers,
                                                              decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.list),
                                                                labelText: "Assign To",
                                                              ),
                                                            );
                                                          },
                                                          itemBuilder: (context, UserModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.userList
                                                                .where(
                                                                  (element) => element.id != 9999,
                                                                )
                                                                .toList();
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedUserValue = suggestion;

                                                            controller.assignController.text = suggestion.name!;
                                                          },
                                                        ),
                                                      ),
                                                      controller.statusController.text == "Not Converted"
                                                          ? Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                              child: TypeAheadField(
                                                                autoFlipDirection: true,
                                                                focusNode: _reasonConversionfocusNode,
                                                                controller: controller.notConvertedReasonController,
                                                                itemBuilder: (context, IndustrySegmentModel itemData) {
                                                                  return ListTile(
                                                                    title: Text(itemData.name!),
                                                                  );
                                                                },
                                                                builder: (context, notConveretdcontrollers, notConvertedfocusNode) {
                                                                  return TextFormField(
                                                                    readOnly: true,
                                                                    focusNode: notConvertedfocusNode,
                                                                    controller: notConveretdcontrollers,
                                                                    decoration: InputDecoration(
                                                                      suffixIcon: Icon(Icons.list),
                                                                      labelText: "Not Converted Reason",
                                                                    ),
                                                                  );
                                                                },
                                                                suggestionsCallback: (pattern) {
                                                                  return controller.reasonConversionList;
                                                                },
                                                                onSelected: (suggestion) {
                                                                  controller.selectedReasonConversionValue = suggestion;
                                                                  controller.notConvertedReasonController.text = suggestion.name!;

                                                                  print(suggestion.id);
                                                                },
                                                              ),
                                                            )
                                                          : SizedBox.shrink(),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          autoFlipDirection: true,
                                                          focusNode: _industrySegmentfocusNode,
                                                          controller: controller.industrySegmentController,
                                                          builder: (context, indsutSegcontrollers, indusSegfocusNode) {
                                                            return TextFormField(
                                                              readOnly: true,
                                                              focusNode: indusSegfocusNode,
                                                              controller: indsutSegcontrollers,
                                                              decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.list),
                                                                labelText: "Insustry Segment",
                                                              ),
                                                            );
                                                          },
                                                          itemBuilder: (context, IndustrySegmentModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.industrySegmentList;
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedindusSegmentValue = suggestion;
                                                            controller.industrySegmentController.text = suggestion.name!;

                                                            print(suggestion.id);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          focusNode: _priorityfocusNode,
                                                          builder: (context, prioritycontrollers, priorityfocusNode) {
                                                            return TextFormField(
                                                              readOnly: true,
                                                              focusNode: priorityfocusNode,
                                                              controller: prioritycontrollers,
                                                              decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.list),
                                                                labelText: "Lead Priority",
                                                              ),
                                                            );
                                                          },
                                                          controller: controller.priorityController,
                                                          itemBuilder: (context, NameIdModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.priorityList;
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedPriorityValue = suggestion;

                                                            controller.priorityController.text = suggestion.name!;
                                                            print(suggestion.id);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          focusNode: _conversionChancefocusNode,
                                                          builder: (context, converChancecontrollers, converseChancefocusNode) {
                                                            return TextFormField(
                                                              readOnly: true,
                                                              focusNode: converseChancefocusNode,
                                                              controller: converChancecontrollers,
                                                              decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.list),
                                                                labelText: "Conversion Chance",
                                                              ),
                                                            );
                                                          },
                                                          controller: controller.conversionChanceController,
                                                          itemBuilder: (context, NameIdModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.conversionChanceList;
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedConversionChanceValue = suggestion;

                                                            controller.conversionChanceController.text = suggestion.name!;
                                                            print(suggestion.id);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          autoFlipDirection: true,
                                                          focusNode: _leadCategoryfocusNode,
                                                          controller: controller.categoryController,
                                                          builder: (context, categorycontrollers, categoryfocusNode) {
                                                            return TextFormField(
                                                              readOnly: true,
                                                              focusNode: categoryfocusNode,
                                                              controller: categorycontrollers,
                                                              decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.list),
                                                                labelText: "Lead Category",
                                                              ),
                                                            );
                                                          },
                                                          itemBuilder: (context, IndustrySegmentModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.leadCategoryList;
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedCategoryuValue = suggestion;
                                                            controller.categoryController.text = suggestion.name!;

                                                            print(suggestion.id);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TextFormField(
                                                          onTap: () {
                                                            controller.filteredItems.assignAll(widget.materialList);

                                                            _showInterestProductBottomSheet(context: context, isMaterial: true, materialList: widget.materialList, serviceList: widget.serviceList);
                                                          },
                                                          readOnly: true, // Make the text field non-editable

                                                          enableInteractiveSelection: false,
                                                          controller: controller.intrestedProductController,
                                                          decoration: InputDecoration(
                                                            suffixIcon: Icon(
                                                              Icons.list,
                                                              color: Colors.blue,
                                                            ),
                                                            labelText: 'Interested product',
                                                          ),
                                                          style: TextStyle(overflow: TextOverflow.ellipsis),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TextFormField(
                                                          onTap: () {
                                                            controller.filteredItems.assignAll(widget.serviceList);
                                                            _showInterestProductBottomSheet(context: context, isMaterial: false, materialList: widget.materialList, serviceList: widget.serviceList);
                                                          },
                                                          readOnly: true, // Make the text field non-editable

                                                          enableInteractiveSelection: false,
                                                          controller: controller.intrestedServiceController,
                                                          decoration: InputDecoration(
                                                            suffixIcon: Icon(
                                                              Icons.list,
                                                              color: Colors.blue,
                                                            ),
                                                            labelText: 'Interested Services',
                                                          ),
                                                          style: TextStyle(overflow: TextOverflow.ellipsis),
                                                        ),
                                                      ),
                                                      CustomTextField(
                                                          validator: (value) {
                                                            return null;
                                                          },
                                                          multilines: null,
                                                          height: 7.h,
                                                          textInputAction: TextInputAction.next,
                                                          obscure: false,
                                                          textInputType: TextInputType.emailAddress,
                                                          controller: controller.leadDescriptionController,
                                                          label: "Lead Description"),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        child: TypeAheadField(
                                                          focusNode: _sourcefocusNode,
                                                          controller: controller.sourceController,
                                                          builder: (context, sourcecontrollers, sourcefocusNode) {
                                                            return TextFormField(
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return "Please Select Lead Source";
                                                                }
                                                                return null;
                                                              },
                                                              readOnly: true,
                                                              focusNode: sourcefocusNode,
                                                              controller: sourcecontrollers,
                                                              decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.list),
                                                                labelText: "Lead Source*",
                                                              ),
                                                            );
                                                          },
                                                          itemBuilder: (context, NameIdModel itemData) {
                                                            return ListTile(
                                                              title: Text(itemData.name!),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) {
                                                            return controller.sourceList;
                                                          },
                                                          onSelected: (suggestion) {
                                                            controller.selectedSourceValue = suggestion;

                                                            controller.sourceController.text = suggestion.name!;
                                                            print(suggestion.id);
                                                          },
                                                        ),
                                                      ),
                                                      CustomTextField(
                                                          validator: (value) {
                                                            return null;
                                                          },
                                                          multilines: null,
                                                          height: 7.h,
                                                          textInputAction: TextInputAction.next,
                                                          obscure: false,
                                                          textInputType: TextInputType.emailAddress,
                                                          controller: controller.referralNameController,
                                                          label: "Referral Name"),
                                                      SizedBox(
                                                        height: 1.5.h,
                                                      )
                                                    ],
                                                  ),
                                                )),
                                            Obx(
                                              () => InkWell(
                                                hoverColor: kColortransparent,
                                                onTap: () {
                                                  controller.isContactInfoSelected.value = !controller.isContactInfoSelected.value;

                                                  Timer(Duration(milliseconds: 300), () {
                                                    if (controller.isContactInfoSelected.value == true) {
                                                      // Scroll to reveal the hidden widgets
                                                      _scrollController.animateTo(
                                                        _scrollController.offset + 500,
                                                        duration: Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(3.w),
                                                      margin: EdgeInsets.all(1.w),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Icon(
                                                            Icons.contacts,
                                                            color: controller.isContactInfoSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                          ),
                                                          SizedBox(
                                                            width: 1.h,
                                                          ),
                                                          Text(
                                                            "Contact Information",
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                color: controller.isContactInfoSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                border: controller.isContactInfoSelected.value == true ? Border.all(color: kColorlightBlue) : null,
                                                                borderRadius: BorderRadius.circular(2.w),
                                                                boxShadow: kElevationToShadow[2],
                                                                color: kColorwhite),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(1.0),
                                                              child: Icon(
                                                                controller.isContactInfoSelected.value ? Icons.remove : Icons.add,
                                                                color: controller.isContactInfoSelected.value == true ? Colors.blue : Colors.indigo,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: controller.isContactInfoSelected.value == false ? 0.2.h : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(() => Visibility(
                                                  visible: controller.isContactInfoSelected.value,
                                                  child: Container(
                                                    margin: EdgeInsets.only(bottom: 1.h),
                                                    decoration: BoxDecoration(color: kColorwhite, borderRadius: BorderRadius.circular(4.w)),
                                                    child: Column(
                                                      children: [
                                                        CustomTextField(
                                                            multilines: null,
                                                            height: 7.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            textInputType: TextInputType.emailAddress,
                                                            controller: controller.contactPersonController,
                                                            label: "Contact Person Name"),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                          child: TypeAheadField(
                                                            autoFlipDirection: true,
                                                            focusNode: _designationfocusNode,
                                                            controller: controller.designationController,
                                                            builder: (context, designationcontrollers, designationfocusNode) {
                                                              return TextFormField(
                                                                readOnly: true,
                                                                focusNode: designationfocusNode,
                                                                controller: designationcontrollers,
                                                                decoration: InputDecoration(
                                                                  suffixIcon: Icon(Icons.list),
                                                                  labelText: "Designation",
                                                                ),
                                                              );
                                                            },
                                                            itemBuilder: (context, LeadDesignationModel itemData) {
                                                              return ListTile(
                                                                title: Text(itemData.designationName ?? ""),
                                                              );
                                                            },
                                                            suggestionsCallback: (pattern) {
                                                              return controller.leadDesignationList;
                                                            },
                                                            onSelected: (suggestion) {
                                                              controller.selectedDesignationValue = suggestion;
                                                              controller.designationController.text = suggestion.designationName!;

                                                              print(suggestion.id);
                                                            },
                                                          ),
                                                        ),
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            textInputType: TextInputType.emailAddress,
                                                            controller: controller.emailController,
                                                            label: "Email Address"),
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            textInputType: TextInputType.phone,
                                                            obscure: false,
                                                            controller: controller.phoneNumberController,
                                                            label: "Phone Number"),
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              // if (value.isEmpty) {
                                                              //   return null;
                                                              // } else if (!Validate().validateMobile(value)) {
                                                              //   return "Please Enter Valid Whatsapp Number";
                                                              // }
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            textInputType: TextInputType.phone,
                                                            controller: controller.whatsappNumController,
                                                            label: "Whatsapp Number"),
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.websiteController,
                                                            label: "Website"),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Obx(
                                              () => InkWell(
                                                hoverColor: kColortransparent,
                                                onTap: () {
                                                  controller.isAddressInfoSelected.value = !controller.isAddressInfoSelected.value;

                                                  Timer(Duration(milliseconds: 300), () {
                                                    if (controller.isAddressInfoSelected.value == true) {
                                                      // Scroll to reveal the hidden widgets
                                                      _scrollController.animateTo(
                                                        _scrollController.offset + 500,
                                                        duration: Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(3.w),
                                                      margin: EdgeInsets.all(1.w),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Icon(
                                                            Icons.location_city_rounded,
                                                            color: controller.isAddressInfoSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                          ),
                                                          SizedBox(
                                                            width: 1.h,
                                                          ),
                                                          Text(
                                                            "Address Information",
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                color: controller.isAddressInfoSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                border: controller.isAddressInfoSelected.value == true ? Border.all(color: kColorlightBlue) : null,
                                                                borderRadius: BorderRadius.circular(2.w),
                                                                boxShadow: kElevationToShadow[2],
                                                                color: kColorwhite),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(1.0),
                                                              child: Icon(
                                                                controller.isAddressInfoSelected.value ? Icons.remove : Icons.add,
                                                                color: controller.isAddressInfoSelected.value == true ? Colors.blue : Colors.indigo,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: controller.isAddressInfoSelected.value == false ? 0.2.h : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Visibility(
                                                  visible: controller.isAddressInfoSelected.value,
                                                  child: Container(
                                                    margin: EdgeInsets.only(bottom: 1.h),
                                                    decoration: BoxDecoration(color: kColorwhite, borderRadius: BorderRadius.circular(4.w)),
                                                    child: Column(
                                                      children: [
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.postalCodeController,
                                                            label: "Pin Code"),
                                                        CustomTextField(
                                                            multilines: null,
                                                            maxLength: 2500,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.addressController,
                                                            label: "Address"),
                                                        controller.isNewcustomer.value
                                                            ? Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                                      child: TypeAheadField(
                                                                        autoFlipDirection: true,
                                                                        focusNode: _areafocusNode,
                                                                        controller: controller.areaController,
                                                                        itemBuilder: (context, AreaModel itemData) {
                                                                          return ListTile(
                                                                            title: Text(itemData.name!),
                                                                          );
                                                                        },
                                                                        suggestionsCallback: (pattern) {
                                                                          return controller.areaList;
                                                                        },
                                                                        onSelected: (suggestion) async {
                                                                          controller.selectedAreaValue = suggestion;

                                                                          controller.areaController.text = suggestion.name!;

                                                                          //selecting city-----------------------

                                                                          final cityId = controller.selectedAreaValue.cityId;

                                                                          controller.selectedCityValue = controller.cityList.firstWhere((city) => city.id == cityId);
                                                                          controller.cityController.text = controller.selectedCityValue.name ?? "";

                                                                          //selecting state-----------------------

                                                                          final stateId = controller.selectedCityValue.stateId;

                                                                          controller.selectedStateValue = controller.stateList.firstWhere((state) => state.id == stateId);

                                                                          controller.stateController.text = controller.selectedStateValue.name ?? "";

                                                                          //selecting country-----------------------

                                                                          final countryId = controller.selectedStateValue.countryId;

                                                                          controller.selectedCountryValue = controller.countryList.firstWhere((country) => country.id == countryId);

                                                                          controller.countryController.text = controller.selectedCountryValue.name ?? "";
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                                      child: TypeAheadField(
                                                                        autoFlipDirection: true,
                                                                        focusNode: _cityfocusNode,
                                                                        controller: controller.cityController,
                                                                        itemBuilder: (context, CityModel itemData) {
                                                                          return ListTile(
                                                                            title: Text(itemData.name!),
                                                                          );
                                                                        },
                                                                        suggestionsCallback: (pattern) {
                                                                          return controller.cityList;
                                                                        },
                                                                        onSelected: (suggestion) {
                                                                          controller.selectedCityValue = suggestion;

                                                                          controller.cityController.text = suggestion.name!;

                                                                          //selecting state-----------------------

                                                                          final stateId = controller.selectedCityValue.stateId;

                                                                          controller.selectedStateValue = controller.stateList.firstWhere((state) => state.id == stateId);

                                                                          controller.stateController.text = controller.selectedStateValue.name ?? "";

                                                                          //selecting country-----------------------

                                                                          final countryId = controller.selectedStateValue.countryId;

                                                                          controller.selectedCountryValue = controller.countryList.firstWhere((country) => country.id == countryId);

                                                                          controller.countryController.text = controller.selectedCountryValue.name ?? "";
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox(),
                                                        controller.isNewcustomer.value
                                                            ? Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                                      child: TypeAheadField(
                                                                        autoFlipDirection: true,
                                                                        focusNode: _statefocusNode,
                                                                        controller: controller.stateController,
                                                                        itemBuilder: (context, StateModel itemData) {
                                                                          return ListTile(
                                                                            title: Text(itemData.name!),
                                                                          );
                                                                        },
                                                                        suggestionsCallback: (pattern) {
                                                                          return controller.stateList;
                                                                        },
                                                                        onSelected: (suggestion) {
                                                                          controller.selectedStateValue = suggestion;

                                                                          controller.stateController.text = suggestion.name!;

                                                                          //selecting country-----------------------

                                                                          final countryId = controller.selectedStateValue.countryId;

                                                                          controller.selectedStateValue = controller.countryList.firstWhere((country) => country.id == countryId);

                                                                          controller.countryController.text = controller.selectedStateValue.name ?? "";
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                                      child: TypeAheadField(
                                                                        autoFlipDirection: true,
                                                                        focusNode: _countryfocusNode,
                                                                        controller: controller.countryController,
                                                                        itemBuilder: (context, StateModel itemData) {
                                                                          return ListTile(
                                                                            title: Text(itemData.name!),
                                                                          );
                                                                        },
                                                                        suggestionsCallback: (pattern) {
                                                                          return controller.countryList;
                                                                        },
                                                                        onSelected: (suggestion) {
                                                                          controller.selectedCountryValue = suggestion;

                                                                          controller.countryController.text = suggestion.name!;
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            Obx(
                                              () => InkWell(
                                                hoverColor: kColortransparent,
                                                onTap: () {
                                                  controller.isMoreSelected.value = !controller.isMoreSelected.value;

                                                  Timer(Duration(milliseconds: 300), () {
                                                    if (controller.isMoreSelected.value == true) {
                                                      // Scroll to reveal the hidden widgets
                                                      _scrollController.animateTo(
                                                        _scrollController.offset + 500,
                                                        duration: Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(3.w),
                                                      margin: EdgeInsets.all(1.w),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Icon(
                                                            Icons.data_saver_on_rounded,
                                                            color: controller.isMoreSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                          ),
                                                          SizedBox(
                                                            width: 1.h,
                                                          ),
                                                          Text(
                                                            "Additional Information",
                                                            style: TextStyle(
                                                                fontSize: 17.sp, color: controller.isMoreSelected.value == true ? Colors.blue : Colors.grey.shade600, fontWeight: FontWeight.bold),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                border: controller.isMoreSelected.value == true ? Border.all(color: kColorlightBlue) : null,
                                                                borderRadius: BorderRadius.circular(2.w),
                                                                boxShadow: kElevationToShadow[2],
                                                                color: kColorwhite),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(1.0),
                                                              child: Icon(
                                                                controller.isMoreSelected.value ? Icons.remove : Icons.add,
                                                                color: controller.isMoreSelected.value == true ? Colors.blue : Colors.indigo,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: controller.isMoreSelected.value == false ? 0.2.h : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(() => Visibility(
                                                  visible: controller.isMoreSelected.value,
                                                  child: Container(
                                                    margin: EdgeInsets.only(bottom: 1.h),
                                                    decoration: BoxDecoration(color: kColorwhite, borderRadius: BorderRadius.circular(4.w)),
                                                    child: Column(
                                                      children: [
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.leadScoreController,
                                                            label: "Lead Score"),
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.leadScoreDetailsController,
                                                            label: "Lead Source Details"),
                                                        Row(
                                                          children: [
                                                            // Expanded(
                                                            //   child: GestureDetector(
                                                            //     onTap: () {
                                                            //       DateClass().selectDate(controller.createdDateController, false, true);
                                                            //     },
                                                            //     child: CustomTextField(
                                                            //         multilines: 1,
                                                            //         height: 6.h,
                                                            //         // enabled: false,
                                                            //         readonly: true,
                                                            //         suffixIcon: IconButton(
                                                            //             splashColor: kColortransparent,
                                                            //             onPressed: () {
                                                            //               DateClass().selectDate(controller.createdDateController, false, true);
                                                            //             },
                                                            //             icon: Icon(Icons.date_range)),
                                                            //         validator: (value) {
                                                            //           return null;
                                                            //         },
                                                            //         textInputAction: TextInputAction.next,
                                                            //         obscure: false,
                                                            //         controller: controller.createdDateController,
                                                            //         label: "Created Date"),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _showBottomTimePicker(context, controller.followUpTimecontroller, "Select the Follow Up Time", true);
                                                          },
                                                          child: CustomTextField(
                                                              readonly: true,
                                                              suffixIcon: IconButton(
                                                                  onPressed: () {
                                                                    _showBottomTimePicker(context, controller.followUpTimecontroller, "Select the Follow Up Time", true);
                                                                  },
                                                                  icon: Icon(Icons.watch_later_outlined)),
                                                              multilines: 1,
                                                              height: 6.h,
                                                              validator: (value) {
                                                                return null;
                                                              },
                                                              textInputAction: TextInputAction.next,
                                                              obscure: false,
                                                              controller: controller.followUpTimecontroller,
                                                              label: "Follow Up Time"),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _showBottomTimePicker(context, controller.preferredContactTimeController, "Select the Preferred contact Time", false);
                                                          },
                                                          child: CustomTextField(
                                                              readonly: true,
                                                              suffixIcon: IconButton(
                                                                  onPressed: () {
                                                                    _showBottomTimePicker(context, controller.preferredContactTimeController, "Select the Preferred contact Time", false);
                                                                  },
                                                                  icon: Icon(Icons.watch_later_outlined)),
                                                              multilines: 1,
                                                              height: 6.h,
                                                              validator: (value) {
                                                                return null;
                                                              },
                                                              textInputAction: TextInputAction.next,
                                                              obscure: false,
                                                              controller: controller.preferredContactTimeController,
                                                              label: "Preferred Contact Time"),
                                                        ),
                                                        CustomTextField(
                                                            multilines: null,
                                                            maxLength: 2500,
                                                            // height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.internalCommentsControler,
                                                            label: "Internal comment"),
                                                        CustomTextField(
                                                            multilines: null,
                                                            maxLength: 2500,
                                                            // height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.leadCommentsControler,
                                                            label: "Lead comment"),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Obx(
                                              () => InkWell(
                                                hoverColor: kColortransparent,
                                                onTap: () {
                                                  controller.isInternalAnalysisSelected.value = !controller.isInternalAnalysisSelected.value;

                                                  Timer(Duration(milliseconds: 300), () {
                                                    if (controller.isInternalAnalysisSelected.value == true) {
                                                      // Scroll to reveal the hidden widgets
                                                      _scrollController.animateTo(
                                                        _scrollController.offset + 500,
                                                        duration: Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(3.w),
                                                      margin: EdgeInsets.all(1.w),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Icon(
                                                            Icons.details_rounded,
                                                            color: controller.isInternalAnalysisSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                          ),
                                                          SizedBox(
                                                            width: 1.h,
                                                          ),
                                                          Text(
                                                            "Internal Analysis",
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                color: controller.isInternalAnalysisSelected.value == true ? Colors.blue : Colors.grey.shade600,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                border: controller.isInternalAnalysisSelected.value == true ? Border.all(color: kColorlightBlue) : null,
                                                                borderRadius: BorderRadius.circular(2.w),
                                                                boxShadow: kElevationToShadow[2],
                                                                color: kColorwhite),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(1.0),
                                                              child: Icon(
                                                                controller.isInternalAnalysisSelected.value ? Icons.remove : Icons.add,
                                                                color: controller.isInternalAnalysisSelected.value == true ? Colors.blue : Colors.indigo,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: controller.isInternalAnalysisSelected.value == false ? 0.2.h : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Visibility(
                                                  visible: controller.isInternalAnalysisSelected.value,
                                                  child: Container(
                                                    margin: EdgeInsets.only(bottom: 1.h),
                                                    decoration: BoxDecoration(color: kColorwhite, borderRadius: BorderRadius.circular(4.w)),
                                                    child: Column(
                                                      children: [
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.customerPainPointscontroller,
                                                            label: "Customer Pain Points"),
                                                        CustomTextField(
                                                            multilines: 1,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.competitorsController,
                                                            label: "Competitors"),
                                                        CustomTextField(
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.customerBudgetControler,
                                                            label: "Customer Budget"),
                                                        CustomTextField(
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.annnualRevenueControler,
                                                            label: "Annual Revenues"),
                                                        CustomTextField(
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.numOfEmployeesControler,
                                                            label: "No:of Employees"),
                                                        CustomTextField(
                                                            maxLength: 2500,
                                                            height: 6.h,
                                                            validator: (value) {
                                                              return null;
                                                            },
                                                            textInputAction: TextInputAction.next,
                                                            obscure: false,
                                                            controller: controller.proposedSolutionControler,
                                                            label: "Proposed Solution"),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    widget.AddFromContacts == true || widget.editFromContacts == true
                        ? CustomButton(
                            width: 50.w,
                            title: widget.editFromContacts == true ? "Update" : "Done",
                            color: const Color.fromARGB(255, 58, 192, 255),
                            textcolor: kColorwhite,
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                var prefs = SharedPreferencesService.instance;

                                final logindecoded = json.decode(prefs.getValue('userMap')!);
                                final loginDetails = loginModel.LoginModel.fromJson(logindecoded);

                                final financialYearDetailDEcoded = json.decode(prefs.getValue('financialYear')!);
                                financialYear = FinancialYearModel.fromJson(financialYearDetailDEcoded);
                                print("index Number 2= ${widget.IndexOfMandatoryField ?? 0}");

                                contactController.isMandatoryFieldAdded[widget.IndexOfMandatoryField ?? 0] = true;

                                // var mobileNumber = contactController.cleanPhoneNumber(contactController.contactNumbers[widget.IndexOfMandatoryField ?? 0]);

                                contactController.leadList[widget.IndexOfMandatoryField ?? 0] = LeadModel(
                                  id: null,
                                  leadName: controller.nameController.text,
                                  mobileNo: controller.mobileNoController.text,
                                  leadGenerationDate: DateClass().parseDate(controller.leadDateController.text),
                                  followUpDate: DateClass().parseDate(controller.followUpDateController.text),
                                  leadGenerationId: null,
                                  leadGenerationNumber: controller.autoNum.value == 0
                                      ? controller.leadGenerationNumController.text.isEmpty
                                          ? null
                                          : controller.leadGenerationNumController.text
                                      : null,
                                  address: controller.addressController.text,
                                  amount: controller.amountController.text.isEmpty ? 0.0 : double.parse(controller.amountController.text),
                                  annualTurnOver: "",
                                  areaId: controller.selectedAreaValue.id,
                                  assignedToId: controller.selectedUserValue.id,
                                  cityId: controller.selectedCityValue.id,
                                  comments: null,
                                  companyId: loginDetails.user!.company!.id,
                                  interestedProductId: controller.selectedMaterialItem.map<int>((material) => material.id!).toList(),
                                  interestedServiceId: controller.selectedServiceItem.map<int>((material) => material.id!).toList(),
                                  contactPerson: controller.contactPersonController.text,
                                  contactPersonNo: controller.contactNumberController.text,
                                  conversionChanceId: controller.selectedConversionChanceValue.id ?? 0,
                                  countryId: controller.selectedCountryValue.id ?? null,
                                  deleted: null,
                                  email: controller.emailController.text,
                                  financialYearId: financialYear!.id,
                                  followUpTime: controller.followUpId.value == 0 ? null : controller.followUpId.value,
                                  isExistingCustomer: controller.isNewcustomer.value ? null : 1,
                                  leadComments: controller.leadCommentsControler.text,
                                  leadGenerationType: 35,
                                  partyId: controller.selectedCustomerValue.id ?? null,
                                  partyName: controller.selectedCustomerValue.name ?? '',
                                  priorityId: controller.selectedPriorityValue.id ?? 0,
                                  productName: controller.intrestedProductController.text,
                                  sourceId: controller.selectedSourceValue.id ?? 0,
                                  stateId: controller.selectedStateValue.id ?? null,
                                  statusId: controller.selectedStatusValue.id ?? null,
                                  statusName: controller.statusController.text,
                                  userComments: controller.internalCommentsControler.text,
                                  quickLead: 1,
                                  leadOwnerId: controller.selectedUserValue.id,
                                  leadCompanyName: controller.companyNameController.text,
                                  industrySegmentId: controller.selectedindusSegmentValue.id,
                                  leadCategoryId: controller.selectedCategoryuValue.id,
                                  leadDescription: controller.leadDescriptionController.text,
                                  designationId: controller.selectedDesignationValue.id,
                                );
                                print("leaddddd----${contactController.leadList[widget.IndexOfMandatoryField ?? 0].amount}");

                                contactController.leadList.forEach((lead) {
                                  print(lead.toJson());
                                });
                                print('Leads Added: ${contactController.leadList.length}');
                                Get.back();
                              } else {
                                customSnackbar("Enter The Details Correctly", "Please check everything you entered is correct", "error");
                              }
                            },
                          )
                        : CustomButton(
                            width: 50.w,
                            title: widget.isEdit == true ? "Update" : "Save",
                            color: const Color.fromARGB(255, 58, 192, 255),
                            textcolor: kColorwhite,
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                if (widget.isEditFromLeadGen == true) {
                                  print("update lead");
                                  controller.UpdateLead(isLeadGenEdit: widget.isEditFromLeadGen!, leadGenValues: widget.leadGenerationValue);
                                } else {
                                  print("save lead --${controller.nameController.text}");

                                  controller.saveLead(isEdit: widget.isEdit, leadValues: widget.leadValue, latLong: controller.latAndLong);
                                }
                              } else {
                                customSnackbar("Enter The Details Correctly", "Please check everything you entered is correct", "error");
                              }
                            },
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isPageLoading.value,
            child: Positioned.fill(
              child: Container(
                color: kColorblack.withOpacity(0.5),
                child: Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: Colors.lightBlue,
                    size: 10.w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  editFromContactsFunction(int index) async {
    print("inside ----- edit");
    // controller.quickLeadisSelected.value = widget.leadValue!.quickLead == 1 ? true : false;
    // controller.isNewcustomer.value = widget.leadValue!.isExistingCustomer == null ? false : true;
    controller.leadGenerationNumController.text = widget.leadValue!.leadGenerationNumber ?? "";
    controller.leadDateController.text = widget.leadValue!.leadGenerationDate == null ? "" : DateClass().showDate(widget.leadValue!.leadGenerationDate ?? "");

    controller.followUpDateController.text = widget.leadValue!.followUpDate == null ? "" : DateClass().showDate(widget.leadValue!.followUpDate ?? "");
    controller.nameController.text = widget.leadValue!.leadName ?? "";
    controller.companyNameController.text = widget.leadValue!.leadCompanyName ?? "";
    var mobileNumber = contactController.cleanPhoneNumber(widget.leadValue!.mobileNo ?? "");
    print(mobileNumber);
    controller.mobileNoController.text = mobileNumber;

    //designations
    await controller.getDesignation();

    if (widget.leadValue!.designationId != null) {
      controller.selectedDesignationValue = controller.leadDesignationList.firstWhere((value) => value.id == widget.leadValue!.designationId);
      controller.designationController.text = controller.selectedDesignationValue.designationName ?? "";
    }
    //--Category
    await controller.getLeadCategory();
    if (widget.leadValue!.leadCategoryId != null) {
      controller.selectedCategoryuValue = controller.leadCategoryList.firstWhere((value) => value.id == widget.leadValue!.leadCategoryId);
      controller.categoryController.text = controller.selectedCategoryuValue.name ?? "";
    }
    //--industry segment
    await controller.getIndustrySegment();
    if (widget.leadValue!.industrySegmentId != null) {
      controller.selectedindusSegmentValue = controller.industrySegmentList.firstWhere((value) => value.id == widget.leadValue!.industrySegmentId);
      controller.industrySegmentController.text = controller.selectedindusSegmentValue.name ?? "";
    }
    //LeadOwner
    await controller.getUserList();

    if (widget.leadValue!.leadOwnerId != null) {
      controller.selectedUserValue = controller.userList.firstWhere((value) => value.id == widget.leadValue!.leadOwnerId);
      controller.leadOwnerController.text = controller.selectedUserValue.name ?? "";
    }
    if (widget.leadValue!.interestedProductId != null && widget.leadValue!.interestedProductId!.isNotEmpty) {
      List interestedProductIds = widget.leadValue!.interestedProductId!
          .map(
            (e) => e,
          )
          .toList();

      controller.selectedMaterialItem.clear();

      for (var item in widget.materialList) {
        if (interestedProductIds.contains(item.id)) {
          controller.selectedMaterialItem.add(item);
        }
      }

      controller.intrestedProductController.text = controller.selectedMaterialItem.map((item) => item.name).join(', ');
    }

    print("interested ----------product----${controller.intrestedProductController.text}");

    controller.amountController.text = widget.leadValue!.amount?.toString() ?? "";
    await controller.getStatusById();
    await controller.getSourceList();

    controller.selectedStatusValue.id = widget.leadValue!.statusId;
    controller.statusController.text = controller.statusList.firstWhere((element) => element.id == controller.selectedStatusValue.id).name ?? "";

    controller.selectedSourceValue.id = widget.leadValue!.sourceId;
    controller.sourceController.text = controller.sourceList.firstWhere((element) => element.id == controller.selectedSourceValue.id).name ?? "";
  }

  EditFunction() async {
    // controller.isPageLoading.value = true;
    print("Existing customer  --${widget.leadValue?.isExistingCustomer}");

    print("existing customer edit from report --${widget.leadGenerationValue?.isExistingCustomer}");

    controller.quickLeadisSelected.value = widget.isEditFromLeadGen == true
        ? widget.leadGenerationValue!.quickLead == 1
            ? true
            : false
        : widget.leadValue!.quickLead == 1
            ? true
            : false;
    controller.isNewcustomer.value = widget.isEditFromLeadGen == true
        ? widget.leadGenerationValue!.isExistingCustomer == null || widget.leadGenerationValue!.isExistingCustomer == 0
            ? true
            : false
        : widget.leadValue!.isExistingCustomer == null || widget.leadValue!.isExistingCustomer == 0
            ? true
            : false;
    controller.leadGenerationNumController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadGenerationNumber ?? "" : widget.leadValue!.leadGenerationNumber ?? "";
    controller.leadDateController.text =
        widget.isEditFromLeadGen == true ? DateClass().showDate(widget.leadGenerationValue!.leadGenerationDate ?? "") : DateClass().showDate(widget.leadValue!.leadGenerationDate ?? "");
    controller.companyNameController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadCompanyName ?? "" : widget.leadValue!.leadCompanyName ?? "";
    controller.leadDateController.text =
        widget.isEditFromLeadGen == true ? DateClass().showDate(widget.leadGenerationValue!.leadGenerationDate ?? "") : DateClass().showDate(widget.leadValue!.leadGenerationDate ?? "");
    controller.nameController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadName ?? "" : widget.leadValue!.leadName ?? "";
    controller.followUpDateController.text = widget.isEditFromLeadGen == true
        ? DateClass().showDate(widget.leadGenerationValue!.followUpDate ?? "")
        : widget.leadValue!.followUpDate == null
            ? ""
            : DateClass().showDate(widget.leadValue!.followUpDate ?? "");
    controller.mobileNoController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.mobileNo ?? "" : widget.leadValue!.mobileNo ?? "";
    controller.contactPersonController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.contactPerson ?? "" : widget.leadValue!.contactPerson ?? "";
    controller.emailController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.email ?? "" : widget.leadValue!.email ?? "";
    controller.addressController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.address ?? "" : widget.leadValue!.address ?? "";
    controller.leadDescriptionController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadDescription ?? "" : widget.leadValue!.leadDescription ?? "";
    controller.referralNameController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.referralName ?? "" : widget.leadValue!.referralName ?? "";
    controller.internalCommentsControler.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.userComments ?? "" : widget.leadValue!.userComments ?? "";
    controller.customerPainPointscontroller.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.customerPainPoints ?? "" : widget.leadValue!.customerPainPoints ?? "";
    controller.postalCodeController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.pincode ?? "" : widget.leadValue!.pincode ?? "";
    controller.phoneNumberController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.contactPersonNo ?? "" : widget.leadValue!.contactPersonNo ?? "";
    controller.whatsappNumController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.whatsappNumber ?? "" : widget.leadValue!.whatsappNumber ?? "";
    controller.websiteController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.website ?? "" : widget.leadValue!.website ?? "";
    controller.leadScoreDetailsController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadSourceDetails ?? "" : widget.leadValue!.leadSourceDetails ?? "";
    controller.leadScoreController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadScore ?? "" : widget.leadValue!.leadScore ?? "";
    controller.proposedSolutionControler.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.proposedSolution ?? "" : widget.leadValue!.proposedSolution ?? "";
    controller.numOfEmployeesControler.text =
        widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.numberOfEmployees?.toString() ?? "" : widget.leadValue!.numberOfEmployees?.toString() ?? "";
    controller.annnualRevenueControler.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.annualTurnOver?.toString() ?? "" : widget.leadValue!.annualTurnOver?.toString() ?? "";
    controller.customerBudgetControler.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.customerBudget?.toString() ?? "" : widget.leadValue!.customerBudget?.toString() ?? "";
    controller.competitorsController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.competitors ?? "" : widget.leadValue!.competitors ?? "";
    controller.latAndLong.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadGeoLocation ?? "" : widget.leadValue!.leadGeoLocation ?? "";
    print("controller.followUpTimecontroller.text ${controller.followUpTimecontroller.text}");

    //LeadOwner
    await controller.getUserList();

    if (widget.leadValue?.leadOwnerId != null || widget.leadGenerationValue?.leadOwnerId != null) {
      print("inside lead owner");
      widget.isEditFromLeadGen == true
          ? controller.selectedUserValue = controller.userList.firstWhere((value) => value.id == widget.leadGenerationValue!.leadOwnerId)
          : controller.selectedUserValue = controller.userList.firstWhere((value) => value.id == widget.leadValue!.leadOwnerId);
      controller.leadOwnerController.text = controller.selectedUserValue.name ?? "";
    }

    print("leadd owner--${controller.selectedUserValue.name}");
    print("amount value----${widget.leadValue?.amount}");

    controller.amountController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.amount?.toString() ?? "" : widget.leadValue!.amount?.toString() ?? "";

    controller.leadCommentsControler.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadComments ?? "" : widget.leadValue!.leadComments ?? "";
    controller.userCommentsController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.userComments ?? "" : widget.leadValue!.userComments ?? "";

    //------ interested product ----
    // await controller.getMaterialsList();

    if (widget.isEditFromLeadGen == true
        ? widget.leadGenerationValue?.interestedProductId != null && widget.leadGenerationValue!.interestedProductId!.isNotEmpty
        : widget.leadValue?.interestedProductId != null && widget.leadValue!.interestedProductId!.isNotEmpty) {
      List<int> interestedProductIds = widget.isEditFromLeadGen == true
          ? widget.leadGenerationValue!.interestedProductId!
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(',')
              .where((id) => id.trim().isNotEmpty)
              .map((id) {
                try {
                  return int.parse(id.trim());
                } catch (e) {
                  print("Error parsing id '$id': $e");
                  return null;
                }
              })
              .whereType<int>()
              .toList()
          : widget.leadValue!.interestedProductId!
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(',')
              .where((id) => id.trim().isNotEmpty)
              .map((id) {
                try {
                  return int.parse(id.trim());
                } catch (e) {
                  print("Error parsing id '$id': $e");
                  return null;
                }
              })
              .whereType<int>()
              .toList();
      controller.selectedMaterialItem.clear();
      for (var item in widget.materialList) {
        if (interestedProductIds.contains(item.id)) {
          controller.selectedMaterialItem.add(item);
        }
      }
      controller.intrestedProductController.text = controller.selectedMaterialItem.map((item) => item.name).join(', ');
    }

    print("interested ----------product----${controller.intrestedProductController.text}");

    //------ interested service ----

    print("----int id -- ${widget.leadValue?.interestedServiceId?.length}");

    if (widget.isEditFromLeadGen == true
        ? widget.leadGenerationValue?.interestedServiceId != null && widget.leadGenerationValue!.interestedServiceId!.isNotEmpty
        : widget.leadValue!.interestedServiceId != null && widget.leadValue!.interestedServiceId!.isNotEmpty) {
      var interestedServiceId = widget.isEditFromLeadGen == true
          ? widget.leadGenerationValue!.interestedServiceId!
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(',')
              .where((id) => id.trim().isNotEmpty)
              .map((id) {
                try {
                  return int.parse(id.trim());
                } catch (e) {
                  print("Error parsing id '$id': $e");
                  return null;
                }
              })
              .whereType<int>()
              .toList()
          : widget.leadValue!.interestedServiceId!
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(',')
              .where((id) => id.trim().isNotEmpty)
              .map((id) {
                try {
                  return int.parse(id.trim());
                } catch (e) {
                  print("Error parsing id '$id': $e");
                  return null;
                }
              })
              .whereType<int>()
              .toList();
      controller.selectedServiceItem.clear();
      for (var item in widget.serviceList) {
        if (interestedServiceId.contains(item.id)) {
          controller.selectedServiceItem.add(item);
        }
      }
      controller.intrestedServiceController.text = controller.selectedServiceItem.map((item) => item.name).join(', ');
    }

    //

    await controller.getStatusById();

    controller.statusController.text = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.statusName ?? "" : widget.leadValue!.statusName ?? "";
    controller.selectedStatusValue.id = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.statusId ?? 0 : widget.leadValue!.statusId;
    controller.statusId.value = widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.statusId ?? 0 : widget.leadValue!.statusId ?? 0;

    print("status id -- ${controller.selectedStatusValue.id}");

    //--industry segment
    await controller.getIndustrySegment();
    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.industrySegmentId != null : widget.leadValue!.industrySegmentId != null) {
      controller.selectedindusSegmentValue = widget.isEditFromLeadGen == true
          ? controller.industrySegmentList.firstWhere((value) => value.id == widget.leadGenerationValue!.industrySegmentId)
          : controller.industrySegmentList.firstWhere((value) => value.id == widget.leadValue!.industrySegmentId);
      controller.industrySegmentController.text = controller.selectedindusSegmentValue.name ?? "";
    }

    //--Not Converted reason
    await controller.getReasonConversion();
    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.reasonId != null : widget.leadValue!.reasonId != null) {
      controller.selectedReasonConversionValue = widget.isEditFromLeadGen == true
          ? controller.reasonConversionList.firstWhere((value) => value.id == widget.leadGenerationValue!.reasonId)
          : controller.reasonConversionList.firstWhere((value) => value.id == widget.leadValue!.reasonId);
      controller.notConvertedReasonController.text = controller.selectedReasonConversionValue.name ?? "";
    }

    //--Category
    await controller.getLeadCategory();
    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.leadCategoryId != null : widget.leadValue!.leadCategoryId != null) {
      controller.selectedCategoryuValue = widget.isEditFromLeadGen == true
          ? controller.leadCategoryList.firstWhere((value) => value.id == widget.leadGenerationValue!.leadCategoryId)
          : controller.leadCategoryList.firstWhere((value) => value.id == widget.leadValue!.leadCategoryId);
      controller.categoryController.text = controller.selectedCategoryuValue.name ?? "";
    }

    //--asigned to
    await controller.getUserList();
    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.assignedToId != null : widget.leadValue!.assignedToId != null) {
      controller.selectedUserValue = widget.isEditFromLeadGen == true
          ? controller.userList.firstWhere((value) => value.id == widget.leadGenerationValue!.assignedToId)
          : controller.userList.firstWhere((value) => value.id == widget.leadValue!.assignedToId);
      controller.assignController.text = controller.selectedUserValue.name ?? "";
    }

    //designations
    await controller.getDesignation();

    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.designationId != null : widget.leadValue!.designationId != null) {
      controller.selectedDesignationValue = widget.isEditFromLeadGen == true
          ? controller.leadDesignationList.firstWhere((value) => value.id == widget.leadGenerationValue!.designationId)
          : controller.leadDesignationList.firstWhere((value) => value.id == widget.leadValue!.designationId);
      controller.designationController.text = controller.selectedDesignationValue.designationName ?? "";
    }

    print("designation --${controller.selectedDesignationValue.designationName}");

    //--source
    await controller.getSourceList();
    controller.selectedSourceValue = widget.isEditFromLeadGen == true
        ? controller.sourceList.firstWhere((value) => value.id == widget.leadGenerationValue!.sourceId)
        : controller.sourceList.firstWhere((value) => value.id == widget.leadValue!.sourceId);
    controller.sourceController.text = controller.selectedSourceValue.name ?? "";

    //- priority
    controller.selectedPriorityValue = widget.isEditFromLeadGen == true
        ? controller.priorityList.firstWhere((value) => value.id == widget.leadGenerationValue!.priorityId)
        : controller.priorityList.firstWhere((value) => value.id == widget.leadValue!.priorityId);
    controller.priorityController.text = controller.selectedPriorityValue.name ?? "";
    //--conversionchance
    controller.selectedConversionChanceValue = widget.isEditFromLeadGen == true
        ? controller.conversionChanceList.firstWhere((value) => value.id == widget.leadGenerationValue!.conversionChanceId)
        : controller.conversionChanceList.firstWhere((value) => value.id == widget.leadValue!.conversionChanceId);
    controller.conversionChanceController.text = controller.selectedConversionChanceValue.name ?? "";

    //--area'
    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.areaId != null : widget.leadValue!.areaId != null) {
      await controller.getAreaList();

      controller.selectedAreaValue = widget.isEditFromLeadGen == true
          ? controller.areaList.firstWhere((value) => value.id == widget.leadGenerationValue!.areaId)
          : controller.areaList.firstWhere((city) => city.id == widget.leadValue!.areaId);
      controller.areaController.text = controller.selectedAreaValue.name ?? "";
    }

    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.cityId != null : widget.leadValue!.cityId != null) {
      await controller.getCityList();

      controller.selectedCityValue = widget.isEditFromLeadGen == true
          ? controller.cityList.firstWhere((value) => value.id == widget.leadGenerationValue!.cityId)
          : controller.cityList.firstWhere((city) => city.id == widget.leadValue!.cityId);
      controller.cityController.text = controller.selectedCityValue.name ?? "";
    }

    //--city
    // await controller.getCityList();
    // widget.leadValue!.cityId == null ? null : controller.selectedCityValue = controller.cityList.firstWhere((value) => value.id == widget.leadValue!.cityId);
    // controller.cityController.text = controller.selectedCityValue.name ?? "";

    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.stateId != null : widget.leadValue!.stateId != null) {
      await controller.getStateList();

      controller.selectedStateValue = widget.isEditFromLeadGen == true
          ? controller.stateList.firstWhere((value) => value.id == widget.leadGenerationValue!.stateId)
          : controller.stateList.firstWhere((city) => city.id == widget.leadValue!.stateId);
      controller.stateController.text = controller.selectedStateValue.name ?? "";
    }
    //--state
    // await controller.getStateList();
    // widget.leadValue!.stateId == null ? null : controller.selectedStateValue = controller.stateList.firstWhere((value) => value.id == widget.leadValue!.stateId);
    // controller.stateController.text = controller.selectedStateValue.name ?? "";

    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.countryId != null : widget.leadValue!.countryId != null) {
      await controller.getCountryList();

      controller.selectedCountryValue = widget.isEditFromLeadGen == true
          ? controller.countryList.firstWhere((value) => value.id == widget.leadGenerationValue!.countryId)
          : controller.countryList.firstWhere((city) => city.id == widget.leadValue!.countryId);
      controller.countryController.text = controller.selectedCountryValue.name ?? "";
    }
    //--country
    // await controller.getCountryList();
    // widget.leadValue!.countryId == null ? null : controller.selectedCountryValue = controller.countryList.firstWhere((value) => value.id == widget.leadValue!.countryId);
    // controller.countryController.text = controller.selectedCountryValue.name ?? " ";

    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.followUpTime != null : widget.leadValue!.followUpTime != null) {
      await controller.getFollowUpTime();
      // controller.followUpTimeList.firstWhereOrNull((element) => element["id"] == widget.leadValue!.followUpTime)["time"];
      print("id value----${widget.leadValue?.followUpTime}");

      controller.followUpTimecontroller.text = widget.isEditFromLeadGen == true
          ? controller.followUpTimeList.firstWhere((element) {
              print("list id---${element["id"]}");
              return element["id"] == widget.leadGenerationValue!.followUpTime;
            })["time"]
          : controller.followUpTimeList.firstWhere((element) {
              print("list id---${element["id"]}");
              return element["id"] == widget.leadValue!.followUpTime;
            })["time"];
    }
    print("follow up time --${controller.followUpTimecontroller.text}");

    if (widget.isEditFromLeadGen == true ? widget.leadGenerationValue!.preferredContactTime != null : widget.leadValue!.preferredContactTime != null) {
      await controller.getFollowUpTime();
      controller.preferredContactTimeController.text = widget.isEditFromLeadGen == true
          ? controller.followUpTimeList.firstWhere((element) {
              print("list id---${element["id"]}");
              return element["id"] == widget.leadGenerationValue!.preferredContactTime;
            })["time"]
          : controller.followUpTimeList.firstWhere(
              (element) => element["id"] == widget.leadValue!.preferredContactTime,
            )["time"];
    }
    print("preferd contact  time --${controller.preferredContactTimeController.text}");
  }

  void _showBottomTimePicker(BuildContext context, TextEditingController selectedTimeController, String titleName, [bool? isFromFollowUpTime]) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(5.w))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TimePickerBotoomSheetWidget(
          selectedTimeController: selectedTimeController,
          title: titleName,
          isFromFollowUpTime: isFromFollowUpTime,
        );
      },
    );
  }

  void _showInterestProductBottomSheet({required BuildContext context, required bool isMaterial, required List<MaterialModel> materialList, required List<MaterialModel> serviceList}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5.w), topRight: Radius.circular(5.w))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return InterestedProductBottomSheetWidget(
          materialList: materialList,
          serviceList: serviceList,
          isMaterial: isMaterial,
        );
      },
    );
  }
}

class TimePickerBotoomSheetWidget extends StatelessWidget {
  final TextEditingController selectedTimeController;
  String title;
  bool? isFromFollowUpTime;

  TimePickerBotoomSheetWidget({super.key, required this.selectedTimeController, required this.title, this.isFromFollowUpTime});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeadController());

    return SizedBox(
      height: 80.h,
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Divider(thickness: 2),
            SizedBox(height: 2.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2.0, // Spacing between rows
                ),
                itemCount: controller.followUpTimeList.length,
                itemBuilder: (context, index) {
                  var item = controller.followUpTimeList[index];
                  return GestureDetector(
                    onTap: () {
                      selectedTimeController.text = item['time'] ?? "empty";
                      var selectedId = item['id'] ?? 0;

                      print(selectedTimeController.text);
                      print("follow up bool--${isFromFollowUpTime}");
                      if (isFromFollowUpTime == true) {
                        print(selectedId);
                        controller.followUpId.value = selectedId;
                        print("follow up time- id--2--${controller.followUpId.value}");
                      } else if (isFromFollowUpTime == false) {
                        controller.preferredContactTimeId.value = selectedId;
                        print("prefered time- id--2--${controller.preferredContactTimeId.value}");
                      }
                      // isFromFollowUpTime == true ? selectedId = controller.followUpId.value : selectedId = controller.preferredContactTimeId.value;

                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(4.w) // Border around each item
                          ),
                      child: Center(
                        child: Text(
                          item['time'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              width: 50.w,
              title: "Close",
              textcolor: kColorwhite,
              ontap: () {
                Get.back();
              },
              color: kColorlightBlue300,
            )
          ],
        ),
      ),
    );
  }
}

class InterestedProductBottomSheetWidget extends StatefulWidget {
  final bool isMaterial;
  final List<MaterialModel> materialList;
  final List<MaterialModel> serviceList;

  const InterestedProductBottomSheetWidget({super.key, required this.isMaterial, required this.materialList, required this.serviceList});

  @override
  State<InterestedProductBottomSheetWidget> createState() => _InterestedProductBottomSheetWidgetState();
}

class _InterestedProductBottomSheetWidgetState extends State<InterestedProductBottomSheetWidget> {
  final controller = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 90.h,
          child: Padding(
            padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.h, right: 2.h),
            child: Column(
              children: [
                Text(widget.isMaterial ? "Interested Products" : "Interested Service", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(height: 2.h),
                TextField(
                  onChanged: (value) {
                    widget.isMaterial
                        ? controller.materialSearchResults(query: value, materialLists: widget.materialList)
                        : controller.serviceSearchResults(query: value, serviceLists: widget.serviceList);
                  },
                  decoration: InputDecoration(labelText: 'Search', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.w))),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.isMaterial) {
                              if (controller.selectedMaterialItem.contains(item)) {
                                controller.selectedMaterialItem.remove(item);
                              } else {
                                controller.selectedMaterialItem.add(item);
                              }
                            } else {
                              if (controller.selectedServiceItem.contains(item)) {
                                controller.selectedServiceItem.remove(item);
                              } else {
                                controller.selectedServiceItem.add(item);
                              }
                            }

                            if (widget.isMaterial) {
                              controller.intrestedProductController.text = controller.selectedMaterialItem.map((item) => item.name).join(', ');
                            } else {
                              controller.intrestedServiceController.text = controller.selectedServiceItem.map((item) => item.name).join(', ');
                            }
                          });
                        },
                        child: ListTile(
                          title: Text(item.name!),
                          trailing: Checkbox(
                            value: widget.isMaterial ? controller.selectedMaterialItem.contains(item) : controller.selectedServiceItem.contains(item),
                            onChanged: (bool? value) {
                              setState(() {
                                if (widget.isMaterial) {
                                  if (controller.selectedMaterialItem.contains(item)) {
                                    controller.selectedMaterialItem.remove(item);
                                  } else {
                                    controller.selectedMaterialItem.add(item);
                                  }
                                } else {
                                  if (controller.selectedServiceItem.contains(item)) {
                                    controller.selectedServiceItem.remove(item);
                                  } else {
                                    controller.selectedServiceItem.add(item);
                                  }
                                }

                                print(controller.selectedMaterialItem);

                                if (widget.isMaterial) {
                                  controller.intrestedProductController.text = controller.selectedMaterialItem.map((item) => item.name).join(', ');
                                } else {
                                  controller.intrestedServiceController.text = controller.selectedServiceItem.map((item) => item.name).join(', ');
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  width: 50.w,
                  title: "Close",
                  textcolor: kColorwhite,
                  ontap: () {
                    Get.back();
                  },
                  color: kColorlightBlue300,
                )
              ],
            ),
          ),
        ));
  }
}
