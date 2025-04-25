// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/controllers/get_lead_controller.dart';
import 'package:suktha_crm/controllers/lead_contact_details_controller.dart';
import 'package:suktha_crm/utils/Date.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/view_lead_managment/open_lead_management.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:suktha_crm/view/widget/popup_with_lottie.dart';

class PreSaleScreen extends StatefulWidget {
  PreSaleScreen({super.key});

  @override
  State<PreSaleScreen> createState() => _PreSaleScreenState();
}

class _PreSaleScreenState extends State<PreSaleScreen> {
  final controller = Get.put(GetLeadController());
  final contactController = Get.put(LeadContactDetaisController());
  int? touchedIndex; // Store the index of the touched section
  String centerText = ""; // Store the text to display in the center

  @override
  void initState() {
    controller.fromPreSalesScreen.value = true;
    controller.StatusfromPreSalesScreen.value = false;
    TodayDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await popupWithLottie(
            context: context,

            //ontap
            ontap: () {
              SystemNavigator.pop();
            },
            //oncanecl
            oncancel: () {
              Get.back();
            },
            title: "Are you Sure \nyou want to Exit?",
            lottie: exitLottie);

        return value == true;
      },
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 243, 243),
          appBar: AppBar(
            title: const Text(" Pre Sales"),
            titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 20.sp),
            centerTitle: false,
            backgroundColor: Color.fromARGB(255, 243, 243, 243),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  controller.fromPreSalesScreen.value = false;
                  controller.isCalledGetAllLeads.value = false;
                  // controller.getAllLead();

                  Get.to(LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                  // controller.getFinancialYearList();
                },
                icon: Icon(
                  Icons.list_rounded,
                  color: kColorblack,
                ),
              )
            ],
          ),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInUp(
                  delay: Duration.zero,
                  duration: Duration(milliseconds: 800),
                  child: SizedBox(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            customFiltersDateBase(
                              () async {
                                setState(() {
                                  controller.selectedFilters.value = "Today";
                                  controller.totalLeadAmt.value = 0;
                                  controller.currentMonth.value = controller.TodayDate.value;
                                  controller.dataForSelectedDate.value = controller.TodayDateNumber.value;
                                  controller.filteredLeadList.clear();
                                  controller.isSelectedToday.value = true;
                                  controller.isSelectedThisMonth.value = false;
                                  controller.isSelectedLastMonth.value = false;
                                  controller.isSelectedTomorrow.value = false;
                                  controller.isSelectedLastWeek.value = false;
                                  controller.isSelectedNextWeek.value = false;
                                  controller.isSelectedCustom.value = false;
                                  controller.isSelectedThisWeek.value = false;
                                });
                                await TodayDetails();
                              },
                              "Today",
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() async {
                              setState(() {
                                controller.selectedFilters.value = "Yesterday";
                                controller.totalLeadAmt.value = 0;
                                controller.currentMonth.value = controller.yesterdayFormatted.value;
                                controller.dataForSelectedDate.value = controller.yesterdaydate.value;
                                controller.filteredLeadList.clear();
                                controller.isSelectedToday.value = false;
                                controller.isSelectedThisMonth.value = false;
                                controller.isSelectedLastMonth.value = false;
                                controller.isSelectedyesterday.value = true;
                                controller.isSelectedLastWeek.value = false;
                                controller.isSelectedNextWeek.value = false;
                                controller.isSelectedCustom.value = false;
                                controller.isSelectedTomorrow.value = false;
                                controller.isSelectedThisWeek.value = false;
                              });
                              await yesterdayDetails();
                            }, "Yesterday"),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() async {
                              setState(() {
                                controller.selectedFilters.value = "Tomorrow";
                                controller.totalLeadAmt.value = 0;
                                controller.currentMonth.value = controller.tomorrowFormatted.value;
                                controller.dataForSelectedDate.value = controller.tomorrowdate.value;
                                controller.filteredLeadList.clear();
                                controller.isSelectedToday.value = false;
                                controller.isSelectedThisMonth.value = false;
                                controller.isSelectedLastMonth.value = false;
                                controller.isSelectedyesterday.value = false;
                                controller.isSelectedTomorrow.value = true;
                                controller.isSelectedLastWeek.value = false;
                                controller.isSelectedNextWeek.value = false;
                                controller.isSelectedCustom.value = false;
                                controller.isSelectedThisWeek.value = false;
                              });
                              await tomorrowDetails();
                            }, "Tomorrow"),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() async {
                              setState(() {
                                controller.totalLeadAmt.value = 0;
                                controller.selectedFilters.value = "Last Week";
                                controller.dataForSelectedDate.value = "";
                                controller.currentMonth.value = "${controller.lastWeekStartFormatted.value} - ${controller.lastWeekEndFormatted.value}";
                                controller.isSelectedToday.value = false;
                                controller.isSelectedyesterday.value = false;
                                controller.isSelectedThisMonth.value = false;
                                controller.isSelectedLastMonth.value = false;
                                controller.isSelectedTomorrow.value = false;
                                controller.isSelectedLastWeek.value = true;
                                controller.isSelectedNextWeek.value = false;
                                controller.isSelectedCustom.value = false;
                                controller.isSelectedThisWeek.value = false;
                              });
                              await LastWeekList(controller.lastWeekStartDate.value, controller.lastWeekEndDate.value);
                            }, "Last Week"),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() async {
                              setState(() {
                                controller.totalLeadAmt.value = 0;
                                controller.selectedFilters.value = "This Week";
                                controller.dataForSelectedDate.value = "";
                                controller.currentMonth.value = "${controller.thisWeekStartFormatted.value} - ${controller.thisWeekEndFormatted.value}";
                                controller.isSelectedToday.value = false;
                                controller.isSelectedyesterday.value = false;
                                controller.isSelectedThisMonth.value = false;
                                controller.isSelectedLastMonth.value = false;
                                controller.isSelectedTomorrow.value = false;
                                controller.isSelectedLastWeek.value = false;
                                controller.isSelectedThisWeek.value = true;
                                controller.isSelectedNextWeek.value = false;
                                controller.isSelectedCustom.value = false;
                              });
                              await LastWeekList(controller.thisWeekStartDate.value, controller.thisWeekEndDate.value);
                            }, "This Week"),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() async {
                              setState(() {
                                controller.totalLeadAmt.value = 0;
                                controller.selectedFilters.value = "Next Week";
                                controller.isSelectedToday.value = false;
                                controller.dataForSelectedDate.value = "";
                                controller.isSelectedyesterday.value = false;
                                controller.currentMonth.value = "${controller.nextWeekStartFormatted.value} - ${controller.nextWeekEndFormatted.value}";
                                controller.isSelectedTomorrow.value = false;
                                controller.isSelectedThisMonth.value = false;
                                controller.isSelectedLastMonth.value = false;
                                controller.isSelectedLastWeek.value = false;
                                controller.isSelectedNextWeek.value = true;
                                controller.isSelectedCustom.value = false;
                                controller.isSelectedThisWeek.value = false;
                              });
                              await LastWeekList(controller.nextWeekStartDate.value, controller.nextWeekEndDate.value);
                            }, "Next Week"),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() async {
                              setState(() {
                                controller.totalLeadAmt.value = 0;
                                controller.selectedFilters.value = "This Month";
                                controller.isSelectedToday.value = false;
                                controller.dataForSelectedDate.value = "";
                                controller.isSelectedyesterday.value = false;
                                controller.currentMonth.value = "${controller.thisMonthStartFormatted.value} - ${controller.thisMonthEndFormatted.value}";
                                controller.isSelectedTomorrow.value = false;
                                controller.isSelectedLastWeek.value = false;
                                controller.isSelectedNextWeek.value = false;
                                controller.isSelectedCustom.value = false;
                                controller.isSelectedThisWeek.value = false;
                                controller.isSelectedLastMonth.value = false;
                                controller.isSelectedThisMonth.value = true;
                              });
                              await LastWeekList(controller.thisMonthStartDate.value, controller.thisMonthEndDate.value);
                            }, "This Month"),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() async {
                              setState(() {
                                controller.totalLeadAmt.value = 0;
                                controller.selectedFilters.value = "Last Month";
                                controller.isSelectedToday.value = false;
                                controller.dataForSelectedDate.value = "";
                                controller.isSelectedyesterday.value = false;
                                controller.currentMonth.value = "${controller.lastMonthStartFormatted.value} - ${controller.lastMonthEndFormatted.value}";
                                controller.isSelectedTomorrow.value = false;
                                controller.isSelectedLastWeek.value = false;
                                controller.isSelectedNextWeek.value = false;
                                controller.isSelectedCustom.value = false;
                                controller.isSelectedThisWeek.value = false;
                                controller.isSelectedThisMonth.value = false;
                                controller.isSelectedLastMonth.value = true;
                              });
                              await LastWeekList(controller.lastMonthStartDate.value, controller.lastMonthEndDate.value);
                            }, "Last Month"),
                            SizedBox(
                              width: 1.h,
                            ),
                            customFiltersDateBase(() {
                              // await DateClass().selectDate(controller.followUpDateController, false, false);
                              setState(() {
                                controller.selectedFilters.value = "Custom";
                                controller.isSelectedToday.value = false;
                                controller.currentMonth.value = "";
                                controller.isSelectedyesterday.value = false;
                                controller.dataForSelectedDate.value = "";
                                controller.isSelectedTomorrow.value = false;
                                controller.isSelectedLastWeek.value = false;
                                controller.isSelectedNextWeek.value = false;
                                controller.isSelectedThisWeek.value = false;
                                controller.isSelectedThisMonth.value = false;
                                controller.isSelectedCustom.value = true;
                                controller.isSelectedLastMonth.value = false;
                                controller.filteredLeadList.clear();
                                selectDate(controller.followUpDateController, false, false);
                                print("date custom--${controller.dataForSelectedDate.value}");
                              });
                            }, "Custom"),
                            SizedBox(
                              width: 1.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                FadeInUp(
                                  delay: Duration(milliseconds: 400),
                                  duration: Duration(milliseconds: 800),
                                  child: ContainerCustom(
                                    height: 21.9.h,
                                    width: 45.w,
                                    title: controller.isSelectedToday.value == true
                                        ? "Today's Leads Amount"
                                        : controller.isSelectedyesterday.value == true
                                            ? "Yesterday's Leads Amount"
                                            : controller.isSelectedTomorrow.value == true
                                                ? "Tomorrow's Leads Amount"
                                                : controller.isSelectedThisWeek.value == true
                                                    ? "This Week's Leads Amount"
                                                    : controller.isSelectedNextWeek.value == true
                                                        ? "Next Week's Leads Amount"
                                                        : controller.isSelectedLastWeek.value == true
                                                            ? "Last Week's Leads Amount"
                                                            : controller.isSelectedThisMonth.value == true
                                                                ? "This Month's Leads Amount"
                                                                : controller.isSelectedCustom.value == true
                                                                    ? "Custom Leads Amount"
                                                                    : "Today's Leads Amount",
                                    textColor: Colors.purple,
                                    containerColor: [Colors.white, Colors.white],
                                    details: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Obx(() => SizedBox(
                                                width: 35.w,
                                                child: Text(
                                                  "₹ ${controller.totalLeadAmt.toString()}",
                                                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Obx(() => Text(
                                                "Lead count - ${controller.filteredLeadList.length.toString()}",
                                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                FadeInRight(
                                  delay: Duration(milliseconds: 400),
                                  duration: Duration(milliseconds: 800),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.StatusfromPreSalesScreen.value = false;
                                      controller.fromPreSalesScreen.value = false;
                                      Get.off(() => LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                                    },
                                    child: ContainerCustom(
                                      height: 10.5.h,
                                      width: 45.w,
                                      title: "All Leads",
                                      textColor: Colors.amber,
                                      containerColor: [Colors.white, Colors.white],
                                      details: Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Obx(() => Text(
                                                  controller.totalLeadCount.toString(),
                                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                FadeInRight(
                                  delay: Duration(milliseconds: 500),
                                  duration: Duration(milliseconds: 800),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.StatusfromPreSalesScreen.value = true;
                                      Get.to(() => LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                                    },
                                    child: ContainerCustom(
                                      height: 10.5.h,
                                      width: 45.w,
                                      title: "New Leads",
                                      textColor: Colors.green,
                                      containerColor: [Colors.white, Colors.white],
                                      details: Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Obx(() => Text(
                                                  controller.totalNewLeadsCount.toString(),
                                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            missedFollowUpBottomSheet(context: context, controller: controller);
                          },
                          child: FadeInLeft(
                            delay: Duration(milliseconds: 600),
                            duration: Duration(milliseconds: 800),
                            child: ContainerCustom(
                              height: 10.h,
                              width: double.infinity,
                              title: "Missed Status",
                              textColor: Colors.black,
                              containerColor: [Colors.white, Colors.white],
                              details: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 35.w,
                                      child: Text(
                                        "Missed Follow Up",
                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.amber.shade900),
                                      ),
                                    ),
                                    Spacer(),
                                    Obx(() => Text(
                                          controller.missedFollowUpCount.toString(),
                                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
                                        )),
                                    SizedBox(
                                      width: 2.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        FadeInUp(
                          delay: Duration(milliseconds: 600),
                          duration: Duration(milliseconds: 800),
                          child: ContainerCustom(
                            height: 27.5.h,
                            width: double.infinity,
                            title: "Status",
                            textColor: Colors.black,
                            containerColor: [Colors.white, Colors.white],
                            details: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectedStatus.value = "Follow Up Required";
                                            Get.to(() => LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 35.w,
                                                child: Text(
                                                  "Follow Up Required",
                                                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.indigo),
                                                ),
                                              ),
                                              Obx(() => Text(
                                                    controller.followUpRequiredCount.toString(),
                                                    style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.indigo),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectedStatus.value = "Converted";
                                            Get.to(() => LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 35.w,
                                                child: Text(
                                                  "Converted",
                                                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.green),
                                                ),
                                              ),
                                              Obx(() => Text(
                                                    controller.convertedCount.toString(),
                                                    style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.green),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectedStatus.value = "Not Converted";
                                            Get.to(() => LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 35.w,
                                                child: Text(
                                                  "Not Converted",
                                                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.red),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 1.h,
                                              // ),
                                              Obx(() => Text(
                                                    controller.notConvertedCount.toString(),
                                                    style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.red),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectedStatus.value = "Interested";
                                            Get.to(() => LeadManagementListScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 35.w,
                                                child: Text(
                                                  "Interested",
                                                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.amber),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 1.h,
                                              // ),
                                              Obx(() => Text(
                                                    controller.interestedCount.toString(),
                                                    style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.amber),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 20.h,
                                          child: Obx(() {
                                            List<Map<String, dynamic>> sections = [
                                              {
                                                "label": "Follow Up",
                                                "value": controller.followUpRequiredCount.value,
                                                "color": Color(0xFFB0E0E6),
                                              },
                                              {
                                                "label": "Converted",
                                                "value": controller.convertedCount.value,
                                                "color": Color(0xFF98FB98),
                                              },
                                              {
                                                "label": "Not Converted",
                                                "value": controller.notConvertedCount.value,
                                                "color": Color(0xFFF08080),
                                              },
                                              {
                                                "label": "Interested",
                                                "value": controller.interestedCount.value,
                                                "color": Colors.amber[100],
                                              },
                                            ].where((item) => (item["value"] as int) > 0).toList();

                                            return Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                PieChart(
                                                  PieChartData(
                                                    sections: _generateSections(sections),
                                                    sectionsSpace: 0,
                                                    centerSpaceRadius: 40,
                                                    pieTouchData: PieTouchData(
                                                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                                        if (event.isInterestedForInteractions && pieTouchResponse != null && pieTouchResponse.touchedSection != null) {
                                                          final newIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;

                                                          if (newIndex >= 0 && newIndex < sections.length) {
                                                            touchedIndex = newIndex;
                                                            centerText = "${sections[newIndex]["value"]} ${sections[newIndex]["label"]}";
                                                          } else {
                                                            touchedIndex = null;
                                                            centerText = "";
                                                          }
                                                        } else {
                                                          touchedIndex = null;
                                                          centerText = "";
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  centerText,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
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
                        FadeInUp(
                          delay: Duration(milliseconds: 700),
                          duration: Duration(milliseconds: 800),
                          child: ContainerCustom(
                            height: 35.h,
                            width: double.infinity,
                            title: controller.isSelectedToday.value == true
                                ? "Today's Follow Up"
                                : controller.isSelectedyesterday.value == true
                                    ? "Yesterday's Follow Up"
                                    : controller.isSelectedTomorrow.value == true
                                        ? "Tomorrow's Follow Up"
                                        : controller.isSelectedNextWeek.value == true
                                            ? "Next Week's Follow Up"
                                            : controller.isSelectedThisWeek.value == true
                                                ? "This Week's Follow Up"
                                                : controller.isSelectedLastWeek.value == true
                                                    ? "Last Week's Follow Up"
                                                    : controller.isSelectedThisMonth.value == true
                                                        ? "This Month's  Follow Up"
                                                        : controller.isSelectedCustom.value == true
                                                            ? "Custom Follow Up"
                                                            : "Today's Follow Up",
                            textColor: Colors.indigo,
                            containerColor: [Colors.white, Colors.white],
                            details: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Obx(() => Row(
                                        children: [
                                          Text(
                                            controller.currentMonth.value,
                                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Obx(() {
                                    return controller.filteredLeadList.isEmpty
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                FadeIn(
                                                    delay: const Duration(milliseconds: 300),
                                                    duration: const Duration(milliseconds: 300),
                                                    child: LottieBuilder.asset(
                                                      "assets/lottie/empty.json",
                                                      height: 20.w,
                                                    )),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Obx(() => FadeIn(
                                                      delay: const Duration(milliseconds: 500),
                                                      duration: const Duration(milliseconds: 500),
                                                      child: SizedBox(
                                                        width: 60.w,
                                                        child: Text(
                                                          "No Follow Up pending ${controller.dataForSelectedDate.value}",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp, color: Colors.grey.shade600),
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ))
                                        : Obx(() {
                                            return SizedBox(
                                              height: 20.h,
                                              child: ListView.builder(
                                                physics: BouncingScrollPhysics(),
                                                itemCount: controller.filteredLeadList.length,
                                                itemBuilder: (context, index) {
                                                  var item = controller.filteredLeadList[index];

                                                  var amt = item.amount == null ? 0.0 : item.amount.toString();
                                                  return Padding(
                                                    padding: const EdgeInsets.only(bottom: 1.0, top: 8),
                                                    child: FadeInRight(
                                                      delay: Duration(milliseconds: 500 + (index * 100)),
                                                      duration: const Duration(milliseconds: 500),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              () => OpenLeadManagementScreen(
                                                                    leadValue: item,
                                                                    materialList: controller.materialLists,
                                                                    serviceList: controller.serviceLists,
                                                                    index: index,
                                                                  ),
                                                              transition: Transition.rightToLeft);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(border: Border.all(color: Colors.indigo.shade50), borderRadius: BorderRadius.circular(15), color: kColorwhite),
                                                          child: ListTile(
                                                            title: Text(item.leadName.toString()),
                                                            subtitle: Text(DateClass().showDate(item.followUpDate.toString())),
                                                            trailing: Text(amt.toString()),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          });
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
                // Spacer(),
                // GestureDetector(
                //   onTap: () {

                //   },
                //   child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: kColorlightBlue,
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Center(
                //             child: Text(
                //           "Lead Manangment List",
                //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.sp),
                //         )),
                //       )),
                // )
              ],
            ),
          ))),
    );
  }

  // List<PieChartSectionData> _generateSections(List<Map<String, dynamic>> sections) {
  //   return List.generate(sections.length, (index) {
  //     return PieChartSectionData(
  //       value: sections[index]["value"].toDouble(),
  //       color: sections[index]["color"],
  //       title: "",
  //       titleStyle: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: Colors.white),
  //       radius: touchedIndex == index ? 37 : 30,
  //       borderSide: BorderSide(style: BorderStyle.solid, width: 1, color: Colors.white),
  //     );
  //   });
  // }

  List<PieChartSectionData> _generateSections(List<Map<String, dynamic>> sections) {
    return List.generate(sections.length, (index) {
      return PieChartSectionData(
        value: (sections[index]["value"] as num).toDouble(),
        color: sections[index]["color"],
        title: "",
        showTitle: false,
        titleStyle: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: Colors.white),
        radius: touchedIndex == index ? 37 : 30,
        borderSide: BorderSide(style: BorderStyle.solid, width: 1, color: Colors.white),
      );
    });
  }

  var selectedDate = DateTime.now().obs;
  selectDate(TextEditingController controllers, bool enquiryDate, bool poEndDate) async {
    // print("selected date ---$selectedDate");
    print("selected date ---$selectedDate");

    final DateTime initialDate = selectedDate.value.isAfter(DateTime(2100)) ? DateTime(2100) : selectedDate.value;

    final DateTime firstDate = poEndDate ? DateTime.now() : DateTime(2000);
    final DateTime lastDate = enquiryDate ? DateTime.now() : DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;

      controllers.text = DateFormat('dd/MM/yyyy').format(selectedDate.value).toString();
      controller.currentMonth.value = DateFormat('dd MMMM yyyy').format(selectedDate.value);

      print("selected date---${controller.dataForSelectedDate.value}");
      controller.dataForSelectedDate.value = DateClass().showDate(controllers.text);

      customDetails(controllers.text);
    }
  }

  GestureDetector customFiltersDateBase(
    VoidCallback ontapFunction,
    String title,
  ) {
    bool isSelected = controller.selectedFilters.value == title;
    return GestureDetector(
      onTap: ontapFunction,
      child: Container(
        // height: 5.h,
        // width: 30.w,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.blue : Colors.white, width: 2),
          color: Colors.white, // Change color based on selection
          boxShadow: kElevationToShadow[1],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 8, bottom: 8),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              color: isSelected ? Colors.blue : Colors.black, // Change text color
            ),
          )),
        ),
      ),
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
            createWidgetCustom(
                ontap: () async {
                  // contactController.fetchContacts();
                  // await Get.to(() => ContactListScreen(materialList: controller.materialLists, serviceList: controller.serviceLists));
                },
                icons: Icons.import_contacts,
                title: "Import from Contacts"),
            createWidgetCustom(
                ontap: () {
                  // Get.to(() => NewLeadManagementAddScreen(isEdit: false, materialList: controller.materialLists, serviceList: controller.serviceLists),
                  //     duration: Duration(milliseconds: 500), transition: Transition.fadeIn);
                },
                icons: Icons.add_circle_outlined,
                title: "Create New Lead")
          ],
        ),
      ),
    );
  }

  TodayDetails() async {
    await controller.getLeadList("", 1, "desc", "leadGenerationDate", "", false, "0", "0", "");
    print("lead length--${controller.leadList.length}");
    controller.filteredLeadList.value = controller.leadList.where((item) {
      return item.followUpDate != null && DateClass().showDate(item.followUpDate!) == controller.dataForSelectedDate.value;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
    print("totalAmount-today-${controller.totalLeadAmt.value}");
  }

  yesterdayDetails() {
    controller.filteredLeadList.value = controller.leadList.where((item) {
      return item.followUpDate != null && DateClass().showDate(item.followUpDate!) == controller.dataForSelectedDate.value;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
    print("totalAmount--${controller.totalLeadAmt.value}");
  }

  tomorrowDetails() {
    controller.filteredLeadList.value = controller.leadList.where((item) {
      return item.followUpDate != null && DateClass().showDate(item.followUpDate!) == controller.dataForSelectedDate.value;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
    print("totalAmount--${controller.totalLeadAmt.value}");
  }

  customDetails(var selectedDate) {
    print("selected date --- 1---$selectedDate");
    controller.filteredLeadList.value = controller.leadList.where((item) {
      if (item.followUpDate == null) return false;
      print(DateClass().showDate(item.followUpDate!));
      return DateClass().showDate(item.followUpDate!) == selectedDate;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
    print("totalAmount--${controller.totalLeadAmt.value}");
  }

  LastWeekList(var firstDate, var lastDate) {
    controller.filteredLeadList.clear();
    DateTime startDate = DateFormat('dd/MM/yyyy').parse(firstDate);
    DateTime endDate = DateFormat('dd/MM/yyyy').parse(lastDate);

    print("Start Date: ${startDate.toString()}");
    print("End Date: ${endDate.toString()}");
    controller.dataForSelectedDate.value = "${DateClass().showDate(startDate.toString())} - ${DateClass().showDate(endDate.toString())}";

    controller.filteredLeadList.value = controller.leadList.where((item) {
      print(item.followUpDate);
      if (item.followUpDate == null) return false;

      DateTime? itemDate;
      try {
        itemDate = DateFormat('dd/MM/yyyy').parse(DateClass().showDate(item.followUpDate!.toString()));
      } catch (e) {
        print("Error parsing followUpDate: $e");
        return false;
      }
      return itemDate.isAfter(startDate.subtract(Duration(days: 1))) && itemDate.isBefore(endDate.add(Duration(days: 1)));
    }).toList();

    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
    print("totalAmount--${controller.totalLeadAmt.value}");

    print("Filtered List Length: ${controller.filteredLeadList.length}");
  }
}

missedFollowUpBottomSheet({required BuildContext context, required GetLeadController controller}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5.w), topRight: Radius.circular(5.w))),
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "  Missed Follow Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  Spacer(),
                  CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close)),
                  )
                ],
              ),
            ),
            Obx(() => controller.missedFollowUpList.isEmpty
                ? Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 300), child: LottieBuilder.asset(emptyLottie)),
                        SizedBox(
                          height: 3.h,
                        ),
                        FadeIn(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            "Your List is Empty",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                          ),
                        )
                      ],
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.missedFollowUpList.length,
                      itemBuilder: (context, index) {
                        var item = controller.missedFollowUpList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 1.0, top: 8, left: 8, right: 8),
                          child: FadeInRight(
                            duration: const Duration(milliseconds: 500),
                            child: GestureDetector(
                              onTap: () async {
                                controller.isCalledGetAllLeads.value = true;
                                print("missed up id--${item.leadId}");
                                Get.off(
                                    () => LeadManagementListScreen(
                                          missedUpId: item.leadId,
                                        ),
                                    transition: Transition.fade,
                                    duration: Duration(milliseconds: 600));
                              },
                              child: Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.indigo.shade50), borderRadius: BorderRadius.circular(15), color: kColorwhite),
                                child: ListTile(
                                  title: Text(item.leadName ?? ""),
                                  subtitle: Text(item.phone ?? ""),
                                  trailing: Text(
                                    DateClass().showDate(item.followUpDate),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ))
          ],
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class ContainerCustom extends StatelessWidget {
  double height;
  double width;
  Widget details;
  String title;
  List<Color> containerColor;
  Color textColor;

  ContainerCustom({
    super.key,
    required this.height,
    required this.width,
    required this.details,
    required this.title,
    required this.containerColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          // boxShadow: kElevationToShadow[1],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: containerColor, // Gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 16.sp),
                  ),
                ),
              ),
              details,
            ],
          ),
        ));
  }
}
