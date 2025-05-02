import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Model/user_model.dart';
import 'package:suktha_crm/view/settings_module/tracking/admin/controller/filed_work_controller.dart';
import 'package:suktha_crm/view/widget/deleteAlertDialogue.dart';

Widget userListView({
  required List<UserModel> userList,
  required double width,
  required FieldWorkController controller,
  required double height,
  required Function(UserModel item, int index) onTapUser,
  required Function(int index) onDelete,
}) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount: userList.length,
    itemBuilder: (context, index) {
      final item = userList[index];
      return SwipeActionCell(
        key: UniqueKey(),
        trailingActions: <SwipeAction>[
          SwipeAction(
            performsFirstActionWithFullSwipe: false,
            backgroundRadius: width * 0.05,
            widthSpace: width * 0.2,
            title: "Delete",
            style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
            onTap: (handler) async {
              customDeleteAlertDialogue(context, () => onDelete(index));
            },
            color: Colors.red,
          ),
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
          child: GestureDetector(
            onTap: () => onTapUser(item, index),
            child: Container(
              child: ListTile(
                title: Text(
                  item.name ?? '',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * 0.047),
                ),
                subtitle: Text(
                  controller.getUserRoleNames(item.roleIds!),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: width * 0.035),
                ),
                leading: CircleAvatar(
                  radius: width * 0.06,
                  backgroundColor: getRandomLightColor(index),
                  child: Icon(Icons.person_pin, size: width * 0.07, color: kColorLightGrey),
                ),
                // trailing: Text(item.),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Color getRandomLightColor(int index) {
  // Generate a unique hue based on the index
  double hue = (index * 137.5) % 360; // 137.5 degrees apart ensures good separation
  return HSVColor.fromAHSV(1, hue, 0.3, 0.5).toColor();
}

Widget buildDateButton(
  String title,
  DateTime? date,
  FieldWorkController controller,
  int userId,
) {
  return GestureDetector(
    onTap: () async {
      if (title == "Custom") {
        DateTime? picked = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.selectedTitle.value = title;
          controller.selectedDate.value = picked;
        }
      } else {
        controller.selectedTitle.value = title;
        controller.selectedDate.value = date ?? DateTime.now();
      }

      controller.GetLeadEventByUser(
        userId: userId,
        eventDate: controller.selectedDate.value.toString(),
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: controller.selectedTitle.value == title ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          if (controller.selectedTitle.value == title)
            BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: controller.selectedTitle.value == title ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

class DateHistoryWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  DateHistoryWidget({required this.onDateSelected});

  @override
  _DateHistoryWidgetState createState() => _DateHistoryWidgetState();
}

class _DateHistoryWidgetState extends State<DateHistoryWidget> {
  List<DateTime> dateList = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateDateList();
    // Send today's date initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateSelected(dateList[selectedIndex]);
    });
  }

  void _generateDateList() {
    DateTime today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      dateList.add(today.subtract(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateList.length,
        itemBuilder: (context, index) {
          DateTime date = dateList[index];
          bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              width: 60,
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM').format(date).toUpperCase(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('E').format(date).toUpperCase(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
