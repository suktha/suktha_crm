import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/Model/material_models.dart';
import 'package:suktha_crm/controllers/lead_contact_details_controller.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/add_lead_screen/add_new_lead_managment.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

class ShowSelectedContactsScreen extends StatefulWidget {
  final LeadContactDetaisController contactController;
  final List<MaterialModel>? materialList;
  final List<MaterialModel>? serviceList;
  ShowSelectedContactsScreen({super.key, required this.contactController, this.materialList, this.serviceList});

  @override
  State<ShowSelectedContactsScreen> createState() => _ShowSelectedContactsScreenState();
}

class _ShowSelectedContactsScreenState extends State<ShowSelectedContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorwhite,
        elevation: 0,
        title: Text(
          "Selected Leads",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kColorblack),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 17,
            color: kColorblack,
          ),
        ),
      ),
      // backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10, top: 2.h),
                child: Text(
                  "Please ensure that this step is completed before saving, as it is mandatory for successful submission",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: kColorgreyShade500),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() => widget.contactController.leadList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FadeIn(
                                  delay: const Duration(milliseconds: 300),
                                  duration: const Duration(milliseconds: 300),
                                  child: LottieBuilder.asset(
                                    emptyLottie,
                                    height: 30.w,
                                  )),
                              SizedBox(
                                height: 3.h,
                              ),
                              FadeIn(
                                delay: const Duration(milliseconds: 500),
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  "No Leads",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Obx(() {
                      return Expanded(
                        flex: 29,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.contactController.leadList.length,
                          itemBuilder: (context, index) {
                            var contact = widget.contactController.leadList[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(color: kColorLightGrey, borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(contact.leadName ?? ""),
                                    subtitle: Obx(() {
                                      // print("ismandatoryfield 2===== ${widget.contactController.isMandatoryFieldAdded[index]}");
                                      return widget.contactController.isMandatoryFieldAdded[index]
                                          ? Text(
                                              "Mandatory field added successfully",
                                              style: TextStyle(color: Colors.green),
                                            )
                                          : Text(
                                              "Please add Mandatory fields",
                                              style: TextStyle(color: kColorRed),
                                            );
                                    }),
                                    trailing: Obx(() => widget.contactController.isMandatoryFieldAdded[index]
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                print("insidehcdjhfdgfd");

                                                Get.to(() => NewLeadManagementAddScreen(
                                                      isEdit: false,
                                                      AddFromContacts: false,
                                                      editFromContacts: true,
                                                      leadValue: widget.contactController.leadList[index],
                                                      materialList: widget.materialList ?? [],
                                                      serviceList: widget.serviceList ?? [],
                                                      IndexOfMandatoryField: index,
                                                    ));
                                              });
                                            },
                                            icon: Container(child: Icon(Icons.edit)))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                print("inside");
                                                Get.to(() => NewLeadManagementAddScreen(
                                                      isEdit: false,
                                                      AddFromContacts: true,
                                                      materialList: widget.materialList ?? [],
                                                      serviceList: widget.serviceList ?? [],
                                                      leadValue: contact,
                                                      IndexOfMandatoryField: index,
                                                    ));
                                              });
                                            },
                                            icon: Container(
                                                decoration: BoxDecoration(color: kColorwhite, border: Border.all(color: kColorlightBlue), borderRadius: BorderRadius.circular(12)),
                                                child: Icon(Icons.add)))),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    })),
              Spacer(),
              Obx(() {
                widget.contactController.allMandatoryFieldsAdded.value = widget.contactController.leadList.asMap().entries.every(
                  (entry) {
                    int index = entry.key;
                    return widget.contactController.isMandatoryFieldAdded[index] == true;
                  },
                );
                return Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: widget.contactController.allMandatoryFieldsAdded.value && widget.contactController.leadList.isNotEmpty ? kColorlightBlue : kColorLightGrey,
                          elevation: 5,
                        ),
                        onPressed: widget.contactController.allMandatoryFieldsAdded.value
                            ? () {
                                print("LeadSaveing item === ${widget.contactController.leadList}");
                                widget.contactController.saveAllLeadFromContacts(widget.contactController.leadList);
                                // Add your save logic here
                                // This will only be executed if all mandatory fields are added
                              }
                            : () {
                                customSnackbar("Error", "Add mandatory fields for every selected leads", "error");
                              },
                        child: Text(
                          "Save All",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: widget.contactController.allMandatoryFieldsAdded.value && widget.contactController.leadList.isNotEmpty ? kColorwhite : kColorgreyShade400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
