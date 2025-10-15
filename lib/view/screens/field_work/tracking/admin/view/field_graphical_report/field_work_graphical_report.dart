import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/view/field_graphical_report/widgets/weekly_report_screen.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/view/user_field_work_screen.dart';

class FieldWorkGraphicalReport extends StatefulWidget {
  const FieldWorkGraphicalReport({super.key});

  @override
  State<FieldWorkGraphicalReport> createState() =>
      _FieldWorkGraphicalReportState();
}

class _FieldWorkGraphicalReportState extends State<FieldWorkGraphicalReport> {
  List<String> dropdownItems = [
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Field Graphical Report"),
          titleTextStyle: TextStyle(
              color: kColorblack, fontWeight: FontWeight.bold, fontSize: 18.sp),
          centerTitle: true,
          backgroundColor: kColorwhite,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const UserFieldWorkScreen(),
                      transition: Transition.rightToLeft);
                },
                icon: Icon(
                  Icons.list_rounded,
                  color: kColorblack,
                ))
          ],
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: kColorblack,
              size: 25,
            ),
            onPressed: (() {
              Get.back();
            }),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: kColorLightBlueAppBar,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: dropdownItems.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: dropdownItems[0],
                            icon:  Icon(Icons.keyboard_arrow_down,color: kColorlightBlue,),
                            elevation: 16,
                            style: TextStyle(
                                color: kColorblack,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                var selectedValue = newValue!;
                              });
                            },
                            items: dropdownItems
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        color: kColorlightBlue)),
                              );
                            }).toList(),
                          ),
                        )
                      : null,
                ),
                SizedBox(
                  width: 2.w,
                )
              ],
            ),
            const Expanded(child: DateWiseReportScreen()),
          ],
        ),
      ),
    );
  }
}
