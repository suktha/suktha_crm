import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/controller.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/widget/list_tile_custom_widget.dart';

class GeneralMasterScreen extends StatefulWidget {
  const GeneralMasterScreen({super.key});

  @override
  State<GeneralMasterScreen> createState() => _GeneralMasterScreenState();
}

class _GeneralMasterScreenState extends State<GeneralMasterScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());
  final mastercontroller = Get.put(GeneralMasterListController());

  final NavigationController navController = Get.find<NavigationController>();

  @override
  void initState() {
    super.initState();
    mastercontroller.FetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 243, 243, 243),
          title: const Text('General Master'),
          titleTextStyle: TextStyle(
              color: kColorblack, fontWeight: FontWeight.bold, fontSize: 18.5.sp),
          centerTitle: false,
          // backgroundColor: kColorwhite,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: kColorblack,
              size: 25.sp,
            ),
            onPressed: (() {
              Get.to(() => const BottomNavigationMainscreen(initialIndex: 2),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 400));
              // Get.back();
            }),
          )),
      body: Container(
          margin: EdgeInsets.all(3.w),
          padding: EdgeInsets.all(2.w),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
            color: kColorwhite,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: mastercontroller.selectedGeneralMasterItems.length,
            itemBuilder: (context, index) {
              final item = mastercontroller.selectedGeneralMasterItems[index];

              return FadeInUp(
                delay: Duration(milliseconds: 200 + (index * 100)),
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    ListTileCustomWidget(
                        onTap: () {
                          Get.to(item['screen'] as Widget,
                              transition: Transition.fade,
                              duration: const Duration(milliseconds: 600));
                        },
                        title: item['title'],
                        icons: Icons.receipt_long),
                  ],
                ),
              );
            },
          )),
    );
  }
}
