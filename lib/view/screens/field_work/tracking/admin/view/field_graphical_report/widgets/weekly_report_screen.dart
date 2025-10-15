import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/view/field_graphical_report/widgets/custom_widgets/custom_progreess_container.dart';
import 'package:work_Force/view/screens/field_work/tracking/admin/view/field_graphical_report/widgets/custom_widgets/progress_graph_chart.dart';

class DateWiseReportScreen extends StatelessWidget {
  const DateWiseReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> data = {
      'Todo': 40,
      'Progress': 30,
      'Done': 30,
    };

    List<double> getValues(Map<String, double> data) {
      return data.values.toList();
    }

    final List<Color> colors = [
      Colors.redAccent,
      Colors.orangeAccent,
      Colors.greenAccent,
    ];
    final List<int> totalTasks = [20, 80, 60, 77, 19, 46, 49];
    final List<int> avgCompletion = [60, 50, 70, 40, 80, 30, 90];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            customProgressContainer(
                IscontainerGradient: false,
                graphPlaceholder: Row(
                  children: [
                    Flexible(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: Size(45.w, 45.w),
                            painter: DonutPainter(getValues(data), colors),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${data['Done']}%",
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Completed",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    buildLegend(data, colors),
                  ],
                ),
                iconData: Icons.pie_chart_outline,
                title: "Status Breakdown",
                subtitle: "Week to date",
                customChildren: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: EdgeInsets.only(
                        left: 6.5.w, right: 6.5.w, top: 3.w, bottom: 3.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(3.w)),
                    child: Column(
                      children: [
                        Text("12",
                            style: TextStyle(
                                fontSize: 15.5.sp,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "To Do",
                          style: TextStyle(fontSize: 15.5.sp),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: EdgeInsets.only(
                        left: 6.5.w, right: 6.5.w, top: 3.w, bottom: 3.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(3.w)),
                    child: Column(
                      children: [
                        Text("18",
                            style: TextStyle(
                                fontSize: 15.5.sp,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "Progress",
                          style: TextStyle(fontSize: 15.5.sp),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: EdgeInsets.only(
                        left: 6.5.w, right: 6.5.w, top: 3.w, bottom: 3.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(3.w)),
                    child: Column(
                      children: [
                        Text("32",
                            style: TextStyle(
                                fontSize: 15.5.sp,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "Done",
                          style: TextStyle(fontSize: 15.5.sp),
                        )
                      ],
                    ),
                  ),
                ]),
            SizedBox(
              height: 1.5.h,
            ),
            customProgressContainer(
                IscontainerGradient: false,
                iconData: Icons.calendar_month_outlined,
                title: "This Week Overview",
                subtitle: "Mon-Fri",
                graphPlaceholder: SizedBox(
                  height: 20.h,
                  child: WeeklyProgressChart(
                      totalTasks: totalTasks, avgCompletion: avgCompletion),
                ),
                customChildren: [
                  Container(
                    height: 8.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey.shade200),
                        color: const Color.fromARGB(12, 187, 222, 251),
                        borderRadius: BorderRadius.circular(3.w)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "214",
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 0.3.h),
                          Text("Total Tasks",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.grey.shade600))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 8.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color.fromARGB(12, 187, 222, 251),
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(3.w)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "72%",
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 0.3.h),
                          Text("Avg Completion",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.grey.shade600))
                        ],
                      ),
                    ),
                  )
                ]),
            SizedBox(
              height: 1.5.h,
            ),
            customProgressContainer(
                // IscontainerGradient: false,
                iconData: Icons.summarize_outlined,
                title: "Weekly Summary",
                subtitle: "Breakdown by agent",
                IscontainerGradient: false,
                graphPlaceholder: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        // backgroundColor: Colors.green.shade100,
                        radius: 20,
                        backgroundImage:
                            AssetImage("assets/Images/2663543.jpg"),
                      ),
                      title: Text("Ava",
                          style: TextStyle(
                              fontSize: 16.5.sp, fontWeight: FontWeight.bold)),
                      subtitle: const Text("34 Done ● 5 In Progress ● 1 To Do"),
                      trailing: Container(
                        decoration: BoxDecoration(
                            color: kColorLightBlueAppBar,
                            borderRadius: BorderRadius.circular(3.w)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("85%",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        // backgroundColor: Colors.green.shade100,
                        radius: 20,
                        backgroundImage:
                            AssetImage("assets/Images/profile_pic.jpg"),
                      ),
                      title: Text("Jane Smith",
                          style: TextStyle(
                              fontSize: 16.5.sp, fontWeight: FontWeight.bold)),
                      subtitle: const Text("34 Done ● 5 In Progress ● 1 To Do"),
                      trailing: Container(
                        decoration: BoxDecoration(
                            color: kColorLightBlueAppBar,
                            borderRadius: BorderRadius.circular(3.w)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("70%",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        // backgroundColor: Colors.green.shade100,
                        radius: 20,
                        backgroundImage:
                            AssetImage("assets/Images/2663543.jpg"),
                      ),
                      title: Text("Alice Johnson",
                          style: TextStyle(
                              fontSize: 16.5.sp, fontWeight: FontWeight.bold)),
                      subtitle: const Text("34 Done ● 5 In Progress ● 1 To Do"),
                      trailing: Container(
                        decoration: BoxDecoration(
                            color: kColorLightBlueAppBar,
                            borderRadius: BorderRadius.circular(3.w)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("55%",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
                customChildren: []),
          ],
        ),
      ),
    );
  }

  Widget buildLegend(Map<String, double> data, List<Color> colors) {
    final entries = data.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(entries.length, (i) {
        final e = entries[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 14, height: 14, color: colors[i % colors.length]),
              const SizedBox(width: 8),
              Text('${e.key} — ${e.value.toStringAsFixed(0)}'),
            ],
          ),
        );
      }),
    );
  }
}

class DonutPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  DonutPainter(this.values, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final total = values.fold(0.0, (a, b) => a + b);
    double startAngle = -90.0; // start from top
    final radius = size.width / 2;

    for (int i = 0; i < values.length; i++) {
      final sweep = (values[i] / total) * 360;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 25
        ..strokeCap = StrokeCap.round; // 👈 rounded ends

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius - 30),
        radians(startAngle),
        radians(sweep),
        false,
        paint,
      );
      startAngle += sweep;
    }
  }

  double radians(double deg) => deg * 3.141592653589793 / 180;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
