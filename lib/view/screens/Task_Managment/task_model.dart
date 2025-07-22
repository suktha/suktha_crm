import 'package:flutter/material.dart';

class TaskModel {
  String title;
  String subtitle;
  String time;
  bool completed;
  bool isStarred;
  String assignedName;
  String tags;
  Color tagColor;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.completed,
    required this.isStarred,
    required this.assignedName,
    required this.tags,
    required this.tagColor,
  });
}
