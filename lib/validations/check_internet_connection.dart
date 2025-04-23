import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/view/widget/custom_button.dart';

class ConnectivityService {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityService() {
    _subscription = Connectivity().onConnectivityChanged.listen(_onConnectivityChange);
  }

  void _onConnectivityChange(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.mobile) || results.contains(ConnectivityResult.wifi)) {
      print("Connected");
    } else {
      Get.to(NoInternetConnectionScreen());
    }
  }

  void dispose() {
    _subscription.cancel();
  }

  Future<bool> checkInternetConnectivity(final bool isSplash) async {
    bool isInternet = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      print("there is no internet connection ");
      isInternet = true;
    } else {
      isInternet = false;
      Get.to(NoInternetConnectionScreen());
    }
    return isInternet;
  }
}

class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  State<NoInternetConnectionScreen> createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _animation;

  // @override
  // void initState() {
  //   super.initState();

  //   _controller = AnimationController(
  //     duration: Duration(milliseconds: 100),
  //     vsync: this,
  //   );

  //   _animation = Tween(begin: -10.0, end: 10.0).animate(
  //     CurvedAnimation(
  //       parent: _controller,
  //       curve: Curves.elasticOut,
  //     ),
  //   )..addStatusListener((status) {
  //       if (status == AnimationStatus.completed) {
  //         _controller.reverse();
  //       }
  //     });
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // void _handleButtonPress() {
  //   _controller.forward();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // customSnackbar("Please Check the Connection\nAnd press Try Again", "", "error");
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Images/NoInternetBakcground.jpeg"), fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Spacer(),
                // Add a Flare animation for no internet
                Container(
                  // height: 200,
                  // width: 200,
                  child: Lottie.asset(
                    noInternetConnectionLottie,
                    height: 40.h,
                    alignment: Alignment.centerLeft,
                    addRepaintBoundary: false,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "No Internet connection",
                  style: TextStyle(fontSize: 18.sp, color: kColorblack45, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  width: 70.w,
                  child: Text(
                    "Please check your Internet connection and try again",
                    style: TextStyle(fontSize: 12.sp, color: kColorblack45, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                // AnimatedBuilder(
                //   animation: _animation,
                //   builder: (context, child) {
                //     return Transform.translate(
                //       offset: Offset(_animation.value, 0),
                //       child: Container(
                //         width: 100,
                //         height: 100,
                //         color: Colors.blue,
                //         child: Center(
                //           child: Text(
                //             'Shake me!',
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: _handleButtonPress,
                //   child: Text('Shake Container'),
                // ),
                CustomButton(
                  width: 50.w,
                  title: "Try Again",
                  ontap: () async {
                    var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
                      Get.back();
                    } else if (connectivityResult.contains(ConnectivityResult.none)) {
                      print(connectivityResult);
                      Get.snackbar(
                        "No Internet Connection",
                        "You are offline. Please check your connection.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      print("connectivityResult: $connectivityResult");
                    }
                  },
                  color: kColorblack45.withOpacity(.2),
                  textcolor: Colors.white70,
                )
                // ElevatedButton(
                //   onPressed: () async {

                //   },
                //   child: Text("Retry"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
