// ignore_for_file: avoid_print, use_build_context_synchronously, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/UOM_model.dart';
import 'package:work_Force/Model/serviceStatusModel.dart';
import 'package:work_Force/Model/service_category_model.dart';
import 'package:work_Force/Model/service_execution_model.dart';
import 'package:work_Force/Model/service_material_model.dart';
import 'package:work_Force/Model/subscription_based_service_model.dart';
import 'package:work_Force/Model/taxes_model.dart';
import 'package:work_Force/controllers/service_master_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Service%20Master/Add%20Service%20Master/add_service_master.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';

class BuildOneTimeAndSubScreen extends StatefulWidget {
  String selectOption;
  final GlobalKey formkey;
  ServiceMaterialListModel? serviceMasterSavedValue;
  final bool isedit;
  BuildOneTimeAndSubScreen({
    super.key,
    required this.formkey,
    required this.selectOption,
    this.serviceMasterSavedValue,
    required this.isedit,
  });

  @override
  State<BuildOneTimeAndSubScreen> createState() =>
      _BuildOneTimeAndSubScreenState();
}

class _BuildOneTimeAndSubScreenState extends State<BuildOneTimeAndSubScreen> {
  TaxesModel? taxValue;

  UOMGetModel? uomValue;

  GetServiceStatusModel? serviceValue;

  GetServiceCategoryModel? categoryValue;

  GetServiceExecutionModel? executionValue;
  final controller = Get.put(ServiceMasterController());

