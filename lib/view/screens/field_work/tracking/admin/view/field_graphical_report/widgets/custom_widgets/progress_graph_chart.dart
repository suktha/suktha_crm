import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WeeklyProgressChart extends StatelessWidget {
  final List<int> totalTasks;
  final List<int> avgCompletion;

  const WeeklyProgressChart({
    super.key,
    required this.totalTasks,
    required this.avgCompletion,
  });

  @override
  Widget build(BuildContext context) {
    // Find the max value from both lists
    final maxY = ([
              totalTasks.reduce((a, b) => a > b ? a : b),
              avgCompletion.reduce((a, b) => a > b ? a : b),
            ].reduce((a, b) => a > b ? a : b) +
            5)
        .toDouble();

    return SizedBox(
      height: 20.h,
      child: Row(
        children: [
          // 30% width → Y-axis numbers
          Container(
            width: 10.w,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  final value = (maxY / 5) * (5 - i);
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12),
                  );
                }),
              ),
            ),
          ),

          // 70% width → Bar chart
          SizedBox(
            width: 75.w,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barGroups: List.generate(7, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: totalTasks[i].toDouble(),
                        color: const Color.fromARGB(255, 33, 149, 243),
                        width: 14,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      BarChartRodData(
                        toY: avgCompletion[i].toDouble(),
                        color: const Color.fromARGB(255, 76, 175, 79),
                        width: 14,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                    barsSpace: 6,
                  );
                }),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: false)), // we draw manually
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
