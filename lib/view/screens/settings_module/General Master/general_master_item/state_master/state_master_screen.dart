import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_controller.dart';
import 'package:work_Force/view/screens/settings_module/General%20Master/general_master_screen.dart';

class StateMasterScreen extends StatefulWidget {
  const StateMasterScreen({super.key});

  @override
  State<StateMasterScreen> createState() => _StateMasterScreenState();
}

class _StateMasterScreenState extends State<StateMasterScreen> {
  final GeneralMasterController controller = Get.put(GeneralMasterController());

  @override
  void initState() {
    super.initState();
    controller.getStateDetails("");
    controller.getCountryDetails("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(14.h),
        child: AppBar(
            title: Text("State Master",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.searchController.clear();
                    controller.search("");
                    controller.searchResultsState.clear();
                    await controller.getStateDetails("");
                    // await controller.getCountryDetails("");
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: kColorblack,
                  ))
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      height: 6.h,
                      // width: 75.w,
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[4],
                        color: kColorwhite,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) => controller.search(value),
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Search Here',
                                hintStyle: TextStyle(color: kColorgrey),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            titleTextStyle: TextStyle(
                color: kColorblack,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
            centerTitle: false,
            backgroundColor: kColorwhite,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: kColorblack,
                size: 25.sp,
              ),
              onPressed: (() {
                controller.searchController.clear();
                controller.search("");
                Get.to(() => const GeneralMasterScreen(),
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 600));
                // Get.back();
              }),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => controller.searchResultsState.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 300),
                          child:
                              LottieBuilder.asset("assets/lottie/empty.json")),
                      SizedBox(
                        height: 3.h,
                      ),
                      FadeIn(
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          "Your State Master is Empty ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: controller.searchResultsState.length,
                  itemBuilder: (context, index) {
                    var item = controller.searchResultsState[index];

                    String? countryName;

                    if (controller.country_master_items.isNotEmpty) {
                      var countryValue = controller.country_master_items
                          .firstWhere(
                              (element) => element.id == item.countryId);

                      countryName = countryValue.name;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[50],
                          boxShadow: kElevationToShadow[1],
                        ),
                        // height: 40,
                        child: ListTile(
                          title: Text(
                            "State : ${item.name}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            "Country : ${countryName ?? ""}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
