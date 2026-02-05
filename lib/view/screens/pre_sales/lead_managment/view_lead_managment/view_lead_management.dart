// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Model/lead_model.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';
import 'package:work_Force/controllers/lead_contact_details_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/utils/Services/websocket_location_services.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/screens/field_work/tracking/user/user_field_work/user_management_controller.dart';
import 'package:work_Force/view/screens/field_work/tracking/user/user_field_work/user_management_screen.dart';
import 'package:work_Force/view/screens/pre_sales/add_lead_from_contacts/contact_list_screen.dart';
import 'package:work_Force/view/screens/pre_sales/get_location/controller/get_location_controller.dart';
import 'package:work_Force/view/screens/pre_sales/get_location/widget/get_location_widget.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/add_lead_screen/add_new_lead_managment.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/open_lead_management.dart';
import 'package:work_Force/view/screens/pre_sales/widget/document_wallet.dart';
import 'package:work_Force/view/screens/pre_sales/widget/share_doc_nd_history.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/filter_list.dart';
import 'package:work_Force/view/widget/shimmer_loading.dart';

class LeadManagementListScreen extends StatefulWidget {
  String? quotationNumber;
  bool? isFromHomeScreen;

  String? missedUpId;
  LeadManagementListScreen(
      {super.key,
      this.isFromHomeScreen,
      this.quotationNumber,
      this.missedUpId});

  @override
  State<LeadManagementListScreen> createState() =>
      _LeadManagementListScreenState();
}

class _LeadManagementListScreenState extends State<LeadManagementListScreen> {
  final scrollcontroller = ScrollController();
  final controller = Get.put(GetLeadController());
  final locController = Get.put(GetLocationController());
  final contactController = Get.put(LeadContactDetaisController());
  final UserManagementController userManagementController =
      Get.put(UserManagementController());

  final FocusNode _focusNode = FocusNode();

  int page = 1;

  Color getStatusColor(String? status) {
    switch (status) {
      case "Converted":
        return Colors.green;
      case "Not Converted":
        return Colors.red;
      case "Follow Up Required":
        return Colors.indigo;
      case "New":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case "Converted":
        return Icons.check_circle_rounded;
      case "Not Converted":
        return Icons.cancel_rounded;
      case "Follow Up Required":
        return Icons.schedule_rounded;
      case "New":
        return Icons.fiber_new_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$label: ",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
    bool isMenu = false,
    List<PopupMenuEntry<dynamic>>? menuItems,
  }) {
    if (isMenu && menuItems != null) {
      return PopupMenuButton(
        icon: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Icon(
            icon,
            color: color,
            size: 20.sp,
          ),
        ),
        tooltip: tooltip,
        itemBuilder: (context) => menuItems,
      );
    }

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(2.w),
        child: Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (controller.isCalledGetAllLeads.value == true) {
      // print("inside --- missed follow up id-- ${widget.missedUpId}");
      controller.isPageLoading.value = true;

      controller.getLeadList(controller.searchValue.value, 1, "desc",
          "leadGenerationDate", "", false, "0", "0", widget.missedUpId ?? "");
    } else {
      controller.getLeadList(controller.searchValue.value, 1, "desc",
          "leadGenerationDate", "", false, "0", "0", "");
    }

