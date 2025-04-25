import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/view/screens/home_screen/Home_Screen.dart';
import 'package:suktha_crm/view/screens/pre_sales/pre_sale_screen.dart';
import 'package:suktha_crm/view/screens/settings/settings_screen.dart';

class BottomNavigationMainscreen extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationMainscreen({super.key, required this.initialIndex});

  @override
  State<BottomNavigationMainscreen> createState() => _BottomNavigationMainscreenState();
}

class _BottomNavigationMainscreenState extends State<BottomNavigationMainscreen> {
  late int currentIndex;
  final List<Widget> _screens = [
    PreSaleScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex; // 👈 Set starting index from widget
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: 'Lead',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        backgroundColor: kColorwhite,
        elevation: 0,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
        unselectedItemColor: const Color.fromARGB(255, 99, 99, 99),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kColorblack,
        iconSize: 18.sp,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        unselectedIconTheme: IconThemeData(size: 19.sp),
        selectedIconTheme: IconThemeData(size: 21.sp),
      ),
    );
  }
}
