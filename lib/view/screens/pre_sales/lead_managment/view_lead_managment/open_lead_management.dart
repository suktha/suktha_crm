import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/controllers/get_lead_controller.dart';
import 'package:suktha_crm/controllers/lead_controller.dart';
import 'package:suktha_crm/utils/Date.dart';
import 'package:suktha_crm/utils/responsive_utils.dart';
import 'package:suktha_crm/view/screens/pre_sales/get_location/controller/get_location_controller.dart';
import 'package:suktha_crm/view/screens/pre_sales/get_location/widget/get_location_widget.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/add_lead_screen/add_new_lead_managment.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:suktha_crm/view/screens/pre_sales/widget/document_wallet.dart';
import 'package:suktha_crm/view/screens/pre_sales/widget/share_doc_nd_history.dart';
import 'package:suktha_crm/view/widget/custom_button.dart';
import 'package:suktha_crm/view/widget/icon_button.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../../../../../../../../Model/material_models.dart';

// ignore: must_be_immutable
class OpenLeadManagementScreen extends StatefulWidget {
  final LeadModel leadValue;
  final List<MaterialModel> materialList;
  final List<MaterialModel> serviceList;
  final int index;

  OpenLeadManagementScreen({
    super.key,
    required this.leadValue,
    required this.materialList,
    required this.serviceList,
    required this.index,
  });

  @override
  State<OpenLeadManagementScreen> createState() => _OpenLeadManagementScreenState();
}

class _OpenLeadManagementScreenState extends State<OpenLeadManagementScreen> {
  @override
  void initState() {
    super.initState();
    initialData();
  }

  final controller = Get.put(LeadController());
  final getcontroller = Get.put(GetLeadController());
  final locController = Get.put(GetLocationController());

