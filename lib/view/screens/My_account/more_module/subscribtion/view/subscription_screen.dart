import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/images.dart';
import 'package:work_Force/Model/subscribtion_detail_model.dart';
import 'package:work_Force/controllers/subscribtion_controller.dart';
import 'package:work_Force/utils/Date.dart';

class SunscriptionDetailsScreen extends StatefulWidget {
  final bool? isSubscribtionEnded;
  const SunscriptionDetailsScreen({super.key, this.isSubscribtionEnded});

  @override
  State<SunscriptionDetailsScreen> createState() =>
      _SunscriptionDetailsScreenState();
}

class _SunscriptionDetailsScreenState extends State<SunscriptionDetailsScreen> {
  SubscriptionController controller = Get.put(SubscriptionController());
  SubscriptionDetailsModel? subscriptionDetailsValue;

  @override
  void initState() {
     controller.getSubscriptionHistoryList().then((_) {
    setState(() {
      subscriptionDetailsValue = controller.subscriptionDetails;
    });
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorwhite,
        title: const Text("Subscription Details"),
        titleTextStyle: TextStyle(
          color: kColorblack,
          fontWeight: FontWeight.bold,
          fontSize: width * 0.055,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: kColorblack,
            size: 22.sp,
          ),
        ),
        
      ),
      body: subscriptionDetailsValue == null
          ? Center(
              child: Text(
              "There is some issues in Here \nPlease contact Customer Support",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorRed,
                  fontSize: 14.sp),
              textAlign: TextAlign.center,
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Manage your Suktha Subscription",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        fontSize: width * 0.042),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  widget.isSubscribtionEnded == true
                      ? Center(
                          child: Lottie.asset(
                            subscriptionRenewalLottie,
                            height: MediaQuery.of(context).size.height * 0.27,
                            alignment: Alignment.centerLeft,
                            addRepaintBoundary: false,
                            // repeat: false,
                          ),
                        )
                      : Center(
                          child: Lottie.asset(
                            subscriptionDetails,
                            height: MediaQuery.of(context).size.height * 0.23,
                            alignment: Alignment.centerLeft,
                            repeat: false,
                            addRepaintBoundary: false,
                          ),
                        ),
                   SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: widget.isSubscribtionEnded == true
                            ? kColorRed
                            : Colors.amber,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                          widget.isSubscribtionEnded == true
                              ? "Subscription Ended"
                              : "In Progress",
                          style: widget.isSubscribtionEnded == true
                              ? TextStyle(
                                  color: kColorblack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.044)
                              : TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.042)),
                    ],
                  ),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  Text(
                    "Personal Plan",
                    style: TextStyle(
                        color: kColorblack,
                        fontWeight: FontWeight.w800,
                        fontSize: width * 0.06),
                  ),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: widget.isSubscribtionEnded == true
                          ? height * 0.15
                          : height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey[200]!)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    widget.isSubscribtionEnded == true
                                        ? Colors.transparent
                                        : Colors.white,
                                radius: widget.isSubscribtionEnded == true
                                    ? 15
                                    : 20,
                                child: widget.isSubscribtionEnded == true
                                    ? const Center(
                                        child: Icon(
                                          Icons.warning_rounded,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.warning_rounded,
                                          size: 28,
                                          color: Colors.indigo,
                                        ),
                                      )),
                            widget.isSubscribtionEnded == true
                                ? const SizedBox()
                                : Text(
                                    "Subscribtion Start Date :${DateClass().showDate(subscriptionDetailsValue!.startDate?.toString() ?? "")}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: kColorgreyShade500,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.038),
                                  ),
                            Text(
                              widget.isSubscribtionEnded == true
                                  ? "Your Subscription ended ${DateClass().showDate(subscriptionDetailsValue!.expiredate?.toString() ?? "")}"
                                  : "Your Subscription will end on ${DateClass().showDate(subscriptionDetailsValue!.expiredate?.toString() ?? "")} at 12:00 AM",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kColorblack,
                                  fontWeight: FontWeight.w800,
                                  fontSize: width * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 15),
                    child: Row(
                      children: [
                        Text(
                          "Subscription Id",
                          style: TextStyle(
                              color: kColorgreyShade500,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.038),
                        ),
                        const Spacer(),
                        Text(
                          subscriptionDetailsValue!.subscriptionId
                                  ?.toString() ??
                              "",
                          style: TextStyle(
                              color: kColorblack,
                              fontWeight: FontWeight.w800,
                              fontSize: width * 0.038),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Row(
                      children: [
                        Text(
                          "Payment Id",
                          style: TextStyle(
                              color: kColorgreyShade500,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.038),
                        ),
                        const Spacer(),
                        Text(
                          subscriptionDetailsValue!.paymentId?.toString() ?? "",
                          style: TextStyle(
                              color: kColorblack,
                              fontWeight: FontWeight.w800,
                              fontSize: width * 0.038),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Row(
                      children: [
                        Text(
                          "Paid Amount",
                          style: TextStyle(
                              color: kColorgreyShade500,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.038),
                        ),
                        const Spacer(),
                        Text(
                          subscriptionDetailsValue!.amountPaid?.toString() ??
                              "",
                          style: TextStyle(
                              color: kColorblack,
                              fontWeight: FontWeight.w800,
                              fontSize: width * 0.038),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Row(
                      children: [
                        Text(
                          "Subscription Status",
                          style: TextStyle(
                              color: kColorgreyShade500,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.038),
                        ),
                        const Spacer(),
                        Text(
                          subscriptionDetailsValue!.status?.toString() ?? "",
                          style: TextStyle(
                              color: kColorblack,
                              fontWeight: FontWeight.w800,
                              fontSize: width * 0.038),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        customAlertDialog(
                          context,
                          "This feature is not available in our Mobile application right now",
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 8, bottom: 10),
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              "See more",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, -5))
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                  decorationThickness: 1,
                                  fontWeight: FontWeight.w800,
                                  fontSize: width * 0.04),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      SubcriptionBottomSheetList(width);
                    },
                    child: Container(
                      height: height * 0.045,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[1],
                          borderRadius: BorderRadius.circular(10),
                          color: kColorlightBlue),
                      child: Center(
                        child: Text(
                          "See history",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kColorwhite,
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.045),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
    );
  }

  void customAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Alert",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          content: Text(
            message,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Back"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  SubcriptionBottomSheetList(double width) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    const Text(
                      " Subscripton History",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        controller.subHistoryList.clear();
                        await controller.getSubscriptionHistoryList();
                        // clearFunction();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[1],
                            borderRadius: BorderRadius.circular(16)),
                        child: CircleAvatar(
                          radius: 17,
                          child: Icon(
                            Icons.refresh,
                            size: 20,
                            color: kColorwhite,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        // clearFunction();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[1],
                            borderRadius: BorderRadius.circular(16)),
                        child: CircleAvatar(
                          radius: 17,
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: kColorwhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                controller.subHistoryList.isEmpty
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: FadeIn(
                                  delay: const Duration(milliseconds: 300),
                                  duration: const Duration(milliseconds: 300),
                                  child: LottieBuilder.asset(
                                      "assets/lottie/empty.json")),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            FadeIn(
                              delay: const Duration(milliseconds: 500),
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "History list is Empty",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            )
                          ],
                        ),
                      )
                    : Obx(
                        () => Expanded(
                          child: ListView.builder(
                            itemCount: controller.subHistoryList.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var item = controller.subHistoryList[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 1.0, right: 1, top: 18),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: kElevationToShadow[2],
                                      color: kColorwhite,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1.0, right: 1, top: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Paid Id",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.04),
                                              ),
                                              const Spacer(),
                                              Text(
                                                item.planId?.toString() ?? "--",
                                                style: TextStyle(
                                                    color: kColorblack,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: width * 0.04),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1.0, right: 1, top: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Start date",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.04),
                                              ),
                                              const Spacer(),
                                              Text(
                                                item.subscriptionStartDate
                                                        ?.toString() ??
                                                    "--",
                                                style: TextStyle(
                                                    color: kColorblack,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: width * 0.04),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1.0, right: 1, top: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                "End date",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.04),
                                              ),
                                              const Spacer(),
                                              Text(
                                                item.subscriptionEndDate
                                                        ?.toString() ??
                                                    "--",
                                                style: TextStyle(
                                                    color: kColorblack,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: width * 0.04),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1.0, right: 1, top: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Status",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.04),
                                              ),
                                              const Spacer(),
                                              Text(
                                                item.status?.toString() ?? "--",
                                                style: TextStyle(
                                                    color: kColorblack,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: width * 0.04),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
