// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/login_model.dart' as loginModel;
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/view/screens/Task_Managment/new_task.dart';
import 'package:work_Force/view/screens/home_screen/Home_Screen.dart';
import 'package:work_Force/view/screens/My_account/my_account_screen.dart';
import 'package:work_Force/view/screens/more_module/more_screen.dart';
import 'package:work_Force/view/screens/pre_sales/pre_sale_screen.dart';

class BottomNavigationMainscreen extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationMainscreen({
    super.key,
    required this.initialIndex,
  });

  @override
  State<BottomNavigationMainscreen> createState() =>
      _BottomNavigationMainscreenState();
}

class _BottomNavigationMainscreenState
    extends State<BottomNavigationMainscreen> {

  late int currentIndex;
  late List<Widget> _screens;
  late List<BottomNavigationBarItem> _navItems;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    // Setup screens based on isAdmin


    _screens = [
      const PreSaleScreen(),
      const HomeScreen(),
      NewTaskScreen(),
      MyAccountScreen(),
      // const MoreScreen(),
    ];

    _navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.leaderboard_rounded),
        label: 'Lead',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.task_alt_rounded),
        label: 'Task',
      ),

      const BottomNavigationBarItem(
        icon: Icon(Icons.account_box_rounded),
        label: 'My Account',
      ),
      // const BottomNavigationBarItem(
      //   icon: Icon(Icons.more_outlined),
      //   label: 'More',
      // ),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        items: _navItems,
        backgroundColor: kColorwhite,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kColorblack,
        unselectedItemColor: const Color.fromARGB(255, 99, 99, 99),
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        unselectedIconTheme: IconThemeData(size: 19.sp),
        selectedIconTheme: IconThemeData(size: 21.sp),
        iconSize: 18.sp,
      ),
    );
  }
}
