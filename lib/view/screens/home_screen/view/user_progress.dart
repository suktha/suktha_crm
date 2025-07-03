import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserProgressScreen extends StatelessWidget {
  final Map<String, dynamic> userProgress;

  UserProgressScreen({required this.userProgress});

  @override
  Widget build(BuildContext context) {
    final int totalTasks = userProgress["completed"] + userProgress["pending"];
    final double progressPercent =
        totalTasks == 0 ? 0.0 : userProgress["completed"] / totalTasks;

    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProgress["name"],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Role: ${userProgress["role"]}",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const Divider(height: 30),
                const Text("📊 Task Completion Progress",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: progressPercent,
                  minHeight: 10,
                  backgroundColor: Colors.grey[300],
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStat(
                        "Completed",
                        userProgress["completed"].toString(),
                        Icons.check_circle,
                        Colors.green),
                    _buildStat("Pending", userProgress["pending"].toString(),
                        Icons.pending, Colors.orange),
                    _buildStat("Today", userProgress["today"].toString(),
                        Icons.today, Colors.blue),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Text("⭐ ${userProgress["rating"]}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("Your Rating",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 30, color: color),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}
