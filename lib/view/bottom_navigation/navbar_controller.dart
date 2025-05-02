import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suktha_crm/controllers/global_controller.dart';
import 'package:suktha_crm/view/bottom_navigation/bottom_navigation_mainScreen.dart';
import 'package:suktha_crm/view/screens/home_screen/Home_Screen.dart';
import 'package:suktha_crm/view/screens/pre_sales/pre_sale_screen.dart';
import 'package:suktha_crm/view/settings_module/settings_screen.dart';

class NavigationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    log("Navigation Controller Initialized");
  }

  RxInt selectedIndex = 0.obs;
  final globalController = Get.find<GlobalController>();

  RxList<String> navBarAllItemList = <String>[
    'Home',
    'Lead',
    'Settings',
  ].obs;

  RxList<String> selectedItems = <String>[].obs;

  void AccessingGlobalMethod() {
    Set<String?> menuItemNames = globalController.menuList.map((item) => item.name).toSet();
    selectedItems.value = navBarAllItemList.where((item) => menuItemNames.contains(item)).toList();
    print("Selected items: $selectedItems");
  }

  Widget widgetScreens(String item, int index) {
    switch (item) {
      case 'Home':
        return HomeScreen();
      case 'Lead':
        return PreSaleScreen();
      case 'Settings':
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }

  IconData getIconForItem(String item) {
    switch (item) {
      case 'Home':
        return Icons.home_rounded;
      case 'Lead':
        return Icons.leaderboard_rounded;
      case 'Settings':
        return Icons.settings;
      default:
        return Icons.help;
    }
  }
}
