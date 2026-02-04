import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';
import 'package:work_Force/controllers/lead_contact_details_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:work_Force/view/screens/pre_sales/widget/custom_card.dart';
import 'package:work_Force/view/screens/pre_sales/widget/custom_status_card.dart';
import 'package:work_Force/view/screens/pre_sales/widget/filter_chip.dart';
import 'package:work_Force/view/screens/pre_sales/widget/followup_section.dart';
import 'package:work_Force/view/screens/pre_sales/widget/missed_followup_bottomsheet.dart';
import 'package:work_Force/view/widget/popup_with_lottie.dart';

class PreSaleScreen extends StatefulWidget {
  const PreSaleScreen({super.key});

  @override
  State<PreSaleScreen> createState() => _PreSaleScreenState();
}

class _PreSaleScreenState extends State<PreSaleScreen>
    with TickerProviderStateMixin {
  final controller = Get.find<GetLeadController>();
  final contactController = Get.put(LeadContactDetaisController());
  int? touchedIndex;
  String centerText = "";

  @override
  void initState() {
    controller.fromPreSalesScreen.value = true;
    controller.StatusfromPreSalesScreen.value = false;
    todayDetails();
    controller.getAllLead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await popupWithLottie(
            context: context,
            ontap: () {
              SystemNavigator.pop();
            },
            oncancel: () {
              Get.back();
            },
            title: "Are you Sure \nyou want to Exit?",
            lottie: exitLottie);
        return value == true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Pre Sales"),
            titleTextStyle: TextStyle(
                color: kColorblack,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(right: 2.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.fromPreSalesScreen.value = false;
                      controller.isCalledGetAllLeads.value = false;
                      Get.to(LeadManagementListScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 600));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(Icons.list_rounded, color: Colors.white),
                    ),
                  ),
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
                  duration: const Duration(milliseconds: 800),
                  child: SizedBox(
                    height: 6.h,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildFilterChip(() async {
                            setState(() {
                              controller.selectedFilters.value = "Today";
                              controller.totalLeadAmt.value = 0;
                              controller.currentMonth.value =
                                  controller.TodayDate.value;
                              controller.dataForSelectedDate.value =
                                  controller.TodayDateNumber.value;
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
                            await todayDetails();
                          }, "Today", Icons.today, controller),
                          SizedBox(width: 2.w),
                          buildFilterChip(() async {
                            setState(() {
                              controller.selectedFilters.value = "Yesterday";
                              controller.totalLeadAmt.value = 0;
                              controller.currentMonth.value =
                                  controller.yesterdayFormatted.value;
                              controller.dataForSelectedDate.value =
                                  controller.yesterdaydate.value;
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
                          }, "Yesterday", Icons.history, controller),
                          SizedBox(width: 2.w),
                          buildFilterChip(() async {
                            setState(() {
                              controller.selectedFilters.value = "Tomorrow";
                              controller.totalLeadAmt.value = 0;
                              controller.currentMonth.value =
                                  controller.tomorrowFormatted.value;
                              controller.dataForSelectedDate.value =
                                  controller.tomorrowdate.value;
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
                          }, "Tomorrow", Icons.event, controller),
                          SizedBox(width: 2.w),
                          buildFilterChip(() async {
                            setState(() {
                              controller.totalLeadAmt.value = 0;
                              controller.selectedFilters.value = "This Week";
                              controller.dataForSelectedDate.value = "";
                              controller.currentMonth.value =
                                  "${controller.thisWeekStartFormatted.value} - ${controller.thisWeekEndFormatted.value}";
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
                            await lastWeekList(
                                controller.thisWeekStartDate.value,
                                controller.thisWeekEndDate.value);
                          }, "This Week", Icons.date_range, controller),
                          SizedBox(width: 2.w),
                          buildFilterChip(() async {
                            setState(() {
                              controller.totalLeadAmt.value = 0;
                              controller.selectedFilters.value = "This Month";
                              controller.isSelectedToday.value = false;
                              controller.dataForSelectedDate.value = "";
                              controller.isSelectedyesterday.value = false;
                              controller.currentMonth.value =
                                  "${controller.thisMonthStartFormatted.value} - ${controller.thisMonthEndFormatted.value}";
                              controller.isSelectedTomorrow.value = false;
                              controller.isSelectedLastWeek.value = false;
                              controller.isSelectedNextWeek.value = false;
                              controller.isSelectedCustom.value = false;
                              controller.isSelectedThisWeek.value = false;
                              controller.isSelectedLastMonth.value = false;
                              controller.isSelectedThisMonth.value = true;
                            });
                            await lastWeekList(
                                controller.thisMonthStartDate.value,
                                controller.thisMonthEndDate.value);
                          }, "This Month", Icons.calendar_month, controller),
                          SizedBox(width: 2.w),
                          buildFilterChip(() {
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
                              selectDate(controller.followUpDateController,
                                  false, false);
                            });
                          }, "Custom", Icons.edit_calendar, controller),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: FadeInUp(
                                delay: const Duration(milliseconds: 200),
                                duration: const Duration(milliseconds: 800),
                                child: buildKPICard(
                                  height: 22.h,
                                  title: controller.isSelectedToday.value ==
                                          true
                                      ? "Today's Leads Amount"
                                      : controller.isSelectedyesterday.value ==
                                              true
                                          ? "Yesterday's Leads Amount"
                                          : controller.isSelectedTomorrow
                                                      .value ==
                                                  true
                                              ? "Tomorrow's Leads Amount"
                                              : controller.isSelectedThisWeek
                                                          .value ==
                                                      true
                                                  ? "This Week's Leads Amount"
                                                  : controller.isSelectedNextWeek
                                                              .value ==
                                                          true
                                                      ? "Next Week's Leads Amount"
                                                      : controller.isSelectedLastWeek
                                                                  .value ==
                                                              true
                                                          ? "Last Week's Leads Amount"
                                                          : controller.isSelectedThisMonth
                                                                      .value ==
                                                                  true
                                                              ? "This Month's Leads Amount"
                                                              : controller.isSelectedCustom
                                                                          .value ==
                                                                      true
                                                                  ? "Custom Leads Amount"
                                                                  : "Today's Leads Amount",
                                  gradient: [
                                    const Color(0xFF667eea),
                                    const Color(0xFF764ba2)
                                  ],
                                  icon: Icons.currency_rupee_rounded,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() => Text(
                                            "₹${controller.totalLeadAmt.toString()}",
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                      SizedBox(height: 0.3.h),
                                      Obx(() => Text(
                                            "Lead count - ${controller.filteredLeadList.length.toString()}",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                                    .withValues(alpha: 0.9)),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Column(
                                children: [
                                  FadeInRight(
                                    delay: const Duration(milliseconds: 300),
                                    duration: const Duration(milliseconds: 800),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.StatusfromPreSalesScreen
                                            .value = false;
                                        controller.fromPreSalesScreen.value =
                                            false;
                                        Get.off(
                                            () => LeadManagementListScreen(),
                                            transition: Transition.fade,
                                            duration:
                                                const Duration(milliseconds: 600));
                                      },
                                      child: buildKPICard(
                                        height: 11.h,
                                        title: "All Leads",
                                        gradient: [
                                          const Color(0xFFf093fb),
                                          const Color(0xFFf5576c)
                                        ],
                                        icon: Icons.people_alt_rounded,
                                        child: Obx(() => Text(
                                              controller.totalLeadCount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 01.h),
                                  FadeInRight(
                                    delay: const Duration(milliseconds: 400),
                                    duration: const Duration(milliseconds: 800),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.StatusfromPreSalesScreen
                                            .value = true;
                                        Get.to(() => LeadManagementListScreen(),
                                            transition: Transition.fade,
                                            duration:
                                                const Duration(milliseconds: 600));
                                      },
                                      child: buildKPICard(
                                        height: 11.h,
                                        title: "New Leads",
                                        gradient: [
                                          const Color(0xFF43e97b),
                                          const Color(0xFF38f9d7)
                                        ],
                                        icon: Icons.fiber_new_rounded,
                                        child: Obx(() => Text(
                                              controller.totalNewLeadsCount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        GestureDetector(
                          onTap: () {
                            missedFollowUpBottomSheet(
                                context: context, controller: controller);
                          },
                          child: FadeInLeft(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 800),
                            child: buildKPICard(
                              height: 10.h,
                              title: "Missed Follow Up",
                              gradient: [const Color(0xFFfa709a), const Color(0xFFfee140)],
                              icon: Icons.warning_amber_rounded,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Requires Attention",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                            .withValues(alpha: 0.9)),
                                  ),
                                  Obx(() => Text(
                                        controller.missedFollowUpCount
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 800),
                          child: FollowUpSection(),
                        ),
                        SizedBox(height: 2.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 800),
                          child: StatusSection(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  var selectedDate = DateTime.now().obs;
  selectDate(TextEditingController controllers, bool enquiryDate,
      bool poEndDate) async {
    final DateTime initialDate = selectedDate.value.isAfter(DateTime(2100))
        ? DateTime(2100)
        : selectedDate.value;
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
      controllers.text =
          DateFormat('dd/MM/yyyy').format(selectedDate.value).toString();
      controller.currentMonth.value =
          DateFormat('dd MMMM yyyy').format(selectedDate.value);
      controller.dataForSelectedDate.value =
          DateClass().showDate(controllers.text);
      customDetails(controllers.text);
    }
  }

  todayDetails() async {
    await controller.getLeadList(
        "", 1, "desc", "leadGenerationDate", "", false, "0", "0", "");
    controller.filteredLeadList.value = controller.leadList.where((item) {
      return item.followUpDate != null &&
          DateClass().showDate(item.followUpDate!) ==
              controller.dataForSelectedDate.value;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      if (item.amount == null) return sum;
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
  }

  yesterdayDetails() {
    controller.filteredLeadList.value = controller.leadList.where((item) {
      return item.followUpDate != null &&
          DateClass().showDate(item.followUpDate!) ==
              controller.dataForSelectedDate.value;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      if (item.amount == null) return sum;
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
  }

  tomorrowDetails() {
    controller.filteredLeadList.value = controller.leadList.where((item) {
      return item.followUpDate != null &&
          DateClass().showDate(item.followUpDate!) ==
              controller.dataForSelectedDate.value;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      if (item.amount == null) return sum;
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
  }

  customDetails(var selectedDate) {
    controller.filteredLeadList.value = controller.allLeadList.where((item) {
      if (item.followUpDate == null) return false;
      return DateClass().showDate(item.followUpDate!) == selectedDate;
    }).toList();
    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      if (item.amount == null) return sum;
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
  }

  lastWeekList(var firstDate, var lastDate) {
    controller.filteredLeadList.clear();
    DateTime startDate = DateFormat('dd/MM/yyyy').parse(firstDate);
    DateTime endDate = DateFormat('dd/MM/yyyy').parse(lastDate);

    controller.dataForSelectedDate.value =
        "${DateClass().showDate(startDate.toString())} - ${DateClass().showDate(endDate.toString())}";

    controller.filteredLeadList.value = controller.leadList.where((item) {
      if (item.followUpDate == null) return false;
      DateTime? itemDate;
      try {
        itemDate = DateFormat('dd/MM/yyyy')
            .parse(DateClass().showDate(item.followUpDate!.toString()));
      } catch (e) {
        return false;
      }
      return itemDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          itemDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    var amt = controller.filteredLeadList.fold(0.0, (sum, item) {
      if (item.amount == null) return sum;
      return sum + item.amount!;
    });
    controller.totalLeadAmt.value = amt.round();
  }
}
