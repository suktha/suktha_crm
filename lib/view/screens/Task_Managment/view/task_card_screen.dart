// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;
  final String tags;
  Color tagColor;
  final String assignedName;

  bool completed;
  bool isStarred;
  bool? isSelected;
  bool? isFromClockIn;

  VoidCallback? onSelect;

  TaskCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.time,
      required this.completed,
      required this.isStarred,
      required this.assignedName,
      required this.tags,
      required this.tagColor,
      this.onSelect,
      this.isFromClockIn,
      this.isSelected});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  void initState() {
    if (widget.isFromClockIn == false) {
      widget.isSelected = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: Card(
          color: widget.isSelected == true
              ? const Color.fromARGB(255, 245, 251, 255)
              : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: widget.isSelected == true
                    ? Colors.blue
                    : Colors.transparent,
                width: .5,
              )),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                          print("Completed---${widget.completed}");
                        });
                      },
                      child: Icon(
                        Icons.check_circle,
                        color: widget.completed
                            ? Colors.blue
                            : Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
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
                        color: widget.isStarred
                            ? Colors.amber
                            : Colors.grey.shade400,
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
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 13),
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
                      color: Colors.orange,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
