// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/area_master/area_master_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/bank_master/bank_master_list_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/city_master/city_master_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/country_master/country_master.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/department/department_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/designation/designation_list.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/expense_head/expense_head_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/foreign_state/foreign_state_screen.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/industry_segment/industry_segment.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/party/lead_category/party_lead_category.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/reason/reason_master.dart';
import 'package:work_Force/view/screens/My_account/view/module/Masters/Masters%20Items/General%20Master/general_master_item/state_master/state_master_screen.dart';
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

    selectedGeneralMasterItems.value = generalMasterItems
        .where((item) => ItemsNames.contains(item['title']))
        .toList();

    print(selectedGeneralMasterItems);
  }

  final generalMasterItems = [
    {
      "title": "Country Master",
      "icon": Icons.list_alt,
      "screen": const CountryMasterScreen(),
    },
    {
      "title": "State Master",
      "icon": Icons.list_alt,
      "screen": const StateMasterScreen(),
    },
    {
      "title": "Foreign State Master",
      "icon": Icons.list_alt,
      "screen": const ForeignStateMasterScreen(),
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
      "title": "Department",
      "icon": Icons.list_alt,
      "screen": const DepartmentScreen(),
    },
    {
      "title": "Designation",
      "icon": Icons.list_alt,
      "screen": DesignationScreen(),
    },
    {
      "title": "Party/Lead Category",
      "icon": Icons.list_alt,
      "screen": LeadCategoryMasterScreen(),
    },
    {
      "title": "Industry Segment",
      "icon": Icons.list_alt,
      "screen": const IndustrySegmentMasterScreen(),
    },
    {
      "title": "Expense Head",
      "icon": Icons.list_alt,
      "screen": ExpenseHeadScreen(),
    },
    {
      "title": "Reason",
      "icon": Icons.list_alt,
      "screen": const ReasonMasterScreen(),
    },
  ];
}
