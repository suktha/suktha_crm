// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Material%20Master/View%20Material%20Master/list_material_master.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/list_party_master.dart';
import 'package:work_Force/view/screens/more_module/Masters/Masters%20Items/Service%20Master/View%20Service%20Master/list_service_master.dart';

class MasterController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();

  RxList<dynamic> selectedMasterItems = <dynamic>[].obs;

  Set<String?> masterNames = {};

  FetchItems() {
    masterNames.clear();
    for (var menuItem in globalController.menuList) {
      print("==${menuItem.name}");
      if (menuItem.name == "Masters") {
        if (menuItem.activities != null) {
          for (var activity in menuItem.activities!) {
            print(activity.name);
            masterNames.add(activity.name);
          }
        }
      }
    }

    selectedMasterItems.value = masterItems.where((item) => masterNames.contains(item['title'])).toList();
  }

  final masterItems = [
    {
      "title": "Party",
      "icon": Icons.pages_rounded,
      "screen": PartyMasterScreen(),
    },
    {
      "title": "Material",
      "icon": Icons.my_library_add_outlined,
      "screen": const MaterialMasterScreen(),
    },
    {
      "title": "Service",
      "icon": Icons.supervised_user_circle_sharp,
      "screen": ServiceMasterScreen(),
    },
   
  ];
}
