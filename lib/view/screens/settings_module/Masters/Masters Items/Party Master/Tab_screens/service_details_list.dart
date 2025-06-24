
// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/get_party_master_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/utils/Date.dart';

class ServiceDetails extends StatefulWidget {
  final PartyMasterController controller;
  final PartyDTO? partyMasterSaved;
  const ServiceDetails({
    super.key,
    required this.controller,
    this.partyMasterSaved,
  });

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  void initState() {
    widget.controller.getFinancialYearList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 5.5.h,
              // width: 75.w,
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                color: kColorwhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: TextField(
                onChanged: (value) {
                  widget.controller.searchController.text = value;
                  widget.controller.getServiceList(
                    widget.controller.selectedtransactiontypeId.value,
                    widget.controller.financialYearIdInvoice.value,
                    widget.partyMasterSaved!.id!,
                    value,
                    widget.controller.selectedStatusId.value,
                  );
                },
                controller: widget.controller.searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search Here',
                  hintStyle: TextStyle(color: kColorgrey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(2.w),
                  height: 7.h,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const Divider(
                      color: Color.fromARGB(255, 220, 220, 220),
                      thickness: 1,
                      height: 1,
                    ),
                    value: widget.controller.financialYearList.any((item) =>
                            item.id.toString() ==
                            widget.controller.financialYearId.value)
                        ? widget.controller.financialYearId.value
                        : null, // Set to null if not found
                    items: [
                      const DropdownMenuItem<String>(
                        value: "",
                        child: Text("Financial Year"),
                      ),
                      ...widget.controller.financialYearList
                          .map((item) => DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text("${item.financialYear}"),
                              )),
                    ],
                    onChanged: (newValue) async {
                      if (newValue != null) {
                        setState(() {
                          widget.controller.financialYearId.value = newValue;

                          widget.controller.financialYear.value = widget
                              .controller.financialYearList
                              .firstWhere(
                                  (item) => item.id.toString() == newValue)
                              .financialYear!;
                        });

                        widget.controller.serviceListItems.clear();

                        await widget.controller.getServiceList(
                          widget.controller.selectedtransactiontypeId.value,
                          widget.controller.financialYearId.value,
                          widget.partyMasterSaved!.id!,
                          widget.controller.searchController.text,
                          widget.controller.selectedStatusId.value,
                        );
                      }
                    },
                    hint: const Text('Select an item'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.all(2.w),
                    height: 7.h,
                    // width: 30.w,
                    child: DropdownButton(
                      isExpanded: true,
                      underline: const Divider(
                        color: Color.fromARGB(255, 220, 220, 220),
                        thickness: 1,
                        height: 1,
                      ),
                      value: widget.controller.selectedStatusId.value,
                      items: [
                        const DropdownMenuItem<String>(
                          value: "",
                          child: Text("Status"),
                        ),
                        ...widget.controller.statusOptions
                            .map((item) => DropdownMenuItem<String>(
                                  value: item['id'].toString(),
                                  child: Text("${item['name']}"),
                                )),
                      ],
                      onChanged: (newValue) async {
                        setState(() {
                          widget.controller.selectedStatusId.value = newValue!;

                          widget.controller.selectedStatus.value = widget
                              .controller.statusOptions
                              .firstWhere((item) =>
                                  item['id'].toString() ==
                                  widget.controller.selectedStatusId
                                      .value)['name']!;
                        });
                        widget.controller.serviceListItems.clear();

                        await widget.controller.getServiceList(
                          widget.controller.selectedtransactiontypeId.value,
                          widget.controller.financialYearId.value,
                          widget.partyMasterSaved!.id!,
                          widget.controller.searchController.text,
                          widget.controller.selectedStatusId.value,
                        );
                      },
                      hint: const Text('Select an item'),
                    )),
              ),
            ],
          ),
          Expanded(
              child: Obx(
            () => widget.controller.serviceListItems.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 300),
                          child: LottieBuilder.asset(
                            "assets/lottie/empty.json",
                            width: 70.w,
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      FadeIn(
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          "Data is Empty ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: widget.controller.serviceListItems.length,
                    itemBuilder: (context, index) {
                      var item = widget.controller.serviceListItems[index];
                      // Parse Start and End Dates
                      DateTime startDate =
                          DateTime.parse(item.serviceStartDate!);
                      DateTime endDate = DateTime.parse(item.serviceEndDate!);

                      Map<String, Color> statusInfo = widget.controller
                          .getPlanStatuss(
                              startDate: startDate, endDate: endDate);
                      String statusText = statusInfo.keys.first;
                      Color statusColor = statusInfo.values.first;
                      // Get Plan Status
                      return Card(
                        color: kColorLightGrey,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.all(2.w),
                        child: ExpansionTile(
                          title: Text(
                            "Service : ${item.serviceName ?? ""}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Status: ${statusText}",
                              style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.w500)),
                          children: [
                            ListTile(
                              title: const Text('Invoice Number'),
                              subtitle: Text(item.invoiceNumber.toString()),
                            ),
                            ListTile(
                              title: const Text('Start Date'),
                              subtitle: Text(DateClass()
                                  .showDate(item.serviceStartDate ?? "")),
                            ),
                            ListTile(
                              title: const Text('End Date'),
                              subtitle: Text(DateClass()
                                  .showDate(item.serviceEndDate ?? "")),
                            ),
                            ListTile(
                              title: const Text('Price'),
                              subtitle: Text(item.price.toString()),
                            ),
                            ListTile(
                              title: const Text('Status'),
                              subtitle: Text(item.statusName ?? ""),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ))
        ],
      ),
    );
  }
}