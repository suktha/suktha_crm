import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';
import 'package:work_Force/view/widget/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "lottie": "assets/lottie/onboard_team.json",
      "title": "Welcome to Work Force",
      "subtitle":
          "Effortlessly manage your leads and teams in one place. Simplify daily operations with smart tools. Track every detail without the chaos. Get more done with less effort."
    },
    {
      "lottie": "assets/lottie/onboard_workflow.json",
      "title": "Organize Workflows",
      "subtitle":
          "Streamline your team's workflow with intuitive task management. Assign, update, and track tasks in real time. Stay focused and organized as your business scales. No task slips through the cracks."
    },
    {
      "lottie": "assets/lottie/onboard_graph.json",
      "title": "Smart Analytics",
      "subtitle":
          "Gain instant insights into your team's performance. Use data-driven dashboards to make better decisions. Spot trends, evaluate progress, and grow smarter. Track the real-time location of your field staff effortlessly.",
    },
  ];

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Get.to(const LoginPage(),
          duration: const Duration(milliseconds: 600),
          transition: Transition.rightToLeftWithFade);
    }
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 11 : 8,
      height: isActive ? 11 : 8,
      decoration: BoxDecoration(
        color: isActive ? kColorlightBlue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 3.h),
            currentPage == onboardingData.length - 1
                ? const SizedBox()
                : Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(3.w),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.w),
                                side: BorderSide(
                                  color: kColorlightBlue,
                                  width: 1,
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              controller.jumpToPage(onboardingData.length - 1);
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(color: kColorlightBlue),
                            )),
                      ),
                    ],
                  ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) => setState(() => currentPage = index),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset(
                            onboardingData[index]['lottie']!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        Text(
                          onboardingData[index]['title']!,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          onboardingData[index]['subtitle']!,
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length,
                  (index) => buildIndicator(currentPage == index)),
            ),
            SizedBox(height: 5.h),
            currentPage == onboardingData.length - 1
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    child: CustomButton(title: "Get Started", ontap: nextPage, width: double.infinity),
                   
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.h),
                    child: Row(
                      children: [
                     currentPage==1?   IconButton(
                            onPressed: () {
                              controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            },
                            icon:  Icon(Icons.arrow_back_ios,
                                color: Colors.grey,size: 16.sp,)):const SizedBox(),
                        const Spacer(),
                        SizedBox(
                          width: 30.w,
                          child: ElevatedButton(
                            onPressed: nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kColorlightBlue,
                              padding: EdgeInsets.symmetric(vertical: 3.w),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.w)),
                            ),
                            child: const Center(
                              child: Text(
                                "Next",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
             SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}