  final GlobalKey<FormState> _formKeyPopup = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            const Text(
              "Service Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            buildTextField(
              titleController: controller.nameController,
              label: "Service Name",
              isRequired: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Service Name is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            buildTextField(
              titleController: controller.sacController,
              label: "SAC",
              keyboardType: TextInputType.number,
              isRequired: false,
              validator: (value) {
                
                return null;
              },
            ),
            if (widget.selectOption == "One Time") const SizedBox(height: 8.0),
            // Field 2
            if (widget.selectOption == "One Time")
              TypeAheadField<UOMGetModel>(
                debounceDuration: const Duration(milliseconds: 500),
                controller: controller.uomController,
                builder: (context, UOMcontroller, UOMfocusNode) {
                  return TextFormField(
                      enabled: true,
                      readOnly: true,
                      controller: UOMcontroller,
                      focusNode: UOMfocusNode,
                      decoration: InputDecoration(
                        labelText: "UOM*",
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: kColorblack,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade300,
                              width: 1.0), // Border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0), // Border on validation error
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ));
                },
                suggestionsCallback: controller.getUnitLists,
                itemBuilder: (context, UOMGetModel suggestion) {
                  final quotNumber = suggestion;
                  return ListTile(
                    title: Text(quotNumber.name!),
                  );
                },
                loadingBuilder: (context) {
                  return SizedBox(
                      height: 10.h,
                      child: const Center(child: CircularProgressIndicator()));
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
                onSelected: (UOMGetModel suggestion) {
                  uomValue = suggestion;

                  controller.ifUnitSelected.value = true;

                  controller.uomController.text = uomValue!.name.toString();

                  controller.unitId = uomValue!.id;
                },
              ),
            const SizedBox(height: 8.0),
            if (widget.selectOption == "One Time") const SizedBox(height: 8.0),

            // Field 3
            if (widget.selectOption == "One Time")
              TypeAheadField<TaxesModel>(
                debounceDuration: const Duration(milliseconds: 500),
                controller: controller.taxController,

                builder: (context, taxcontroller, taxfocusNode) {
                  return TextFormField(
                    enabled: true,
                    readOnly: true,
                    controller: taxcontroller,
                    focusNode: taxfocusNode,
                    decoration: InputDecoration(
                      labelText: "Tax",
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: kColorblack,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0), // Default border
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue.shade300,
                            width: 1.0), // Border when focused
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.0), // Border on validation error
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },

                suggestionsCallback: controller.getTaxesList,
                // hideKeyboard: true,
                // hideKeyboardOnDrag: true,

                itemBuilder: (context, TaxesModel suggestion) {
                  final quotNumber = suggestion;
                  return ListTile(
                    title: Text("${quotNumber.name!} - ${quotNumber.rate}%"),
                  );
                },
                loadingBuilder: (context) {
                  return SizedBox(
                      height: 10.h,
                      child: const Center(child: CircularProgressIndicator()));
                },
                emptyBuilder: (context) {
                  // customerReceiptController
                  //     .nocustomerFound.value = true;

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

                onSelected: (TaxesModel suggestion) {
                  taxValue = suggestion;

                  controller.ifUnitSelected.value = true;

                  controller.taxController.text =
                      "${taxValue!.name.toString()} - ${taxValue!.rate.toString()}%";

                  controller.taxId.value = taxValue!.id ?? 0;

                  print("tax selected ---${controller.taxController.text}");
                },
              ),
            // SizedBox(height: 8.0),

            if (widget.selectOption == "One Time") const SizedBox(height: 16.0),
            // Field 4
            TypeAheadField<GetServiceStatusModel>(
              debounceDuration: const Duration(milliseconds: 500),
              controller: controller.serviecStatusController,
              builder: (context, ServStatuscontroller, ServStatusfocusNode) {
                return TextFormField(
                  enabled: true,
                  readOnly: true,
                  controller: ServStatuscontroller,
                  focusNode: ServStatusfocusNode,
                  decoration: InputDecoration(
                    labelText: "Service Status",
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: kColorblack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0), // Default border
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade300,
                          width: 1.0), // Border when focused
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0), // Border on validation error
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              suggestionsCallback: (pattern) async {
                return await controller.getServiceStatus();
              },
              itemBuilder: (context, GetServiceStatusModel suggestion) {
                final quotNumber = suggestion;
                return ListTile(
                  title: Text(quotNumber.name!),
                );
              },
              loadingBuilder: (context) {
                return SizedBox(
                    height: 10.h,
                    child: const Center(child: CircularProgressIndicator()));
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
              onSelected: (GetServiceStatusModel suggestion) {
                serviceValue = suggestion;

                controller.serviecStatusController.text =
                    serviceValue!.name.toString();

                controller.serviceStatusId.value = serviceValue!.id ?? 0;
              },
            ),
            const SizedBox(height: 16.0),

            widget.isedit == true
                ? Obx(
                    () => controller.uploadImage.value == false
                        ? FadeInLeft(
                            child: GestureDetector(
                              onTap: () async {
                                print(
                                    "id--${widget.serviceMasterSavedValue?.id ?? ""}");
                                await controller.obtainImage(
                                  source: ImageSource.gallery,
                                  id: widget.serviceMasterSavedValue?.id,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kColorLightBlueAppBar,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: controller.isLoading.value == true
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: kColorlightBlue,
                                          ),
                                        )
                                      : Text(
                                          "Upload Image",
                                          style: TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            color: kColorlightBlue,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ),
                            ),
                          )
                        : FadeInRight(
                            child: Row(
                              children: [
                                Obx(
                                  () => controller.isLoading.value == true
                                      ? Container(
                                          height: 80,
                                          width: 35.w,
                                          decoration: BoxDecoration(
                                            boxShadow: kElevationToShadow[1],
                                            color: kColorwhite,
                                            borderRadius:
                                                BorderRadius.circular(2.w),
                                          ),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: kColorLightBlueAppBar,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 80,
                                          width: 35.w,
                                          decoration: BoxDecoration(
                                              boxShadow: kElevationToShadow[1],
                                              borderRadius:
                                                  BorderRadius.circular(2.w),
                                              image: DecorationImage(
                                                image: MemoryImage(controller
                                                    .uploadedImageBytes.value),
                                                fit: BoxFit.cover,
                                              ))),
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          // controller.selectedImage.value.e;
                                          await controller.obtainImage(
                                            source: ImageSource.gallery,
                                            id: widget
                                                .serviceMasterSavedValue?.id,
                                          );
                                        },
                                        child: Container(
                                            height: 35,
                                            width: 53.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: kColorLightBlueAppBar,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                  color: kColorlightBlue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ))),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          customDeleteAlertDialogue(context,
                                              () {
                                            controller.deleteImage(
                                              widget.serviceMasterSavedValue
                                                  ?.materialImagePath,
                                              widget
                                                  .serviceMasterSavedValue?.id,
                                            );

                                            Get.back();
                                            controller.isLoading.value = false;
                                          });
                                        },
                                        child: Container(
                                            height: 35,
                                            width: 53.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: kColorRed),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: kColorwhite,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )))
                                  ],
                                )
                              ],
                            ),
                          ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: 1.h,
            ),

            const Divider(),
            if (widget.selectOption == "One Time")
              const Text(
                "Pricing Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            if (widget.selectOption == "One Time") const SizedBox(height: 16.0),
            // Field 5
            if (widget.selectOption == "One Time")
              buildTextField(
                titleController: controller.commissionController,
                label: "Commission",
                keyboardType: TextInputType.number,
                validator: (value) {
                  return null;
                },
                isRequired: false,
              ),
            if (widget.selectOption == "One Time") const SizedBox(height: 8.0),
            if (widget.selectOption == "One Time")
              buildTextField(
                titleController: controller.serviceChargeController,
                label: "Service Charge",
                keyboardType: TextInputType.number,
                isRequired: false,
                  validator: (value) {
                  return null;
                },
              ),
            if (widget.selectOption == "One Time") const SizedBox(height: 8.0),
            // Field 6

            if (widget.selectOption == "One Time") const Divider(),
            const Text(
              "Additional Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Field 8
            TypeAheadField<GetServiceCategoryModel>(
              debounceDuration: const Duration(milliseconds: 500),
              controller: controller.categoryController,
              builder: (context, categoryController, categoryFocusNode) {
                return TextFormField(
                  enabled: true,
                  readOnly: true,
                  focusNode: categoryFocusNode,
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: "Category",
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: kColorblack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0), // Default border
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade300,
                          width: 1.0), // Border when focused
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0), // Border on validation error
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              suggestionsCallback: (pattern) async {
                return await controller.getServiceCategory();
              },
              itemBuilder: (context, GetServiceCategoryModel suggestion) {
                final quotNumber = suggestion;
                return ListTile(
                  title: Text(quotNumber.name!),
                );
              },
              loadingBuilder: (context) {
                return SizedBox(
                    height: 10.h,
                    child: const Center(child: CircularProgressIndicator()));
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
              onSelected: (GetServiceCategoryModel suggestion) {
                categoryValue = suggestion;

                controller.ifUnitSelected.value = true;

                controller.categoryController.text =
                    categoryValue!.name.toString();

                controller.categoryId.value = categoryValue!.id ?? 0;
              },
            ),
            const SizedBox(height: 16.0),
            // Field 7
            if (widget.selectOption == "One Time")
              buildTextField(
                titleController: controller.descriptionController,
                label: "Specification/Description",
                maxLengthCount: 2000,
                isRequired: false,
                  validator: (value) {
                  return null;
                },
              ),
            // const SizedBox(height: 8.0),
            buildTextField(
                titleController: controller.qualifiedTeamMembercontroller,
                label: "Qualified Team Member",
                  validator: (value) {
                  return null;
                },
                functionOntap: () {
                  _showTeamMemberBottomSheet(
                      context: context, controller: controller);
                },
                isRequired: false,
                suffixIcon: IconButton(
                    onPressed: () {
                      _showTeamMemberBottomSheet(
                          context: context, controller: controller);
                    },
                    icon: const Icon(Icons.list))),

            // SizedBox(height: 8.0),
            // Field 9
            TypeAheadField<GetServiceExecutionModel>(
              controller: controller.serviceExecutiModeController,
              debounceDuration: const Duration(milliseconds: 500),
              builder: (context, servExecuController, servExecfocusNode) {
                return TextFormField(
                  enabled: true,
                  readOnly: true,
                  controller: servExecuController,
                  focusNode: servExecfocusNode,
                  decoration: InputDecoration(
                    labelText: "Service Execution Mode",
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: kColorblack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0), // Default border
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade300,
                          width: 1.0), // Border when focused
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0), // Border on validation error
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                return controller.getServiceExecution();
              },
              itemBuilder: (context, GetServiceExecutionModel suggestion) {
                final quotNumber = suggestion;
                return ListTile(
                  title: Text(quotNumber.name!),
                );
              },
              loadingBuilder: (context) {
                return SizedBox(
                    height: 10.h,
                    child: const Center(child: CircularProgressIndicator()));
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
              onSelected: (GetServiceExecutionModel suggestion) {
                executionValue = suggestion;

                // controller.ifUnitSelected.value = true;

                controller.serviceExecutiModeController.text =
                    executionValue!.name.toString();

                controller.executionId.value = executionValue!.id ?? 0;
              },
            ),
            const SizedBox(height: 16.0),

            TypeAheadField<GetServiceExecutionModel>(
              debounceDuration: const Duration(milliseconds: 500),
              controller: controller.availablityController,
              builder: (context, availablityController, availablityFocusNode) {
                return TextFormField(
                  enabled: true,
                  controller: availablityController,
                  focusNode: availablityFocusNode,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Service Availablity",
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: kColorblack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0), // Default border
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade300,
                          width: 1.0), // Border when focused
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0), // Border on validation error
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                return controller.getServiceAvailablity();
              },
              itemBuilder: (context, GetServiceExecutionModel suggestion) {
                final quotNumber = suggestion;
                return ListTile(
                  title: Text(quotNumber.name!),
                );
              },
              loadingBuilder: (context) {
                return SizedBox(
                    height: 10.h,
                    child: const Center(child: CircularProgressIndicator()));
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
              onSelected: (GetServiceExecutionModel suggestion) {
                executionValue = suggestion;

                // controller.ifUnitSelected.value = true;

                controller.availablityController.text =
                    executionValue!.name.toString();

                controller.availablityId.value = executionValue!.id ?? 0;
                print(
                    "${controller.availablityId.value}--controller.availablityId.value");
              },
            ),
            Obx(
              () => controller.availablityId.value == 2
                  ? const SizedBox(height: 16.0)
                  : const SizedBox(),
            ),
            Obx(
              () => controller.availablityId.value == 2
                  ? TextFormField(
                      controller: controller.startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Start Date",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade300,
                              width: 1.0), // Border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0), // Border on validation error
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 1.0), // Focused error border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => DateClass().selectDate(
                            controller.startDateController,
                            false,
                            false,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 16.0),
            Obx(
              () => controller.availablityId.value == 2
                  ? TextFormField(
                      controller: controller.endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "End Date",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade300,
                              width: 1.0), // Border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0), // Border on validation error
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 1.0), // Focused error border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => DateClass().selectDate(
                            controller.endDateController,
                            false,
                            false,
                            isEndDate: true,
                            startDateController: controller.startDateController,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            if (widget.selectOption != "One Time") const SizedBox(height: 8.0),

            if (widget.selectOption != "One Time")
              Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.subscriptionList.isNotEmpty) {
                        print("inside");
                        controller.isdefault.value == false;
                      }
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomPopup(
                                title: "Add",
                                onCancelPressed: () {
                                  controller.serviceFrequencyController.clear();
                                  controller.serviceFrequencyCountController
                                      .clear();
                                  controller.serviceChargeController.clear();
                                  controller.commissionController.clear();
                                  controller.taxController.clear();
                                  controller.commentsController.clear();
                                  controller.taxId.value = 0;

                                  Get.back();
                                },
                                onUpdatePressed: () {
                                  // if (formkey.currentState!.validate()) {
                                  //   print("formkey validated");
                                  // } else {
                                  //   print("formkey not validated");
                                  // }

                                  if (_formKeyPopup.currentState!.validate()) {
                                    print("_formKeyPopup validated");
                                    var value = SubscriptionBasedServices(
                                      comments:
                                          controller.commentsController.text,
                                      commission: int.tryParse(
                                          controller.commissionController.text),
                                      serviceCharge: int.tryParse(controller
                                          .serviceChargeController.text),
                                      serviceFrequencyCount: int.tryParse(
                                          controller
                                              .serviceFrequencyCountController
                                              .text),
                                      serviceFrequencyUom:
                                          controller.timeSpanId.value,
                                      taxId: controller.taxId.value,
                                      timeRequired: null,
                                      timeRequiredCount: null,
                                    );
                                    controller.subscriptionList.add(value);
                                    print(
                                        "subscription--${controller.subscriptionList.toJson()}");

                                    controller.serviceFrequencyController
                                        .clear();
                                    controller.serviceFrequencyCountController
                                        .clear();
                                    controller.serviceChargeController.clear();
                                    controller.commissionController.clear();
                                    controller.taxController.clear();
                                    controller.commentsController.clear();
                                    controller.taxId.value = 0;
                                    Get.back();
                                    // } else {
                                    //   print("not valid ");
                                    // }
                                  } else {
                                    print("_formKeyPopup not validated");
                                  }

                                  // print("outside ${formKey.currentState!.validate()}");

                                  // if (formKey.currentState!.validate()) {
                                  //   print("valid --- add time span id ${controller.timeSpanId.value}");
                                },
                                saveButtonText: "Add",
                                children: [
                                  Form(
                                    key: _formKeyPopup,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        const Text(
                                          "  Service Frequency [Count/Time Span]",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomTextField(
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Enter the count";
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller: controller
                                                      .serviceFrequencyCountController,
                                                  textInputType:
                                                      TextInputType.number,
                                                  label: "Count"),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 0.4.h,
                                                  ),
                                                  TypeAheadField<UOMGetModel>(
                                                    debounceDuration:
                                                        const Duration(
                                                            milliseconds: 500),
                                                    controller: controller
                                                        .serviceFrequencyController,

                                                    builder: (context,
                                                        serviceFrequencyController,
                                                        servFreqfocusNode) {
                                                      return TextFormField(
                                                          enabled: true,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Select the Time Span";
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              serviceFrequencyController,
                                                          focusNode:
                                                              servFreqfocusNode,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Time Span",
                                                            suffixIcon: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                                  kColorblack,
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 2.w),
                                                            labelStyle:
                                                                TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              fontSize: 16.sp,
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  78, 78, 78),
                                                            ),
                                                            errorBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorRed),
                                                            ),
                                                            disabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                            enabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                            border:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                          ));
                                                    },

                                                    // getImmediateSuggestions: true,
                                                    suggestionsCallback:
                                                        controller
                                                            .gettimeSpanList,
                                                    // hideKeyboard: true,
                                                    // hideKeyboardOnDrag: true,

                                                    itemBuilder: (context,
                                                        UOMGetModel
                                                            suggestion) {
                                                      final quotNumber =
                                                          suggestion;
                                                      return ListTile(
                                                        title: Text(
                                                            "${quotNumber.name}"),
                                                      );
                                                    },
                                                    loadingBuilder: (context) {
                                                      return SizedBox(
                                                          height: 10.h,
                                                          child: const Center(
                                                              child:
                                                                  CircularProgressIndicator()));
                                                    },
                                                    emptyBuilder: (context) {
                                                      // customerReceiptController
                                                      //     .nocustomerFound.value = true;

                                                      return SizedBox(
                                                        height: 10.h,
                                                        child: Center(
                                                          child: Text(
                                                            "No items Found",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    13.sp),
                                                          ),
                                                        ),
                                                      );
                                                    },

                                                    onSelected: (UOMGetModel
                                                        suggestion) {
                                                      uomValue = suggestion;

                                                      controller.ifTaxSelected
                                                          .value = true;

                                                      controller
                                                              .serviceFrequencyController
                                                              .text =
                                                          "${uomValue!.name}";

                                                      controller.timeSpanId
                                                              .value =
                                                          uomValue!.id ?? 0;
                                                      print(
                                                          "time span id --${controller.timeSpanId}");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        CustomTextField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter the service charge";
                                              }
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            obscure: false,
                                            textInputType: TextInputType.number,
                                            controller: controller
                                                .serviceChargeController,
                                            label: "Service Charge"),
                                        CustomTextField(
                                            validator: (value) {
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            obscure: false,
                                            textInputType: TextInputType.number,
                                            controller:
                                                controller.commissionController,
                                            label: "Commission"),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        TypeAheadField<TaxesModel>(
                                          debounceDuration:
                                              const Duration(milliseconds: 500),
                                          controller: controller.taxController,

                                          builder: (context, taxController,
                                              taxfocusNode) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 1.w, right: 1.w),
                                              child: TextFormField(
                                                  enabled: true,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Select the Tax";
                                                    }
                                                    return null;
                                                  },
                                                  controller: taxController,
                                                  focusNode: taxfocusNode,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    labelText: "Tax Rate",
                                                    suffixIcon: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: kColorblack,
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 2.w),
                                                    labelStyle: TextStyle(
                                                      overflow:
                                                          TextOverflow.fade,
                                                      fontSize: 16.sp,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 78, 78, 78),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: kColorRed),
                                                    ),
                                                    disabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: kColorgrey),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: kColorgrey),
                                                    ),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: kColorgrey),
                                                    ),
                                                  )),
                                            );
                                          },

                                          // getImmediateSuggestions: true,
                                          suggestionsCallback:
                                              controller.getTaxesList,
                                          // hideKeyboard: true,
                                          // hideKeyboardOnDrag: true,

                                          itemBuilder:
                                              (context, TaxesModel suggestion) {
                                            final quotNumber = suggestion;
                                            return ListTile(
                                              title: Text(
                                                  "${quotNumber.name}@${quotNumber.rate}"),
                                            );
                                          },
                                          loadingBuilder: (context) {
                                            return SizedBox(
                                                height: 10.h,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()));
                                          },
                                          emptyBuilder: (context) {
                                            // customerReceiptController
                                            //     .nocustomerFound.value = true;

                                            return SizedBox(
                                              height: 10.h,
                                              child: Center(
                                                child: Text(
                                                  "No items Found",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.sp),
                                                ),
                                              ),
                                            );
                                          },

                                          onSelected: (TaxesModel suggestion) {
                                            taxValue = suggestion;

                                            controller.ifTaxSelected.value =
                                                true;

                                            controller.taxController.text =
                                                "${taxValue!.name}@${taxValue!.rate}";

                                            controller.taxId.value =
                                                taxValue!.id ?? 0;
                                          },
                                        ),
                                        CustomTextField(
                                            validator: (value) {
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            obscure: false,
                                            controller:
                                                controller.commentsController,
                                            label: "Comments"),
                                      ],
                                    ),
                                  )
                                ]);
                            // if (_formKey.currentState!.validate()) {
                            //   // Handle form submission
                          });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kColorLightBlueAppBar),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Add Subscription details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kColorlightBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: null,
                    child: Obx(() {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.subscriptionList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = controller.subscriptionList[index];

                          return SwipeActionCell(
                            key: UniqueKey(),
                            trailingActions: <SwipeAction>[
                              SwipeAction(
                                  performsFirstActionWithFullSwipe: false,
                                  backgroundRadius: 6.w,
                                  widthSpace: 20.w,
                                  title: "Delete",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kColorwhite),
                                  onTap: (CompletionHandler handler) async {
                                    customDeleteAlertDialogue(
                                      context,
                                      () async {
                                        controller.subscriptionList
                                            .removeAt(index);
                                        Get.back();
                                      },
                                    );
                                  },
                                  color: Colors.red),
                            ],
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 6, left: 1, right: 1),
                              child: FadeInRight(
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: index * 300),
                                child: GestureDetector(
                                  onTap: () async {
                                    await controller.gettimeSpanList("");
                                    controller.isdefault.value =
                                        item.isDefault == 1 ? true : false;
                                    controller.serviceFrequencyCountController
                                            .text =
                                        item.serviceFrequencyCount.toString();
                                    controller.timeSpanId.value =
                                        item.serviceFrequencyUom ?? 0;
                                    controller.serviceChargeController.text =
                                        item.serviceCharge?.toString() ?? "";
                                    controller.commissionController.text =
                                        item.commission?.toString() ?? "";
                                    controller.taxId.value = item.taxId ?? 0;
                                    controller.commentsController.text =
                                        item.comments?.toString() ?? "";

                                    print(
                                        " item.commision 1-- ${item.commission?.toString()}");
                                    print(controller.commentsController.text);
                                    print(controller
                                        .serviceChargeController.text);
                                    print(controller.commissionController.text);

                                    print(item.comments);
                                    print(item.commission);
                                    print(item.serviceCharge);

                                    if (controller.taxList.isNotEmpty) {
                                      var name = controller.taxList
                                          .firstWhere((element) {
                                            print(
                                                "id---${element.id}--${item.taxId}");
                                            return element.id == item.taxId;
                                          })
                                          .name
                                          .toString();

                                      var rate = controller.taxList
                                          .firstWhere((element) {
                                            // print("id-3--${element.id}--${item.taxId}");
                                            return element.id == item.taxId;
                                          })
                                          .rate
                                          .toString();
                                      // print("rate ---${rate}--${name}");
                                      controller.taxController.text =
                                          "$name@$rate";
                                    }

                                    if (controller.timeSpanList.isNotEmpty) {
                                      controller
                                              .serviceFrequencyController.text =
                                          controller.timeSpanList
                                              .firstWhere(
                                                (element) =>
                                                    element.id ==
                                                    item.serviceFrequencyUom,
                                              )
                                              .name
                                              .toString();
                                    }
                                    print(
                                        "frequency id 1--${controller.timeSpanId.value}");

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomPopup(
                                              // ignore: sort_child_properties_last
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow:
                                                        kElevationToShadow[1],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: kColorwhite,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "Is default",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const Spacer(),
                                                        Obx(() => Switch(
                                                              value: controller
                                                                  .isdefault
                                                                  .value,
                                                              onChanged:
                                                                  (value) {
                                                                if (value) {
                                                                  // Set all items' isDefault to 0
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          controller
                                                                              .subscriptionList
                                                                              .length;
                                                                      i++) {
                                                                    controller
                                                                        .subscriptionList[
                                                                            i]
                                                                        .isDefault = 0;
                                                                  }
                                                                  // Set the current item's isDefault to 1
                                                                  controller
                                                                      .subscriptionList[
                                                                          index]
                                                                      .isDefault = 1;
                                                                  controller
                                                                      .isdefault
                                                                      .value = true;
                                                                } else {
                                                                  // Allow turning off default status
                                                                  controller
                                                                      .subscriptionList[
                                                                          index]
                                                                      .isDefault = 0;
                                                                  controller
                                                                      .isdefault
                                                                      .value = false;
                                                                }
                                                                // Update the UI
                                                                controller
                                                                    .subscriptionList
                                                                    .refresh();
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                const Text(
                                                  "  Service Frequency [Count/Time Span]",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomTextField(
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "Enter the count";
                                                            }
                                                            return null;
                                                          },
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          obscure: false,
                                                          controller: controller
                                                              .serviceFrequencyCountController,
                                                          textInputType:
                                                              TextInputType
                                                                  .number,
                                                          label: "Count"),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 0.4.h,
                                                          ),
                                                          TypeAheadField<
                                                              UOMGetModel>(
                                                            debounceDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            controller: controller
                                                                .serviceFrequencyController,

                                                            builder: (context,
                                                                serviceFrequencyController,
                                                                servFreqfocusNode) {
                                                              return TextFormField(
                                                                  enabled: true,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return "Select the Time Span";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  controller:
                                                                      serviceFrequencyController,
                                                                  focusNode:
                                                                      servFreqfocusNode,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        "Time Span",
                                                                    suffixIcon:
                                                                        Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color:
                                                                          kColorblack,
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                2.w),
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                      fontSize:
                                                                          16.sp,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          78,
                                                                          78,
                                                                          78),
                                                                    ),
                                                                    errorBorder:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: kColorRed),
                                                                    ),
                                                                    disabledBorder:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: kColorgrey),
                                                                    ),
                                                                    enabledBorder:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: kColorgrey),
                                                                    ),
                                                                    border:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: kColorgrey),
                                                                    ),
                                                                  ));
                                                            },

                                                            // getImmediateSuggestions: true,
                                                            suggestionsCallback:
                                                                controller
                                                                    .gettimeSpanList,
                                                            // hideKeyboard: true,
                                                            // hideKeyboardOnDrag: true,

                                                            itemBuilder: (context,
                                                                UOMGetModel
                                                                    suggestion) {
                                                              final quotNumber =
                                                                  suggestion;
                                                              return ListTile(
                                                                title: Text(
                                                                    "${quotNumber.name}"),
                                                              );
                                                            },
                                                            loadingBuilder:
                                                                (context) {
                                                              return SizedBox(
                                                                  height: 10.h,
                                                                  child: const Center(
                                                                      child:
                                                                          CircularProgressIndicator()));
                                                            },
                                                            emptyBuilder:
                                                                (context) {
                                                              // customerReceiptController
                                                              //     .nocustomerFound.value = true;

                                                              return SizedBox(
                                                                height: 10.h,
                                                                child: Center(
                                                                  child: Text(
                                                                    "No items Found",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            13.sp),
                                                                  ),
                                                                ),
                                                              );
                                                            },

                                                            onSelected:
                                                                (UOMGetModel
                                                                    suggestion) {
                                                              uomValue =
                                                                  suggestion;

                                                              controller
                                                                  .ifTaxSelected
                                                                  .value = true;

                                                              controller
                                                                      .serviceFrequencyController
                                                                      .text =
                                                                  "${uomValue!.name}";

                                                              controller
                                                                      .timeSpanId
                                                                      .value =
                                                                  uomValue!
                                                                          .id ??
                                                                      0;
                                                              print(
                                                                  "time span id --${controller.timeSpanId}");
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                CustomTextField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter the service charge";
                                                      }
                                                      return null;
                                                    },
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    obscure: false,
                                                    textInputType:
                                                        TextInputType.number,
                                                    controller: controller
                                                        .serviceChargeController,
                                                    label: "Service Charge"),
                                                CustomTextField(
                                                    validator: (value) {
                                                      return null;
                                                    },
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    obscure: false,
                                                    textInputType:
                                                        TextInputType.number,
                                                    controller: controller
                                                        .commissionController,
                                                    label: "Commission"),
                                                SizedBox(
                                                  height: 1.h,
                                                ),

                                                TypeAheadField<TaxesModel>(
                                                  debounceDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  controller:
                                                      controller.taxController,

                                                  builder: (context,
                                                      taxController,
                                                      taxfocusNode) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.w,
                                                          right: 1.w),
                                                      child: TextFormField(
                                                          enabled: true,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Select the Tax";
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              taxController,
                                                          focusNode:
                                                              taxfocusNode,
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Tax Rate",
                                                            suffixIcon: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                                  kColorblack,
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 2.w),
                                                            labelStyle:
                                                                TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              fontSize: 16.sp,
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  78, 78, 78),
                                                            ),
                                                            errorBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorRed),
                                                            ),
                                                            disabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                            enabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                            border:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                          )),
                                                    );
                                                  },

                                                  // getImmediateSuggestions: true,
                                                  suggestionsCallback:
                                                      controller.getTaxesList,
                                                  // hideKeyboard: true,
                                                  // hideKeyboardOnDrag: true,

                                                  itemBuilder: (context,
                                                      TaxesModel suggestion) {
                                                    final quotNumber =
                                                        suggestion;
                                                    return ListTile(
                                                      title: Text(
                                                          "${quotNumber.name}@${quotNumber.rate}"),
                                                    );
                                                  },
                                                  loadingBuilder: (context) {
                                                    return SizedBox(
                                                        height: 10.h,
                                                        child: const Center(
                                                            child:
                                                                CircularProgressIndicator()));
                                                  },
                                                  emptyBuilder: (context) {
                                                    // customerReceiptController
                                                    //     .nocustomerFound.value = true;

                                                    return SizedBox(
                                                      height: 10.h,
                                                      child: Center(
                                                        child: Text(
                                                          "No items Found",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13.sp),
                                                        ),
                                                      ),
                                                    );
                                                  },

                                                  onSelected:
                                                      (TaxesModel suggestion) {
                                                    taxValue = suggestion;

                                                    controller.ifTaxSelected
                                                        .value = true;

                                                    controller.taxController
                                                            .text =
                                                        "${taxValue!.name}@${taxValue!.rate}";

                                                    controller.taxId.value =
                                                        taxValue!.id ?? 0;
                                                  },
                                                ),
                                                CustomTextField(
                                                    validator: (value) {
                                                      return null;
                                                    },
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    obscure: false,
                                                    controller: controller
                                                        .commentsController,
                                                    label: "Comments"),
                                                // CustomTextField(
                                                //     validator: (value) {
                                                //       return null;
                                                //     },
                                                //     textInputAction: TextInputAction.next,
                                                //     obscure: false,
                                                //     controller: controller.taxController,
                                                //     label: "Tax Rate"),
                                              ],
                                              title: "Edit",
                                              onCancelPressed: () {
                                                controller
                                                    .serviceFrequencyController
                                                    .clear();
                                                controller
                                                    .serviceFrequencyCountController
                                                    .clear();
                                                controller
                                                    .serviceChargeController
                                                    .clear();
                                                controller.commissionController
                                                    .clear();
                                                controller.taxController
                                                    .clear();
                                                controller.commentsController
                                                    .clear();
                                                controller.taxId.value = 0;

                                                Get.back();
                                              },
                                              onUpdatePressed: () {
                                                print(controller
                                                    .commentsController.text);
                                                print(
                                                    "serv charge ---${controller.serviceChargeController.text}");
                                                print(
                                                    "commision 456--${controller.commissionController.text}");

                                                print(item.comments);

                                                print(
                                                    "commission--${item.commission}");
                                                print(
                                                    "servce charge--${item.serviceCharge}");

                                                var updatedValue =
                                                    SubscriptionBasedServices(
                                                  id: widget.isedit == true
                                                      ? item.id
                                                      : null,
                                                  comments: controller
                                                      .commentsController.text,
                                                  commission: double.tryParse(
                                                          controller
                                                              .commissionController
                                                              .text)
                                                      ?.toInt(), // Convert to int if necessary
                                                  isDefault: controller
                                                              .isdefault
                                                              .value ==
                                                          false
                                                      ? 0
                                                      : 1,
                                                  serviceCharge: double
                                                          .tryParse(controller
                                                              .serviceChargeController
                                                              .text)
                                                      ?.toInt(), // Convert to int if necessary
                                                  serviceFrequencyCount:
                                                      int.tryParse(controller
                                                          .serviceFrequencyCountController
                                                          .text),
                                                  serviceFrequencyUom:
                                                      controller
                                                          .timeSpanId.value,
                                                  taxId: controller.taxId.value,
                                                  timeRequired: null,
                                                  timeRequiredCount: null,
                                                );
                                                controller.subscriptionList[
                                                    index] = updatedValue;
                                                print(updatedValue.comments);
                                                print(
                                                    "commission-1-${updatedValue.commission}");
                                                print(
                                                    "servce charge-1-${updatedValue.serviceCharge}");

                                                print(
                                                    "subscription list ${controller.subscriptionList.toJson()}");

                                                controller
                                                    .serviceFrequencyController
                                                    .clear();
                                                controller
                                                    .serviceFrequencyCountController
                                                    .clear();
                                                controller
                                                    .serviceChargeController
                                                    .clear();
                                                controller.commissionController
                                                    .clear();
                                                controller.taxController
                                                    .clear();
                                                controller.commentsController
                                                    .clear();
                                                controller.taxId.value = 0;
                                                Get.back();
                                              },
                                              saveButtonText: "Edit");
                                          // if (_formKey.currentState!.validate()) {
                                          //   // Handle form submission
                                        });
                                  },
                                  child: Container(
                                    // height: 5.h,
                                    decoration: BoxDecoration(
                                      boxShadow: kElevationToShadow[1],
                                      borderRadius: BorderRadius.circular(10),
                                      color: kColorwhite,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "Service Frequency",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: kColorblack,
                                            fontSize: 15.sp),
                                      ),
                                      subtitle: Text(
                                        "${item.serviceFrequencyCount} ${controller.timeSpanList.firstWhere(
                                              (element) =>
                                                  element.id ==
                                                  item.serviceFrequencyUom,
                                            ).name?.toString() ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kColorblack,
                                            fontSize: 15.sp),
                                      ),
                                      trailing: item.isDefault == 1
                                          ? Obx(() {
                                              return Switch(
                                                value:
                                                    controller.isdefault.value,
                                                // activeColor: Colors.green,
                                                onChanged: (value) {
                                                  if (value) {
                                                    controller.isdefault.value =
                                                        value;
                                                    for (var i = 0;
                                                        i <
                                                            controller
                                                                .subscriptionList
                                                                .length;
                                                        i++) {
                                                      if (i != index) {
                                                        controller
                                                            .subscriptionList[i]
                                                            .isDefault = 0;
                                                      }
                                                    }
                                                    controller
                                                        .subscriptionList[index]
                                                        .isDefault = 1;
                                                  } else {
                                                    controller
                                                        .subscriptionList[index]
                                                        .isDefault = 0;
                                                    controller.isdefault.value =
                                                        false;
                                                  }
                                                  // controller.isdefault.value = value;
                                                  // if (controller.isdefault.value == true) {
                                                  //   controller.isAlreadyDefault.value = true;
                                                  // } else if (controller.isdefault.value == false) {
                                                  //   print("false");
                                                  //   controller.isdefault.value = value;
                                                  //   controller.isAlreadyDefault.value = false;
                                                  // }
                                                },
                                              );
                                            })
                                          : const SizedBox(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

void _showTeamMemberBottomSheet(
    {required BuildContext context,
    required ServiceMasterController controller}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.w), topRight: Radius.circular(5.w))),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return TeamMemberBottomSheet(
        controller: controller,
      );
    },
  );
}
