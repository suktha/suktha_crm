import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TeamProgressCard extends StatelessWidget {
  final List<Map<String, dynamic>> teamData;
  final VoidCallback? onViewAll;

  const TeamProgressCard({
    super.key,
    required this.teamData,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("  Only admin can see this."),
        SizedBox(height: 1.2.w),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 1.2.w),
              ...teamData.map((member) {
                final percent = (member["completed"] / member["total"]) * 100;

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.lightBlue[100],
                        child: Text(
                          member["name"][0],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member["name"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Completed: ${member["completed"]} / ${member["total"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              "Progress: ${percent.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "⭐ ${member["rating"]}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Rating",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.only(right: 4.w, bottom: 5),
                child: GestureDetector(
                  onTap: onViewAll,
                  child: const Text(
                    "View all",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
