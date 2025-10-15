// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/controllers/chatbot_controller.dart';
import 'package:work_Force/view/bottom_navigation/chatBot_overlay.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';
import 'package:work_Force/view/screens/Task_Managment/new_task.dart';
import 'package:work_Force/view/screens/home_screen/Home_Screen.dart';
import 'package:work_Force/view/screens/My_account/my_account_screen.dart';
import 'package:work_Force/view/screens/pre_sales/pre_sale_screen.dart';

class BottomNavigationMainscreen extends StatefulWidget {
  int? initialIndex;
  BottomNavigationMainscreen({super.key, this.initialIndex});

  @override
  State<BottomNavigationMainscreen> createState() =>
      _BottomNavigationMainscreenState();
}

class _BottomNavigationMainscreenState
    extends State<BottomNavigationMainscreen> {
  final _screens = [
    const PreSaleScreen(),
    const HomeScreen(),
    NewTaskScreen(),
    const MyAccountScreen(),
  ];

  final _navItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.leaderboard_rounded), label: 'Lead'),
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.task_alt_rounded), label: 'Task'),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_box_rounded), label: 'My Account'),
  ];

  final nav = Get.find<NavigationController>();
  final chatBotController = Get.find<ChatBotController>();
  final chatBotOverlay = ChatBotOverlay();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nav.index.value = widget.initialIndex ?? 0;
      // chatBotOverlay.show(context);
    });
  }

  @override
  void dispose() {
    chatBotOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _screens[nav.index.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: nav.index.value,
            onTap: nav.changeTab,
            items: _navItems,
            backgroundColor: Colors.white,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            unselectedIconTheme: IconThemeData(size: 19.sp),
            selectedIconTheme: IconThemeData(size: 21.sp),
            iconSize: 18.sp,
          ),
        ));
  }
}