    print(
        "controller.searchValue.value scroll----${controller.searchValue.value}");
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.offset) {
        controller.loading.value = true;
        print("search name--${controller.searchValue.value}");
        setState(() {
          page++;
          controller.getLeadList(
              controller.searchValue.value,
              page,
              controller.sortdirection.value,
              controller.sortwith.value,
              controller.filter.value,
              controller.isFilter.value,
              controller.financialYearId.value,
              controller.selectedStatusId.value,
              "");
          print("hello----222");
          print("page-------------2222 $page");
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollcontroller.dispose();
    _focusNode.dispose();
  }

  String search = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Lead"),
            titleTextStyle: TextStyle(
                color: kColorblack,
                fontWeight: FontWeight.bold,
                fontSize: 19.sp),
            centerTitle: true,
            backgroundColor: kColorwhite,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    margin: EdgeInsets.only(right: 2.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            leadAddDialog(context);
                          },
                          child: Icon(
                            Icons.add_circle_outline_rounded,
                            color: kColorwhite,
                            size: 35,
                          )),
                    )),
              )
            ],
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: kColorblack,
                size: 23.sp,
              ),
              onPressed: (() {
                controller.selectedStatus.value = "";
                controller.StatusfromPreSalesScreen.value = false;
                controller.searchValue.value = "";
                controller.isPageLoading.value = false;
                controller.listLoad.value = false;
                controller.hasMore.value = true;
                controller.isCalledGetAllLeads.value = false;
                controller.sortdirection.value = "desc";
                controller.sortwith.value = "leadGenerationDate";
                controller.filter.value = "";
                controller.isFilter.value = false;
                controller.selectedStatusId.value = "0";
                controller.leadList.clear();
                controller.fromPreSalesScreen.value = false;
                print("lead list---${widget.isFromHomeScreen}");

                if (widget.isFromHomeScreen == true) {
                  print("inside");
                  Get.offAll(() => BottomNavigationMainscreen(initialIndex: 1));
                } else if (widget.isFromHomeScreen == false ||
                    widget.isFromHomeScreen == null) {
                  Get.offAll(() => BottomNavigationMainscreen(initialIndex: 0));
                }
              }),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSearch(),
                      CustomFilterButton(context),
                    ],
                  ),
                ),
                Obx(
                  () => controller.loading.value == false
                      ? HomeLoading()
                      : controller.leadList.isEmpty
                          ? Expanded(
                              child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeIn(
                                      delay: const Duration(milliseconds: 300),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: LottieBuilder.asset(
                                        emptyLottie,
                                        width: 70.w,
                                      )),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  FadeIn(
                                    delay: const Duration(milliseconds: 500),
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      "Your Lead is Empty",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  )
                                ],
                              ),
                            ))
                          : Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  return Future.delayed(
                                    Duration(seconds: 1),
                                    () {
                                      controller.isPageLoading.value = false;
                                      controller.listLoad.value = false;
                                      controller.hasMore.value = true;
                                      page = 1;
                                      controller.leadList.clear();
                                      controller.sortdirection.value = "desc";
                                      controller.sortwith.value =
                                          "leadGenerationDate";
                                      controller.filter.value = "";
                                      controller.isFilter.value = false;
                                      controller.getLeadList(
                                          controller.searchValue.value,
                                          1,
                                          "desc",
                                          "leadGenerationDate",
                                          "",
                                          false,
                                          controller.financialYearId.value,
                                          '0',
                                          "");
                                    },
                                  );
                                },
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  interactive: true,
                                  thickness: 2.w,
                                  radius: Radius.circular(3.w),
                                  controller: scrollcontroller,
                                  child: ListView.separated(
                                    cacheExtent: 10,
                                    physics: BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      thickness: 1,
                                      color: kColorgrey.withValues(alpha: 0.3),
                                    ),
                                    controller: scrollcontroller,
                                    itemCount: controller.leadList.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index < controller.leadList.length) {
                                        var item = controller.leadList[index];

                                        return CustomLeadListItem(
                                            item, context, index, width);
                                      } else {
                                        return Center(
                                          child: controller.hasMore.value
                                              ? LoadingAnimationWidget
                                                  .threeRotatingDots(
                                                  color: Colors.lightBlue,
                                                  size: 10.w,
                                                )
                                              : Text(
                                                  widget.isFromHomeScreen ==
                                                          true
                                                      ? "Click Refresh to Load All the Data"
                                                      : "No more data to Load",
                                                ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
        Obx(() => loadingScreenWithText(
              isPageLoading: controller.isPageLoading.value,
            )),
      ],
    );
  }

  GestureDetector CustomLeadListItem(
      LeadModel item, BuildContext context, int index, double width) {
    return GestureDetector(
        onTap: () async {
          Get.to(
              () => OpenLeadManagementScreen(
                  leadValue: item,
                  materialList: controller.materialLists,
                  serviceList: controller.serviceLists,
                  index: index),
              transition: Transition.rightToLeft);
        },
        onLongPress: () {},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.95),
                Colors.white.withValues(alpha: 0.85),
              ],
            ),
            borderRadius: BorderRadius.circular(4.w),
            border: Border.all(
              color: Colors.lightBlue.withValues(alpha: 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlue.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: Offset(0, 8),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lead Number with enhanced styling
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue.withValues(alpha: 0.15),
                            Colors.lightBlue.withValues(alpha: 0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2.w),
                        border: Border.all(
                          color: Colors.lightBlue.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Lead No: ${item.leadGenerationNumber ?? ""}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue[800],
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      DateClass().showDate(item.leadGenerationDate ?? ""),
                    )
                  ],
                ),
                SizedBox(height: 2.h),

                // Lead Name and Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item.leadName}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              height: 1.3,
                              letterSpacing: 0.2,
                            ),
                          ),
                          if (item.followUpDate != null) SizedBox(height: 1.h),
                          if (item.followUpDate != null)
                            _buildInfoRow(
                              Icons.event_repeat_rounded,
                              "Follow-Up",
                              DateClass().showDate(item.followUpDate ?? ""),
                              Colors.orange[700]!,
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            getStatusColor(item.statusName)
                                .withValues(alpha: 0.9),
                            getStatusColor(item.statusName)
                                .withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4.w),
                        boxShadow: [
                          BoxShadow(
                            color: getStatusColor(item.statusName)
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getStatusIcon(item.statusName),
                            color: Colors.white,
                            size: 17.sp,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            item.statusName ?? "",
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h),

                // Date Information with icons

                // Contact Information
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(2.w),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Phone
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1.5.w),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(1.5.w),
                              ),
                              child: Icon(
                                Icons.call_rounded,
                                size: 16.sp,
                                color: Colors.green[700],
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                item.mobileNo ?? "",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Email
                      if (item.email != null &&
                          item.email != "" &&
                          item.email?.split(".com").first != "notnull@notnull")
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(width: 2.w),
                              Container(
                                padding: EdgeInsets.all(1.5.w),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(1.5.w),
                                ),
                                child: Icon(
                                  Icons.mail_rounded,
                                  size: 16.sp,
                                  color: Colors.blue[700],
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Text(
                                  item.email.toString(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [
                  //       Colors.lightBlue.withValues(alpha: 0.12),
                  //       Colors.blue.withValues(alpha: 0.08),
                  //     ],
                  //   ),
                  //   borderRadius: BorderRadius.circular(3.w),
                  //   border: Border.all(
                  //     color: Colors.lightBlue.withValues(alpha: 0.25),
                  //     width: 1,
                  //   ),
                  // ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          icon: Icons.edit_rounded,
                          color: Colors.blue,
                          tooltip: "Edit Lead",
                          onPressed: () async {
                            Get.to(
                                () => NewLeadManagementAddScreen(
                                      isEdit: true,
                                      leadValue: item,
                                      materialList: controller.materialLists,
                                      serviceList: controller.serviceLists,
                                    ),
                                duration: Duration(milliseconds: 500),
                                transition: Transition.rightToLeft);
                          },
                        ),
                        _buildActionButton(
                          icon: item.leadGeoLocation == null ||
                                  item.leadGeoLocation == "${null},${null}"
                              ? Icons.add_location_alt_rounded
                              : Icons.location_on_rounded,
                          color: item.leadGeoLocation == null ||
                                  item.leadGeoLocation == "${null},${null}"
                              ? Colors.orange
                              : Colors.green,
                          tooltip: item.leadGeoLocation == null ||
                                  item.leadGeoLocation == "${null},${null}"
                              ? "Add Location"
                              : "View Location",
                          onPressed: () async {
                            if (item.leadGeoLocation == null ||
                                item.leadGeoLocation == "${null},${null}") {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                useSafeArea: true,
                                builder: (context) => LocationWidget(
                                  index: index,
                                  LeadValueList: controller.leadList,
                                  leadValue: item,
                                  IsClikedLocation: true,
                                  materialList: controller.materialLists,
                                  serviceList: controller.serviceLists,
                                ),
                              );
                            } else {
                              // open maps

                              List<String> latLong =
                                  item.leadGeoLocation.split(",");
                              locController.latitudeController.text =
                                  latLong[1];
                              locController.longitudeController.text =
                                  latLong[0];
                              print(
                                  "location latitude ${locController.latitudeController.text}");
                              print(
                                  "location longitude ${locController.longitudeController.text}");

                              var lat = double.tryParse(
                                  locController.latitudeController.text);
                              var long = double.tryParse(
                                  locController.longitudeController.text);

                              // Location already added, so get location and open maps
                              await locController.openGoogleMaps(
                                  lat ?? 0.0, long ?? 0.0);
                            }
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.history_rounded,
                          color: Colors.purple,
                          tooltip: "Lead History",
                          onPressed: () async {
                            print("pressed");
                            controller.getLeadHistory(item.id ?? "");
                            await bottomSheetHistoryCustom(context, item, width,
                                () async {
                              controller.LeadHistoryLists.clear();
                              await controller.getLeadHistory(item.id ?? "");
                            }, controller);
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.track_changes_rounded,
                          color: Colors.indigo,
                          tooltip: "Field Work",
                          onPressed: () async {
                            Fluttertoast.showToast(
                              msg: "This feature is in Progress",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: kColorwhite,
                              backgroundColor: kColorgrey,
                            );
                            showModalBottomSheet(
                              isScrollControlled: false,
                              context: context,
                              builder: (context) {
                                final isActive =
                                    userManagementController.isFieldWorkActive;
                                final isForThisLead = userManagementController
                                    .isFieldWorkForThisLead(item.id!);
                                userManagementController.isFieldWorkLive.value =
                                    true;

                                return Container(
                                  margin: EdgeInsets.all(width * 0.03),
                                  padding: EdgeInsets.all(width * 0.02),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Field Work of ${item.leadGenerationNumber}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(height: 1.h),
                                      if (isActive && !isForThisLead)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Center(
                                            child: Text(
                                              "Field work is already running for Lead #${userManagementController.activeLeadNumber} (${userManagementController.activeLeadName}).",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      else
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: isForThisLead
                                                ? MainAxisAlignment.spaceEvenly
                                                : MainAxisAlignment.center,
                                            children: [
                                              if (!isActive)
                                                CustomButton(
                                                  title: "Start",
                                                  ontap: () async {
                                                    await Get.find<
                                                            WebSocketService>()
                                                        .initializeConnection(
                                                            leadId: item.id!,
                                                            userId:
                                                                item.userId);

                                                    userManagementController
                                                        .addTimelineItem(
                                                            action: "Started",
                                                            leadValue: item);

                                                    userManagementController
                                                        .isLoading.value = true;
                                                    userManagementController
                                                        .startFieldWork(
                                                            leadId: item.id!,
                                                            leadName:
                                                                item.leadName ??
                                                                    '',
                                                            leadNumber:
                                                                item.leadGenerationNumber ??
                                                                    '');

                                                    Get.to(() =>
                                                            UserManagementScreen(
                                                                leadValue:
                                                                    item))!
                                                        .then((value) =>
                                                            Get.back());
                                                  },
                                                  width: width * 0.3,
                                                  color: Colors.green,
                                                  textcolor: Colors.white,
                                                ),
                                              if (isForThisLead)
                                                CustomButton(
                                                  title: "View",
                                                  ontap: () {
                                                    Get.to(() =>
                                                            UserManagementScreen(
                                                                leadValue:
                                                                    item))!
                                                        .then((value) {
                                                      userManagementController
                                                          .isLoading
                                                          .value = false;
                                                      Get.back();
                                                    });
                                                  },
                                                  width: width * 0.3,
                                                  color: kColorlightBlue,
                                                  textcolor: Colors.white,
                                                ),
                                              if (isForThisLead)
                                                CustomButton(
                                                  title: "Stop",
                                                  ontap: () async {
                                                    await userManagementController
                                                        .logOut(
                                                            "location is bnglr");
                                                    userManagementController
                                                        .stopFieldWork();
                                                    Get.back();
                                                  },
                                                  width: width * 0.3,
                                                  color: Colors.red,
                                                  textcolor: Colors.white,
                                                ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.more_vert_rounded,
                          color: Colors.grey[700]!,
                          tooltip: "More Options",
                          onPressed: () {
                            // This will be handled by PopupMenuButton
                          },
                          isMenu: true,
                          menuItems: [
                            PopupMenuItem(
                              onTap: () async {
                                await controller.getDocumentWalletList(
                                    leadId: item.id!);
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return LeadDocumentWalletScreen(
                                        controller: controller,
                                        leadValue: item);
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
                                controller.getLeadHistory(item.id ?? "");
                                await bottomSheetHistoryCustom(
                                    context, item, width, () async {
                                  controller.LeadHistoryLists.clear();
                                  await controller
                                      .getLeadHistory(item.id ?? "");
                                }, controller);
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

                                await controller.getSharedDocHistory(
                                    leadId: item.id!);
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isDismissible: true,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    builder: (context) {
                                      return ShareDocNdHistory(
                                        controller: controller,
                                        leadValue: item,
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.share_outlined,
                                      color: kColorblack),
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
                                print(item.leadGeoLocation);
                                if (item.leadGeoLocation == null ||
                                    item.leadGeoLocation == "${null},${null}") {
                                  // Location not added yet, so add location
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    useSafeArea: true,
                                    builder: (context) => LocationWidget(
                                      index: index,
                                      LeadValueList: controller.leadList,
                                      leadValue: item,
                                      IsClikedLocation: true,
                                      materialList: controller.materialLists,
                                      serviceList: controller.serviceLists,
                                    ),
                                  );
                                  // locController.getCurrentLocation(item);
                                } else {
                                  List<String> latLong =
                                      item.leadGeoLocation.split(",");
                                  locController.latitudeController.text =
                                      latLong[1];
                                  locController.longitudeController.text =
                                      latLong[0];
                                  print(
                                      "location latitude ${locController.latitudeController.text}");
                                  print(
                                      "location longitude ${locController.longitudeController.text}");

                                  var lat = double.tryParse(
                                      locController.latitudeController.text);
                                  var long = double.tryParse(
                                      locController.longitudeController.text);

                                  // Location already added, so get location and open maps
                                  await locController.openGoogleMaps(
                                      lat ?? 0.0, long ?? 0.0);
                                }
                                // controller.getLeadHistory(item.id ?? "");
                              },
                              child: Row(
                                children: [
                                  item.leadGeoLocation == null ||
                                          item.leadGeoLocation ==
                                              "${null},${null}"
                                      ? Icon(Icons.add_location_alt,
                                          color: kColorblack)
                                      : Icon(Icons.location_on,
                                          color: Colors.green),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  Text(
                                    item.leadGeoLocation == null ||
                                            item.leadGeoLocation ==
                                                "${null},${null}"
                                        ? "Add location"
                                        : "View location",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: item.leadGeoLocation == null ||
                                                item.leadGeoLocation ==
                                                    "${null},${null}"
                                            ? Colors.black
                                            : Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              enabled: item.leadGeoLocation != null,
                              onTap: () async {
                                print("pressed");
                                print(item.leadGeoLocation);

                                // Location not added yet, so add location
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  useSafeArea: true,
                                  builder: (context) => LocationWidget(
                                    index: index,
                                    LeadValueList: controller.leadList,
                                    leadValue: item,
                                    IsClikedLocation: true,
                                    materialList: controller.materialLists,
                                    serviceList: controller.serviceLists,
                                  ),
                                );
                                // locController.getCurrentLocation(item);

                                // controller.getLeadHistory(item.id ?? "");
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.add_location_alt,
                                      color: kColorblack),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  Text(
                                    "Update Location",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                print("id-----${item.id ?? ""}");
                                controller.deleteLead(item.id ?? "");
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: kColorRed),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kColorRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Container CustomSearch() {
    return Container(
      height: 5.5.h,
      width: 76.w,
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        color: kColorwhite,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              onTap: () {
                setState(() {});
              },
              focusNode: _focusNode,
              controller: controller.searchController,
              onChanged: (value) async {
                controller.searchValue.value = value;
                print(
                    "controller.searchValue.value --${controller.searchValue.value}");
                await controller.getLeadList(
                    controller.searchValue.value,
                    1,
                    "desc",
                    "leadGenerationDate",
                    "",
                    false,
                    controller.financialYearId.value,
                    controller.selectedStatusId.value,
                    "");
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                // icon:Icon( Icons.search),

                hintText: 'Search Here',
                hintStyle: TextStyle(color: kColorgrey),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          Visibility(
            visible: _focusNode.hasFocus,
            child: IconButton(
              onPressed: () {
                setState(() {
                  controller.searchController.clear();
                  _focusNode.unfocus();
                  if (controller.searchController.text.isEmpty) {
                    _focusNode.unfocus();
                    controller.isPageLoading.value = false;
                    controller.listLoad.value = false;
                    controller.hasMore.value = true;
                    widget.isFromHomeScreen = false;
                    controller.searchValue.value = "";

                    page = 1;
                    controller.leadList.clear();
                    controller.getLeadList(
                        controller.searchValue.value,
                        page,
                        "desc",
                        "leadGenerationDate",
                        "",
                        false,
                        controller.financialYearId.value,
                        controller.selectedStatusId.value,
                        "");
                  }
                });
              },
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }

  IconButton CustomFilterButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        CustomFilterList(
          financialYearList: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "  Financial Year",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: Container(
                          margin: EdgeInsets.all(2.w),
                          height: 7.h,
                          // width: 30.w,
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Divider(
                              color: Color.fromARGB(255, 220, 220, 220),
                              thickness: 1,
                              height: 1,
                            ),
                            value: controller.financialYearId.value,
                            items: [
                              DropdownMenuItem<String>(
                                value: "",
                                child: Text("Financial Year"),
                              ),
                              ...controller.financialYearList
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.id.toString(),
                                        child: Text("${item.financialYear}"),
                                      )),
                            ],
                            onChanged: (newValue) {
                              setState(() {
                                controller.financialYearId.value = newValue!;

                                print(controller.financialYearId.value);

                                controller.financialYear.value = controller
                                    .financialYearList
                                    .firstWhere((item) =>
                                        item.id.toString() ==
                                        controller.financialYearId.value)
                                    .financialYear!;

                                print(controller.financialYear.value);
                              });
                            },
                            hint: Text('Select an item'),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
          context: context, //context
          customList: [
            SizedBox(
              height: 25.h,
              child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.statusList.length,
                    itemBuilder: (context, index) {
                      var item = controller.statusList[index];
                      return SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name ?? "",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            SizedBox(
                              width: 5.w,
                              child: Obx(() => Checkbox(
                                    // value: controller.isStatusSelected[index],
                                    value: controller.selectedMulitStatuses
                                        .contains(item.id),
                                    activeColor: Colors.lightBlue,
                                    onChanged: (value) {
                                      // controller.onStatusCheckboxChanged(index, value ?? false);
                                      controller.selectedStatusId.value =
                                          item.id.toString();

                                      if (controller.selectedMulitStatuses
                                          .contains(item.id)) {
                                        controller.selectedMulitStatuses.remove(
                                            item.id); // Uncheck the status
                                      } else {
                                        controller.selectedMulitStatuses
                                            .add(item.id!); // Check the status
                                      }
                                      if (controller
                                          .selectedMulitStatuses.isNotEmpty) {
                                        controller.isFilter.value = true;
                                      } else {
                                        controller.isFilter.value = false;
                                      }

                                      print(
                                          "multi select - ${controller.selectedMulitStatuses}");
                                      print("isFilter - " +
                                          controller.isFilter.value.toString());

                                      print(
                                          "status id---- ${controller.selectedStatusId.value}");
                                    },
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ),
            Divider(thickness: 1),
          ],
          sortColumnList: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  width: 5.w,
                  child: Obx(() => Radio(
                        value: "date",
                        activeColor: Colors.lightBlue,
                        groupValue: controller.selectedRadio.value,
                        onChanged: (value) {
                          controller.onRadioSelected(value.toString());
                        },
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lead Name",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  width: 5.w,
                  child: Obx(() => Radio(
                        value: "leadName",
                        activeColor: Colors.lightBlue,
                        groupValue: controller.selectedRadio.value,
                        onChanged: (value) {
                          controller.onRadioSelected(value.toString());
                        },
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lead Number",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  width: 5.w,
                  child: Obx(() => Radio(
                        value: "leadGenerationId",
                        activeColor: Colors.lightBlue,
                        groupValue: controller.selectedRadio.value,
                        onChanged: (value) {
                          controller.onRadioSelected(value.toString());
                        },
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "FollowUp Date",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  width: 5.w,
                  child: Obx(() => Radio(
                        value: "followUpDate",
                        activeColor: Colors.lightBlue,
                        groupValue: controller.selectedRadio.value,
                        onChanged: (value) {
                          controller.onRadioSelected(value.toString());
                        },
                      )),
                ),
              ],
            ),
          ],
          sortBy: controller.sortDirection, //container
          containerOnpressed: () {
            //onpressed Container
            controller.containerOnpressed();
            print(controller.sortDirection.value);
          },

          confirmTap: () {
            //confirm button
            controller.isPageLoading.value = true;
            controller.leadList.clear();

            print(controller.isFilter.value);
            print(controller.selectedRadio.value);
            controller.sortDirection.value == true
                ? controller.sortdirection.value = "desc"
                : controller.sortdirection.value = "asc";

            if (controller.selectedRadio.value == "date") {
              controller.sortwith.value = "leadGenerationDate";
            } else if (controller.selectedRadio.value == "leadName") {
              controller.sortwith.value = "leadName";
            } else if (controller.selectedRadio.value == "leadGenerationId") {
              controller.sortwith.value = "leadGenerationId";
            } else if (controller.selectedRadio.value == "followUpDate") {
              controller.sortwith.value = "followUpDate";
            }

            controller.getLeadList(
                controller.searchValue.value,
                1,
                controller.sortdirection.value,
                controller.sortwith.value,
                controller.filter.value,
                controller.isFilter.value,
                controller.financialYearId.value,
                controller.selectedStatusId.value,
                "");

            Get.back();
          }, // confirm button
          ontapClose: () {
            controller.isSelectedNew.value = false;
            controller.isSelectedConverted.value = false;

            controller.sortDirection.value = true;
            controller.selectedRadio.value = "";

            controller.getLeadList(
                controller.searchValue.value,
                1,
                "desc",
                "leadGenerationDate",
                "",
                false,
                controller.financialYearId.value,
                controller.selectedStatusId.value,
                "");

            Get.back(); //clear button
          },
        );
      },
      icon: Icon(Icons.filter_list),
      iconSize: 20.sp,
    );
  }

  leadAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(7.w)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CreateWidgetCustom(
                ontap: () async {
                  await contactController.fetchContacts();
                  Get.to(() => ContactListScreen(
                      materialList: controller.materialLists,
                      serviceList: controller.serviceLists));
                },
                icons: Icons.import_contacts,
                title: "Import from Contacts"),
            CreateWidgetCustom(
                ontap: () {
                  Get.to(
                      () => NewLeadManagementAddScreen(
                          isEdit: false,
                          materialList: controller.materialLists,
                          serviceList: controller.serviceLists),
                      duration: Duration(milliseconds: 500),
                      transition: Transition.fadeIn);
                },
                icons: Icons.add_circle_outlined,
                title: "Create New Lead")
          ],
        ),
      ),
    );
  }

  void scrollUp() {
    const double start = 0;
    scrollcontroller.animateTo(start,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}

Future<dynamic> bottomSheetHistoryCustom(BuildContext context, LeadModel item,
    double width, VoidCallback refreshOntap, GetLeadController controller) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return FadeInUp(
          duration: Durations.extralong2,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FadeIn(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Text(
                          "Lead progress History",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: refreshOntap,
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[1],
                                borderRadius: BorderRadius.circular(16)),
                            child: CircleAvatar(
                              radius: 17,
                              child: Icon(
                                Icons.refresh,
                                size: 20,
                                color: kColorwhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[1],
                                borderRadius: BorderRadius.circular(16)),
                            child: CircleAvatar(
                              radius: 17,
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: kColorwhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(() => Expanded(
                        child: controller.LeadHistoryLists.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeIn(
                                        delay:
                                            const Duration(milliseconds: 300),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: LottieBuilder.asset(
                                            "assets/lottie/empty.json")),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    FadeIn(
                                      delay: const Duration(milliseconds: 500),
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: Text(
                                        "History list is Empty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.sp),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Obx(
                                () => ListView.builder(
                                  itemCount: controller.LeadHistoryLists.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var item =
                                        controller.LeadHistoryLists[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8, top: 18),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: kElevationToShadow[2],
                                            color: kColorwhite,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1,
                                                    top: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Assign To",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.04),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      item.assignedName
                                                              ?.toString() ??
                                                          "--",
                                                      style: TextStyle(
                                                          color: kColorblack,
                                                          fontSize:
                                                              width * 0.04,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1,
                                                    top: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Last Call On",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.04),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      DateClass().showDate(item
                                                              .previousFollowUp
                                                              ?.toString() ??
                                                          "--"),
                                                      style: TextStyle(
                                                          color: kColorblack,
                                                          fontSize:
                                                              width * 0.04,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1,
                                                    top: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Next follow up",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.04),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      DateClass().showDate(item
                                                              .nextFollowUp
                                                              ?.toString() ??
                                                          "--"),
                                                      style: TextStyle(
                                                          color: kColorblack,
                                                          fontSize:
                                                              width * 0.04,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1,
                                                    top: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Status",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.04),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      item.statusName
                                                              ?.toString() ??
                                                          "--",
                                                      style: TextStyle(
                                                          color: kColorblack,
                                                          fontSize:
                                                              width * 0.04,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1,
                                                    top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Internal Comments",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.04),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: width * 0.5,
                                                      child: Text(
                                                        item.userComments == ""
                                                            ? "--"
                                                            : item.userComments
                                                                    ?.toString() ??
                                                                "--",
                                                        style: TextStyle(
                                                            color: kColorblack,
                                                            fontSize:
                                                                width * 0.04,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1,
                                                    top: 8),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Lead Comments",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.04),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: width * 0.5,
                                                      child: Text(
                                                        item.leadComments == ""
                                                            ? "--"
                                                            : item.leadComments
                                                                    ?.toString() ??
                                                                "--",
                                                        style: TextStyle(
                                                            color: kColorblack,
                                                            fontSize:
                                                                width * 0.04,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              )
                                              // Divider(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ))
                ],
              ),
            ),
          ));
    },
  );
}

class CreateWidgetCustom extends StatelessWidget {
  final VoidCallback ontap;
  final IconData icons;
  final String title;
  const CreateWidgetCustom({
    super.key,
    required this.ontap,
    required this.icons,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        margin: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.w),
            color: Colors.grey[100],
            boxShadow: kElevationToShadow[1]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(child: Icon(icons)),
            SizedBox(
              width: 4.w,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.sp,
                    color: kColorblack)),
          ],
        ),
      ),
    );
  }
}
