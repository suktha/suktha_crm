import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateClass {
  var dateTimeNow = DateTime.now().obs;

  parseDate(String date) {
    if (date != "") {
      if (date.contains("T")) {
        DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('yyyy-MM-dd');
        var outputDate = outputFormat.format(inputDate);
        return outputDate;
      } else {
        try {
          DateTime parseDate = DateFormat("dd/MM/yyyy").parse(date);
          // Check if the parsed date matches the expected format
          if (DateFormat('dd/MM/yyyy').format(parseDate) == date) {
            var outputFormat = DateFormat('yyyy-MM-dd');
            var outputDate = outputFormat.format(parseDate);
            return outputDate;
          } else {
            return date; // Or you can return a default value or throw an exception
          }
        } catch (e) {
          // Handle the case where the date is not in the expected format
          return date; // Or you can return a default value or throw an exception
        }
      }
    }
  }

  showDate(String? date) {
    // print(date);
    if (date != null && date.isNotEmpty && date != "") {
      try {
        DateTime parsedDate;

        if (date.contains("T")) {
          parsedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
        } else if (date.contains("Z")) {
          parsedDate = DateFormat("YYYY-MM-DDTHH:MM:SS.sssZ").parse(date);
        } else if (date.contains(" ")) {
          parsedDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
        } else {
          parsedDate = DateFormat("yyyy-MM-dd").parse(date);
        }

        var outputFormat = DateFormat('dd/MM/yyyy');
        final outputDate = outputFormat.format(parsedDate);
        // print("selected controller side date --${outputDate}");

        return outputDate;
      } catch (e) {
        print("Error parsing date: $date");
        return date;
      }
    }

    return null;
  }

  selectDate(TextEditingController controller, bool enquiryDate, bool poEndDate,
      {String? currentdateTimeNow,
      TextEditingController? startDateController, // Pass start date controller for comparison
      TextEditingController? nextYearController,
      bool? autoFillYear,
      bool isEndDate = false}) async {
    DateTime currentDate;
    DateTime? startDate;

    print(" autoFillYear--${autoFillYear}");

    log("Controller date - ${controller.text}");

    // Determine the correct format and parse accordingly
    if (controller.text.isNotEmpty) {
      try {
        currentDate = controller.text.contains("-") ? DateFormat("yyyy-MM-dd").parse(controller.text) : DateFormat("dd/MM/yyyy").parse(controller.text);
      } catch (e) {
        log("Error parsing date: $e");
        currentDate = DateTime.now();
      }
    } else {
      // If currentdateTimeNow is provided, use it
      if (currentdateTimeNow != null && currentdateTimeNow.isNotEmpty) {
        try {
          currentDate = DateFormat("dd/MM/yyyy").parse(currentdateTimeNow);
        } catch (e) {
          log("Error parsing currentdateTimeNow: $e");
          currentDate = DateTime.now();
        }
      } else {
        currentDate = DateTime.now();
      }
    }

    // Parse the start date if provided (for end date validation)
    if (startDateController != null && startDateController.text.isNotEmpty) {
      try {
        startDate = startDateController.text.contains("-") ? DateFormat("yyyy-MM-dd").parse(startDateController.text) : DateFormat("dd/MM/yyyy").parse(startDateController.text);
      } catch (e) {
        log("Error parsing start date: $e");
        startDate = null;
      }
    }

    final BuildContext? context = Get.context;
    if (context == null) {
      log("Error: No context available for date picker");
      return;
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: poEndDate ? DateTime.now() : DateTime(2000),
      lastDate: enquiryDate ? DateTime.now() : DateTime(2101),
    );

    if (pickedDate != null) {
      // Validate if this is an end date and is before the start date
      if (isEndDate && startDate != null && pickedDate.isBefore(startDate)) {
        Get.snackbar(
          "Invalid Date",
          "End date cannot be before the start date",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      log("Selected date: ${controller.text}");
    }

    if (autoFillYear == true) {
      int nextYear = pickedDate!.year + 1;
      int previousMonth = pickedDate.month - 1;

      if (previousMonth == 0) {
        previousMonth = 12;
        nextYear -= 1;
      }
      DateTime lastDayOfMonth = DateTime(nextYear, previousMonth + 1, 0);
      nextYearController!.text = DateFormat('dd/MM/yyyy').format(lastDayOfMonth);
      log("Next year date auto-filled: ${nextYearController.text}");
    }
  }

  selectTime(TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      controller.text = pickedTime.format(Get.context!);
    }
  }

  //  selectTime(BuildContext context, TextEditingController timeController) async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (pickedTime != null) {
  //     String formattedTime =
  //         pickedTime.hour > 12 ? "${pickedTime.hour - 12}:${pickedTime.minute.toString().padLeft(2, '0')} PM" : "${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')} AM";
  //     timeController.text = formattedTime;

  //     print("selected time -- ${timeController}");
  //   }
  // }

  String formatDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return ""; // Return empty if no date is provided
    }

    try {
      DateTime parsedDate;

      if (dateString.contains("-")) {
        // If the format is yyyy-MM-dd, parse accordingly
        parsedDate = DateFormat("yyyy-MM-dd").parse(dateString);
      } else {
        // If it's already in dd/MM/yyyy format, parse as such
        parsedDate = DateFormat("dd/MM/yyyy").parse(dateString);
      }

      // Return the formatted string in dd/MM/yyyy format
      return DateFormat("dd/MM/yyyy").format(parsedDate);
    } catch (e) {
      print("Error parsing date: $e");
      return ""; // Return empty if parsing fails
    }
  }
}