  // final UserManagementController userManagementController = Get.put(UserManagementController());

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);

    // print(userManagementController.isLoading.value);

    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              title: const Text("Lead Management"),
              titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 19.sp),
              centerTitle: true,
              backgroundColor: kColortransparent,
              elevation: 0,
              actions: [
                PopupMenuButton(
                    icon: Icon(
                      Icons.menu,
                      color: kColorblack,
                    ),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () async {
                              await getcontroller.getDocumentWalletList(leadId: widget.leadValue.id!);
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return LeadDocumentWalletScreen(controller: getcontroller, leadValue: widget.leadValue);
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.upload_file, color: kColorblack),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Text(
                                  "Document wallet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              print("pressed");
                              getcontroller.getLeadHistory(widget.leadValue.id ?? "");
                              await bottomSheetHistoryCustom(context, widget.leadValue, width, () async {
                                getcontroller.LeadHistoryLists.clear();
                                await getcontroller.getLeadHistory(widget.leadValue.id ?? "");
                              }, getcontroller);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.history, color: kColorblack),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Text(
                                  "Lead Progress Tracker",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              print("pressed");

                              await getcontroller.getSharedDocHistory(leadId: widget.leadValue.id!);
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  builder: (context) {
                                    return ShareDocNdHistory(
                                      controller: getcontroller,
                                      leadValue: widget.leadValue,
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.share_outlined, color: kColorblack),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Text(
                                  "Share Document & History",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              print("pressed");
                              print(widget.leadValue.leadGeoLocation);
                              if (widget.leadValue.leadGeoLocation == null || widget.leadValue.leadGeoLocation == "${null},${null}") {
                                // Location not added yet, so add location
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  useSafeArea: true,
                                  builder: (context) => LocationWidget(
                                    index: widget.index,
                                    LeadValueList: getcontroller.leadList,
                                    leadValue: widget.leadValue,
                                    IsClikedLocation: true,
                                    materialList: getcontroller.materialLists,
                                    serviceList: getcontroller.serviceLists,
                                  ),
                                );
                                // locController.getCurrentLocation(item);
                              } else {
                                List<String> latLong = widget.leadValue.leadGeoLocation.split(",");
                                locController.latitudeController.text = latLong[1];
                                locController.longitudeController.text = latLong[0];
                                print("location latitude ${locController.latitudeController.text}");
                                print("location longitude ${locController.longitudeController.text}");

                                var lat = double.tryParse(locController.latitudeController.text);
                                var long = double.tryParse(locController.longitudeController.text);

                                // Location already added, so get location and open maps
                                await locController.openGoogleMaps(lat ?? 0.0, long ?? 0.0);
                              }
                              // controller.getLeadHistory(item.id ?? "");
                            },
                            child: Row(
                              children: [
                                widget.leadValue.leadGeoLocation == null || widget.leadValue.leadGeoLocation == "${null},${null}"
                                    ? Icon(Icons.add_location_alt, color: kColorblack)
                                    : Icon(Icons.location_on, color: Colors.green),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Text(
                                  widget.leadValue.leadGeoLocation == null || widget.leadValue.leadGeoLocation == "${null},${null}" ? "Add location" : "View location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: widget.leadValue.leadGeoLocation == null || widget.leadValue.leadGeoLocation == "${null},${null}" ? Colors.black : Colors.green),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            enabled: widget.leadValue.leadGeoLocation != null,
                            onTap: () async {
                              print("pressed");
                              print(widget.leadValue.leadGeoLocation);

                              // Location not added yet, so add location
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                useSafeArea: true,
                                builder: (context) => LocationWidget(
                                  index: widget.index,
                                  LeadValueList: getcontroller.leadList,
                                  leadValue: widget.leadValue,
                                  IsClikedLocation: true,
                                  materialList: getcontroller.materialLists,
                                  serviceList: getcontroller.serviceLists,
                                ),
                              );
                              // locController.getCurrentLocation(item);

                              // controller.getLeadHistory(item.id ?? "");
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add_location_alt, color: kColorblack),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Text(
                                  "Update Location",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          // PopupMenuItem(
                          //   child: Row(
                          //     children: [
                          //       Icon(Icons.edit, color: kColorblack),
                          //       SizedBox(
                          //         width: 2.h,
                          //       ),
                          //       Text(
                          //         "Edit",
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          PopupMenuItem(
                            onTap: () {
                              print("id-----${widget.leadValue.id ?? ""}");
                              getcontroller.deleteLead(widget.leadValue.id ?? "");
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: kColorRed),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: kColorRed),
                                ),
                              ],
                            ),
                          )
                        ]),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: kColorblack,
                  size: 25.sp,
                ),
                onPressed: (() {
                  Get.off(() => LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                }),
              )),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 12.h, left: 5.w, right: 5.w, bottom: 2.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w), bottomRight: Radius.circular(10.w)),
                    boxShadow: kElevationToShadow[2],
                    gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      Color.fromARGB(255, 220, 246, 255),
                      Color.fromARGB(255, 62, 194, 255),
                    ])),
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.leadValue.leadGenerationNumber ?? "", //////transaction number
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.sp),
                        ),
                        Text(
                          widget.leadValue.statusName ?? "", //////status
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Lead Name : " + widget.leadValue.leadName.toString(), // party name
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Contact Person : ${widget.leadValue.contactPerson?.toString() ?? ""}",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        widget.leadValue.mobileNo != ""
                            ? GestureDetector(
                                onTap: () {
                                  var url = Uri.parse("tel:${widget.leadValue.mobileNo}");
                                  urlLauncher.launchUrl(url);
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: width * 0.04,
                                      backgroundColor: kColorwhite,
                                      child: Icon(Icons.call, size: width * 0.05),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      widget.leadValue.mobileNo ?? "",
                                      style: TextStyle(decoration: TextDecoration.none, fontWeight: FontWeight.normal, fontSize: 15.sp),
                                    ), // mobile number
                                    SizedBox(width: width * 0.02),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        widget.leadValue.email != null
                            ? Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                showDuration: Duration(seconds: 2),
                                message: widget.leadValue.email,
                                child: Row(children: [
                                  CircleAvatar(
                                    radius: width * 0.04,
                                    backgroundColor: kColorwhite,
                                    child: Icon(Icons.email, size: width * 0.05),
                                  ),
                                  SizedBox(width: width * 0.01),
                                  SizedBox(
                                    width: (widget.leadValue.mobileNo != "" && widget.leadValue.email!.length > 20) ? width * 0.45 : null,
                                    child: Text(
                                      widget.leadValue.email ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ) // mobile number
                                ]),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(width * 0.01),
                margin: EdgeInsets.all(width * 0.02),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.05),
                  // color: kColorgreyShade300,
                ),
                child: Column(
                  children: [
                    // ListTile(
                    //   title: Text("Interested Product"),
                    //   trailing: Text(widget.leadValue.interestedProductId.toString()),
                    // ),
                    // Divider(height: 0.1),
                    // ListTile(
                    //   title: Text("Interested Service"),
                    //   trailing: Text(widget.leadValue.interestedServiceId.toString()),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Follow Up Date",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Text(
                              widget.leadValue.followUpDate == null ? "" : DateClass().showDate(widget.leadValue.followUpDate ?? ""),
                              textAlign: TextAlign.end,
                              style: TextStyle(color: kColorblack, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lead Date",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Text(
                              DateClass().showDate(widget.leadValue.leadGenerationDate ?? ""),
                              textAlign: TextAlign.end,
                              style: TextStyle(color: kColorblack, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Priority",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Obx(() => Text(
                                  controller.showPriority.value,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: kColorblack, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Source",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Obx(() => Text(
                                  controller.showSource.value,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: kColorblack, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Conversion Chance",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Obx(() => Text(
                                  controller.showConversionChange.value,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: kColorblack, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Interested products",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Obx(() => Text(
                                  controller.materialNames == "" ? "--" : controller.materialNames.value.toString(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: kColorblack, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Interested Services",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Obx(() => Text(
                                  controller.serviceNames == "" ? "--" : controller.serviceNames.value.toString(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: kColorblack, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        children: [
                          Text(
                            "Lead Amount (INR)",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Text(
                            widget.leadValue.amount?.toString() ?? "--",
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.green, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 3.6.w, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40.w,
                            child: Text(
                              widget.leadValue.address?.toString() ?? "--",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black, fontSize: 3.7.w, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Row(
                  children: [
                    customIconButton(
                        ontap: () {
                          Get.to(
                              () => NewLeadManagementAddScreen(
                                    isEdit: true,
                                    leadValue: widget.leadValue,
                                    materialList: widget.materialList,
                                    serviceList: widget.serviceList,
                                  ),
                              duration: Duration(milliseconds: 500),
                              transition: Transition.rightToLeft);
                        },
                        icon: Icons.edit,
                        bgcolor: Colors.lightBlue[500]),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    // customIconButton(
                    //     ontap: () {
                    //       showModalBottomSheet(
                    //         isScrollControlled: false,
                    //         context: context,
                    //         builder: (context) {
                    //           return Container(
                    //             margin: EdgeInsets.all(width * 0.03),
                    //             padding: EdgeInsets.all(width * 0.02),
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   "Field Work of ${widget.leadValue.leadGenerationNumber}",
                    //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    //                 ),
                    //                 SizedBox(height: height * 0.01),
                    //                 Text(
                    //                   "",
                    //                   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    //                 ),
                    //                 SizedBox(height: height * 0.02),
                    //                 Center(
                    //                     child: Row(
                    //                   mainAxisAlignment: userManagementController.isUserLoggedIn.value
                    //                       ? MainAxisAlignment.spaceEvenly
                    //                       : MainAxisAlignment.center,
                    //                   children: [
                    //                     !userManagementController.isUserLoggedIn.value
                    //                         ? CustomButton(
                    //                             title: "Start",
                    //                             ontap: () async {
                    //                               print(userManagementController.isLoading.value);
                    //                               userManagementController.isLoading.value = true;
                    //                               Get.to(() => UserManagementScreen(leadValue: widget.leadValue))!.then((value) {
                    //                                 Get.back();
                    //                               });

                    //                               print(userManagementController.isLoading.value);

                    //                               await userManagementController.logIn("location is bnglr");
                    //                             },
                    //                             width: width * 0.3,
                    //                             color: Colors.green,
                    //                             textcolor: Colors.white,
                    //                           )
                    //                         : CustomButton(
                    //                             title: "View",
                    //                             ontap: () {
                    //                               // print(userManagementController.isLoading.value);
                    //                               Get.to(() => UserManagementScreen(
                    //                                         leadValue: widget.leadValue,
                    //                                       ))!
                    //                                   .then((value) {
                    //                                 userManagementController.isLoading.value = false;
                    //                                 Get.back();
                    //                               });
                    //                             },
                    //                             width: width * 0.3,
                    //                             color: kColorlightBlue,
                    //                             textcolor: Colors.white,
                    //                           ),
                    //                     Visibility(
                    //                       visible: userManagementController.isUserLoggedIn.value,
                    //                       child: CustomButton(
                    //                         title: "Stop",
                    //                         ontap: () async {
                    //                           await userManagementController.logOut("location is bnglr");
                    //                           Get.back();
                    //                         },
                    //                         width: width * 0.3,
                    //                         color: Colors.red,
                    //                         textcolor: Colors.white,
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ))
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //       );
                    //     },
                    //     icon: Icons.account_circle_rounded,
                    //     bgcolor: Colors.lightBlue[500]),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        width: 50.w,
                        title: "Back",
                        ontap: () {
                          Get.to(() => LeadManagementListScreen(), transition: Transition.leftToRight, duration: Duration(milliseconds: 600));
                        },
                        color: kColorwhite,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  initialData() async {
    await controller.getStatusById();

    controller.statusController.text = widget.leadValue.statusName ?? "";
    controller.selectedStatusValue.id = widget.leadValue.statusId;

    print("status id -- ${controller.selectedStatusValue.id}");

    await controller.getUserList();

    //--asigned to
    widget.leadValue.assignedToId == null ? "" : controller.selectedUserValue = controller.userList.firstWhere((value) => value.id == widget.leadValue.assignedToId);

    //--source
    await controller.getSourceList();
    controller.selectedSourceValue = controller.sourceList.firstWhere((value) => value.id == widget.leadValue.sourceId);

    controller.showSource.value = controller.selectedSourceValue.name?.toString() ?? "--";
    print("showSource id -- ${controller.showSource}");

    //- priority
    controller.selectedPriorityValue = controller.priorityList.firstWhere((value) => value.id == widget.leadValue.priorityId);
    controller.showPriority.value = controller.selectedPriorityValue.name?.toString() ?? "--";
    print("showPriority id -- ${controller.showPriority}");
    //--conversionchance
    controller.selectedConversionChanceValue = controller.conversionChanceList.firstWhere((value) => value.id == widget.leadValue.conversionChanceId);
    controller.showConversionChange.value = controller.selectedConversionChanceValue.name?.toString() ?? "--";
    print("showConversionChange id -- ${controller.showConversionChange}");
    //--area'
    await controller.getAreaList();

    if (widget.leadValue.areaId != null) {
      controller.selectedAreaValue = controller.areaList.firstWhere((city) => city.id == widget.leadValue.areaId);
    }

    //--city
    await controller.getCityList();
    widget.leadValue.cityId == null ? null : controller.selectedCityValue = controller.cityList.firstWhere((value) => value.id == widget.leadValue.cityId);

    //--state
    await controller.getStateList();
    widget.leadValue.stateId == null ? null : controller.stateController.text = controller.stateList.where((value) => value.id == widget.leadValue.stateId).first.name!;
    controller.selectedStatusValue.id = widget.leadValue.conversionChanceId;

    //--country
    await controller.getCountryList();
    widget.leadValue.countryId == null ? null : controller.selectedCountryValue = controller.countryList.firstWhere((value) => value.id == widget.leadValue.countryId);
    controller.countryController.text = controller.selectedCountryValue.name ?? " ";

    //------ interested product ----

    print("----int id -- ${widget.leadValue.interestedServiceId!.length.toString()}");

    if (widget.leadValue.interestedProductId != null && widget.leadValue.interestedProductId!.isNotEmpty) {
      List<int> interestedProductIds = widget.leadValue.interestedProductId!
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

    controller.materialNames.value = controller.intrestedProductController.text;

    //------ interested service ----

    print("----int id -- ${widget.leadValue.interestedServiceId!.length}");

    if (widget.leadValue.interestedServiceId != null && widget.leadValue.interestedServiceId!.isNotEmpty) {
      var interestedServiceId = widget.leadValue.interestedServiceId!
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
    controller.serviceNames.value = controller.intrestedServiceController.text;
    print("interested ----------serviceNames----${controller.serviceNames.value}");

    // if (widget.leadValue.interestedServiceId != null &&
    //     widget.leadValue.interestedServiceId!.where((id) => id.toString().trim().isNotEmpty).isNotEmpty) {
    //   var interestedServiceId = widget.leadValue.interestedServiceId!.first.split(',').map((id) => int.parse(id)).toList();
    //   print("inside " + widget.leadValue.interestedServiceId.toString());
    //   controller.selectedServiceItem.clear();
    //   for (var item in widget.serviceList) {
    //     if (interestedServiceId.contains(item.id)) {
    //       controller.selectedServiceItem.add(item);
    //     }
    //   }
    //   controller.serviceNames.value = controller.selectedServiceItem.map((item) => item.name).join(', ');
    // }
    // print("interested ----------interestedService----${controller.serviceNames.value}");

    // // materialNames = getMaterialNames(widget.leadValue.interestedProductId.toString());

    // if (widget.leadValue.interestedProductId != null && widget.leadValue.interestedProductId!.isNotEmpty) {
    //   print("inside " + widget.leadValue.interestedProductId.toString());
    //   List interestedProductIds = widget.leadValue.interestedProductId!.first.split(',').map((id) => int.parse(id)).toList();
    //   controller.selectedMaterialItem.clear();
    //   for (var item in widget.materialList) {
    //     if (interestedProductIds.contains(item.id)) {
    //       controller.selectedMaterialItem.add(item);
    //     }
    //   }
    //   controller.materialNames.value = controller.selectedMaterialItem.map((item) => item.name).join(', ');
    // }

    // for (var item in widget.materialList) {
    //   print("-------insside${item.id}");
    //   if (interestedProductIds.contains(item.id)) {
    //     controller.selectedMaterialItem.add(item);
    //   }
    // }

    //------ interested service ----
    // var interestedServiceId = widget.leadValue.interestedServiceId!.first.split(',').map((id) => int.parse(id)).toList();

    // for (var item in widget.materialList) {
    //   if (interestedServiceId.contains(item.id)) {
    //     controller.selectedServiceItem.add(item);
    //   }
    // }
    // controller.intrestedServiceController.text = controller.selectedServiceItem.map((item) => item.name).join(', ');

    //
  }
}

class Itemscustom extends StatelessWidget {
  final String partName;
  final String price;
  final String itemsPlusamount;
  final String specification;

  const Itemscustom({super.key, required this.partName, required this.price, required this.itemsPlusamount, required this.specification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                partName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
            ),
            SizedBox(
              child: Text(
                price,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
            )
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            itemsPlusamount,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            specification,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
