
// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;
  final String tags;
  Color tagColor;
  final String assignedName;

  bool completed;
  bool isStarred;

  TaskCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.time,
      required this.completed,
      required this.isStarred,
      required this.assignedName,
      required this.tags,
      required this.tagColor});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.completed == false) {
                        widget.completed = true;
                      } else if (widget.completed == true) {
                        widget.completed = false;
                      }
                      print("completedd---${widget.completed}");
                    });
                  },
                  child: Icon(
                    Icons.check_circle,
                    color:
                        widget.completed ? Colors.blue : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: widget.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 1.5),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.isStarred == false) {
                        widget.isStarred = true;
                      } else if (widget.isStarred == true) {
                        widget.isStarred = false;
                      }
                      print("isStarredd---${widget.isStarred}");
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color:
                        widget.isStarred ? Colors.amber : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const Spacer(),
                Text(
                  widget.assignedName,
                  style: const TextStyle(color: Colors.green, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            Row(
              children: [
                Text(
                  widget.time,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.tags,
                  style: TextStyle(
                      color: widget.tagColor, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                // SizedBox(
                //   width: 5.w,
                // ),

                const Icon(
                  Icons.loop,
                  color: Colors.indigo,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.orange ,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}