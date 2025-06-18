import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'Masters Items/Service Master/View Service Master/list_service_master.dart';

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
      "screen": ServiceMasterScreen(),
    },
    {
      "title": "Material",
      "icon": Icons.my_library_add_outlined,
      "screen": ServiceMasterScreen(),
    },
    {
      "title": "Service",
      "icon": Icons.supervised_user_circle_sharp,
      "screen": ServiceMasterScreen(),
    },
   
  ];
}
