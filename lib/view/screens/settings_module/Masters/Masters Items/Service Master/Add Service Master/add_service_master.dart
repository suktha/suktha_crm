// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/service_material_model.dart';
import 'package:work_Force/Model/subscription_based_service_model.dart';
import 'package:work_Force/controllers/service_master_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Service%20Master/Add%20Service%20Master/screens/oneTime_sub_screen.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Service%20Master/View%20Service%20Master/list_service_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class AddServiceMasterScreen extends StatefulWidget {
  final bool isEdit;
  ServiceMaterialListModel? serviceMasterSavedValue;
  SubscriptionBasedServices? subItemValue;
  bool? isFromLead;
  int? indexes;

  AddServiceMasterScreen(
      {super.key,
      required this.isEdit,
      this.serviceMasterSavedValue,
      this.subItemValue,
      this.isFromLead,
      this.indexes});

  @override
  State<AddServiceMasterScreen> createState() => _AddServiceMasterScreenState();
}

class _AddServiceMasterScreenState extends State<AddServiceMasterScreen> {
  final controller = Get.put(ServiceMasterController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    widget.isEdit ? isEdited(widget.indexes ?? 0) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: IconButton(
                      onPressed: () {
                        Get.offAll(ServiceMasterScreen());
                      },
                      icon: Icon(
                        Icons.close,
                        color: kColorblack,
                      ),
                    ),
                  )
                ],
                title: const Text("Service Master"),
                titleTextStyle: TextStyle(
                    color: kColorblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp),
                centerTitle: true,
                backgroundColor: kColorwhite,
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOptionButton("One Time"),
                      // Spacer(),
                      // const SizedBox(width: 10),
                      _buildOptionButton("Subscription"),
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: kColorblack,
                    size: 25.sp,
                  ),
                  onPressed: (() {
                    clearFunction();
                    Get.back();
                  }),
                )),
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  Obx(() => Expanded(
                          child: BuildOneTimeAndSubScreen(
                        formkey: _formKey,
                        selectOption: controller.selectedOption.value,
                        isedit: widget.isEdit,
                        serviceMasterSavedValue: widget.serviceMasterSavedValue,
                      ))),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        // print("outside formkey ${_formKey.currentState!.validate()}");

                        if (_formKey.currentState!.validate()) {
                          print(
                              "inside formkey ${_formKey.currentState!.validate()}");
                          final hasDefaultSubscription = controller
                              .subscriptionList
                              .any((element) => element.isDefault == 1);

                          if (controller.selectedOption.value == "One Time"
                              ? true
                              : hasDefaultSubscription) {
                            print(
                                "inside true ${_formKey.currentState!.validate()}");

                            controller.saveMaterialValue =
                                ServiceMaterialListModel(
                              aliasName: null,
                              attributeAndValues: [],
                              buyingPrice: null,
                              categoryId: controller.categoryId.value == 0
                                  ? null
                                  : controller.categoryId.value,
                              cessPercentage: null,
                              commission:
                                  controller.commissionController.text == ""
                                      ? null
                                      : controller.commissionController.text,
                              companyId: 1,
                              deleted: null,
                              discountPercentage: null,
                              hsnCode:
                                  int.tryParse(controller.sacController.text),
                              id: widget.isEdit == true
                                  ? widget.serviceMasterSavedValue!.id
                                  : null,
                              isBomExists: null,
                              isContainer: 0,
                              materialImagePath: controller.fileName.value == ""
                                  ? null
                                  : controller.fileName.value,
                              materialTypeId: null,
                              materialTypeName: null,
                              minimumStock: null,
                              mrp: null,
                              name: controller.nameController.text,
                              openingStock: 0,
                              outName: null,
                              outPartNumber: null,
                              partNumber: null,
                              partyId: null,
                              price:
                                  controller.serviceChargeController.text == ""
                                      ? null
                                      : controller.serviceChargeController.text,
                              qualifiedTeamMembers: widget.isEdit == true
                                  ? widget.serviceMasterSavedValue!
                                          .qualifiedTeamMembers!.isEmpty
                                      ? controller.selectedTeamMember
                                          .map((element) => element.id!)
                                          .toList()
                                      : widget.serviceMasterSavedValue!
                                          .qualifiedTeamMembers
                                  : controller.selectedTeamMember.isEmpty
                                      ? null
                                      : controller.selectedTeamMember
                                          .map((element) => element.id!)
                                          .toList(),
                              serviceAvailability:
                                  controller.availablityId.value,
                              serviceEndDate:
                                  controller.endDateController.text == ""
                                      ? null
                                      : DateClass().parseDate(
                                          controller.endDateController.text),
                              serviceExecutionModeId:
                                  controller.executionId.value == 0
                                      ? null
                                      : controller.executionId.value,
                              serviceStartDate:
                                  controller.startDateController.text == ""
                                      ? null
                                      : DateClass().parseDate(
                                          controller.startDateController.text),
                              serviceStatus: controller.serviceStatusId.value,
                              serviceType:
                                  controller.selectedOption.value == "One Time"
                                      ? 1
                                      : 2,
                              specification:
                                  controller.descriptionController.text == ""
                                      ? null
                                      : controller.descriptionController.text,
                              stock: 0,
                              subscriptionBasedServices:
                                  controller.subscriptionList,
                              supplyTypeId: 2,
                              taxId: controller.taxId.value == 0
                                  ? null
                                  : controller.taxId.value,
                              unitOfMeasurementId: controller.unitId,
                              unitOfMeasurementName:
                                  controller.uomController.text,
                            );

                            print(
                                "SAVE SERVICE FILE NAME / IMAGE NAME ${DateClass().parseDate(controller.startDateController.text)}");

                            if (widget.isEdit == true) {
                              controller.saveServiceMaster(false);
                            } else {
                              await controller.checkName(
                                controller.nameController.text,
                                widget.serviceMasterSavedValue?.id.toString() ??
                                    "",
                                widget.isFromLead,
                                context,
                              );
                            }
                          } else {
                            customSnackbar(
                                "Error",
                                "Please make atleast any one Subscription as default...",
                                "error");
                          }
                          // Handle form submission
                        } else {
                          customSnackbar(
                              "Error", "Enter mandatory fields", "error");
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: kColorlightBlue),
                        child: Text(
                          widget.isEdit == true ? "Update" : "Save",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kColorwhite,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Obx(() => loadingScreenWithText(
            isPageLoading: controller.isPageLoading.value)),
      ],
    );
  }

  isEdited(int index) async {
    controller.isPageLoading.value = true;

    final item = widget.serviceMasterSavedValue;
    print("id--${item!.id}");
    await controller.getImageById(item.id);
    controller.selectedOption.value =
        item.serviceType == 1 ? "One Time" : "Subscription";
    controller.nameController.text = item.name ?? "";
    controller.sacController.text = item.hsnCode?.toString() ?? "";
    controller.uomController.text = item.unitOfMeasurementName ?? "";
    controller.serviecStatusController.text = item.specification ?? "";
    controller.serviceChargeController.text = item.price?.toString() ?? "0.00";
    controller.descriptionController.text = item.specification ?? "";
    controller.commissionController.text = item.commission?.toString() ?? "";
    controller.startDateController.text = item.serviceStartDate == null
        ? ""
        : DateClass().showDate(item.serviceStartDate ?? "");
    controller.endDateController.text = item.serviceEndDate == null
        ? ""
        : DateClass().showDate(item.serviceEndDate ?? "");
    controller.fileName.value = item.materialImagePath ?? "";
    await controller.getTaxesList("");
    if (item.taxId != null) {
      var taxId = item.taxId;

      var variable = controller.taxList
          .firstWhere((e) => e.id.toString() == taxId.toString());

      controller.taxController.text = "${variable.name}@${variable.rate}";
      controller.taxId.value = variable.id ?? 0;
    }
    await controller.getServiceStatus();
    await controller.getServiceAvailablity();
    await controller.getServiceCategory();
    await controller.getServiceExecution();
    await controller.getTeamMemberList();
    await controller.getUnitLists("");
    await controller.gettimeSpanList("");

    controller.subscriptionList.value = item.subscriptionBasedServices ?? [];
    if (controller.subscriptionList.isNotEmpty) {
      print(
          "list--serviceFrequencyUom ${controller.subscriptionList[0].serviceFrequencyUom}");
    }
    await controller.initializeDefaultState();

    print("list--is default-${controller.isdefault.value}");

    if (item.serviceStatus != null) {
      var serviceStatusId = item.serviceStatus;

      var variable = controller.serviceStatusList
          .firstWhere((e) => e.id.toString() == serviceStatusId.toString());

      controller.serviecStatusController.text = "${variable.name}";
    }

    if (item.serviceAvailability != null) {
      var serviceAvailabilityId = item.serviceAvailability;

      var variable = controller.serviceAvailablityList.firstWhere(
          (e) => e.id.toString() == serviceAvailabilityId.toString());

      controller.availablityController.text = "${variable.name}";
      controller.availablityId.value = variable.id ?? 0;
    }
    if (item.unitOfMeasurementId != null) {
      controller.unitId = item.unitOfMeasurementId ?? 0;
      controller.uomController.text = item.unitOfMeasurementName ?? "";
    }
    print("item.categoryId--${item.categoryId}");

    if (item.categoryId != null) {
      var categoryId = item.categoryId;

      var variable = controller.serviceCategoryList
          .firstWhere((e) => e.id.toString() == categoryId.toString());

      controller.categoryController.text = "${variable.name}";
      controller.categoryId.value = variable.id ?? 0;
    }
    if (item.serviceExecutionModeId != null) {
      var serviceExecutionModeId = item.serviceExecutionModeId;

      var variable = controller.serviceExecutionList.firstWhere(
          (e) => e.id.toString() == serviceExecutionModeId.toString());

      controller.serviceExecutiModeController.text = "${variable.name}";
      controller.executionId.value = variable.id ?? 0;
    }

    print("qualified members --${item.qualifiedTeamMembers}");

    if (item.qualifiedTeamMembers != null &&
        item.qualifiedTeamMembers!.isNotEmpty) {
      var qualifiedTeamMembersIds = item.qualifiedTeamMembers;
      print("id--$qualifiedTeamMembersIds");

      var teamMemberNames = qualifiedTeamMembersIds!
          .map((id) {
            var matchedUnit = controller.teamMemberList.firstWhere((e) {
              // print("ids---${e.id}");
              return e.id.toString() == id.toString();
            });
            return matchedUnit.name;
          })
          .where((name) => name != null)
          .toList();

      controller.qualifiedTeamMembercontroller.text =
          teamMemberNames.join(', ');

      print(
          "qualified members --${controller.qualifiedTeamMembercontroller.text}");
    } else {
      controller.qualifiedTeamMembercontroller.text =
          ""; // Clear the field if no data
    }

    controller.isPageLoading.value = false;
  }

  // Option Button
  Widget _buildOptionButton(String option) {
    return GestureDetector(
      onTap: () => controller.setOption(option),
      child: Obx(() => Container(
            width: 44.w,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[1],
              color: controller.selectedOption.value == option
                  ? kColorLightBlueAppBar
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: controller.selectedOption.value == option
                      ? Colors.transparent
                      : Colors.grey.shade100),
            ),
            child: Text(
              option,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: controller.selectedOption.value == option
                    ? Colors.blue
                    : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }

  // One Time Screen

  clearFunction() {
    controller.serviceFrequencyCountController.clear();
    controller.serviceFrequencyController.clear();
    controller.serviceChargeController.clear();
    controller.commissionController.clear();
    controller.taxController.clear();
    controller.commentsController.clear();
    controller.uomController.clear();
    controller.serviecStatusController.clear();
    controller.sacController.clear();
    controller.categoryController.clear();
    controller.descriptionController.clear();
    controller.qualifiedTeamMembercontroller.clear();
    controller.serviceExecutiModeController.clear();
    controller.startDateController.clear();
    controller.endDateController.clear();
    controller.availablityController.clear();
  }

  // Custom Text Field
}

class TeamMemberBottomSheet extends StatefulWidget {
  final ServiceMasterController controller;
  const TeamMemberBottomSheet({super.key, required this.controller});

  @override
  State<TeamMemberBottomSheet> createState() => _TeamMemberBottomSheetState();
}

class _TeamMemberBottomSheetState extends State<TeamMemberBottomSheet> {
  // final controller = Get.put(LeadReportsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 90.h,
          child: Padding(
            padding:
                EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.h, right: 2.h),
            child: Column(
              children: [
                Text("Select Assign To",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(height: 2.h),
                SizedBox(height: 2.h),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.controller.teamMemberList.length,
                    itemBuilder: (context, index) {
                      final item = widget.controller.teamMemberList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.controller.selectedTeamMember
                                .contains(item)) {
                              widget.controller.selectedTeamMember.remove(item);
                            } else {
                              widget.controller.selectedTeamMember.add(item);
                            }
                          });
                        },
                        child: ListTile(
                          title: Text(item.name!),
                          trailing: Checkbox(
                            value: widget.controller.selectedTeamMember
                                .contains(item),
                            onChanged: (bool? value) {
                              setState(() {
                                if (widget.controller.selectedTeamMember
                                    .contains(item)) {
                                  widget.controller.selectedTeamMember
                                      .remove(item);
                                } else {
                                  widget.controller.selectedTeamMember
                                      .add(item);
                                }
                                widget.controller.qualifiedTeamMembercontroller
                                        .text =
                                    widget.controller.selectedTeamMember
                                        .map((item) => item.name)
                                        .join(', ');
                                widget.controller.teamMemberId.value =
                                    widget.controller.selectedTeamMember
                                        .map(
                                          (item) => item.id.toString(),
                                        )
                                        .join(",");
                                print(
                                    "user id ---- ${widget.controller.teamMemberId.value}");

                                print(widget.controller
                                    .qualifiedTeamMembercontroller.text);
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
