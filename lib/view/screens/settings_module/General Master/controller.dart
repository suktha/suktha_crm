// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_item/area_master/area_master_screen.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_item/bank_master/bank_master_list_screen.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_item/city_master/city_master_screen.dart';


class GeneralMasterListController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();

  RxList<dynamic> selectedGeneralMasterItems = <dynamic>[].obs;

  Set<String?> ItemsNames = {};

  FetchItems() {
    for (var menuItem in globalController.menuList) {
      if (menuItem.name == "General Master") {
        if (menuItem.activities != null) {
          for (var activity in menuItem.activities!) {
            print("item -- ${activity.name}");
            ItemsNames.add(activity.name);
          }
        }
      }
    }

    selectedGeneralMasterItems.value = generalMasterItems.where((item) => ItemsNames.contains(item['title'])).toList();

    print(selectedGeneralMasterItems);
  }

  final generalMasterItems = [
    {
      "title": "Country Master",
      "icon": Icons.list_alt,
      "screen": AreaMasterScreen(),
    },
    {
      "title": "State Master",
      "icon": Icons.list_alt,
      "screen": AreaMasterScreen(),
    },
    {
      "title": "Foreign State Master",
      "icon": Icons.list_alt,
      "screen": AreaMasterScreen(),
    },
    {
      "title": "City Master",
      "icon": Icons.list_alt,
      "screen": CityMasterScreen(),
    },
    {
      "title": "Area Master",
      "icon": Icons.list_alt,
      "screen": AreaMasterScreen(),
    },
    {
      "title": "Bank Master",
      "icon": Icons.list_alt,
      "screen": BankMasterScreen(),
    },
    {
      "title": "Expense Head",
      "icon": Icons.list_alt,
      "screen": AreaMasterScreen(),
    },
    {
      "title": "Department",
      "icon": Icons.list_alt,
      "screen": BankMasterScreen(),
    },
    {
      "title": "Designation",
      "icon": Icons.list_alt,
      "screen": BankMasterScreen(),
    },
    {
      "title": "Party/Lead Category",
      "icon": Icons.list_alt,
      "screen": BankMasterScreen(),
    },
    {
      "title": "Industry Segment",
      "icon": Icons.list_alt,
      "screen": BankMasterScreen(),
    },
    {
      "title": "Reason",
      "icon": Icons.list_alt,
      "screen": BankMasterScreen(),
    },
  ];
}
