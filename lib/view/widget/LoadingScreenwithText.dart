// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/utils/responsive_utils.dart';

class loadingScreenWithText extends StatefulWidget {
  bool? isPageLoading;
  loadingScreenWithText({super.key, this.isPageLoading});

  @override
  State<loadingScreenWithText> createState() => _loadingScreenWithTextState();
}

class _loadingScreenWithTextState extends State<loadingScreenWithText> {
  final List<String> billingFacts = [
    "The first recorded invoice dates back to 3300 BCE in Mesopotamia.",
    "Invoices were originally written on clay tablets.",
    "The word 'invoice' comes from the French word 'envoi', which means 'dispatch' or 'sending'.",
    "The earliest invoices were used for recording the sale of livestock.",
    "The world's oldest surviving invoice dates back to 1303 and is written in Latin.",
    "The concept of double-entry bookkeeping, which is the foundation of modern billing, was first documented in 1494.",
    "The first commercial accounting software was developed in the 1950s.",
    "Electronic invoicing (e-invoicing) has been around since the 1990s.",
    "The European Union has set standards for electronic invoicing to facilitate cross-border transactions.",
    "Invoices are legally binding documents that provide evidence of a transaction.",
    "Early invoices were often written by hand, which was a time-consuming process.",
    "Modern invoicing software automates the billing process, saving time and reducing errors.",
    "Invoices play a crucial role in cash flow management for businesses.",
    "In some countries, invoices must include specific information, such as tax identification numbers.",
    "Invoices help track revenue and expenses for tax reporting purposes.",
    "A well-designed invoice can enhance your brand's professional image.",
    "Some industries, like healthcare, have specific billing codes for services.",
    "Invoices can be sent via mail, email, or even through specialized invoicing platforms.",
    "Early invoices often included hand-drawn illustrations or engravings.",
    "Invoice factoring is a financial practice where a business sells its accounts receivable to a third party at a discount.",
    "Invoices serve as a legal record of a transaction, protecting both the buyer and seller.",
    "The world's largest invoice was for \$20 billion, sent by Apple to Samsung for patent infringement.",
    "Some countries have specific regulations regarding the retention of invoices for tax purposes.",
    "Electronic signatures are often used to verify the authenticity of digital invoices.",
    "Invoices can include late payment penalties for overdue payments.",
    "The use of blockchain technology is revolutionizing invoice verification and authenticity.",
    "The United States was the first country to introduce electronic invoicing standards in the 1980s.",
    "Invoices can be a valuable tool for tracking project costs and billing clients.",
    "Early invoices were often sealed with wax to ensure authenticity.",
    "Some businesses offer discounts for early payment of invoices to encourage prompt settlement.",
    "Recurring billing automates the process of invoicing for subscription-based services.",
    "Invoices can be customized with company logos and branding elements.",
    "Invoices provide a detailed breakdown of products or services provided, quantity, and price.",
    "Automated reminders can be set up to notify clients of upcoming or overdue payments.",
    "Invoices can be classified into various types, including pro forma, commercial, and tax invoices.",
    "Some industries, like construction, use progress billing to invoice for work completed at various stages of a project.",
    "Online payment gateways make it easy for clients to pay invoices electronically.",
    "Invoices are a key financial record used in auditing and financial analysis.",
    "Invoice financing allows businesses to borrow against the value of their outstanding invoices.",
    "Some countries have specific requirements for multi-language invoices in international transactions."
  ];

  String getRandomFact() {
    final random = Random();
    final randomFactIndex = random.nextInt(billingFacts.length);
    return billingFacts[randomFactIndex];
  }

  String currentFact = '';
  //this is using for not change the text while the loading animation is working

  void updateRandomFact() {
    setState(() {
      currentFact = getRandomFact();
    });
  }

  late Timer _timer;
  late Timer _timerforWidget;
  int dotsCount = 0;

  bool isTakingLong = false;

  void startLoadingAnimation() {
    Future.delayed(Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          dotsCount = (dotsCount + 1) % 5;
        });
        startLoadingAnimation();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    print(widget.isPageLoading);
    startLoadingAnimation();
    updateRandomFact();

    _timer = Timer(Duration(seconds: 15), () {
      setState(() {
        widget.isPageLoading = false;
      });
    });
    _timerforWidget = Timer(Duration(seconds: 7), () {
      setState(() {
        isTakingLong = true;
      });
    });
  }

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    _timer.cancel();
    _timerforWidget.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);
    double textScaleFactor = ResponsiveUtils.textScaleFactor(context);

    return Visibility(
      visible: widget.isPageLoading!,
      child: Positioned.fill(
        child: Container(
          color: kColorblack.withOpacity(0.5),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),

                  FadeIn(
                    delay: Duration(milliseconds: 400),
                    child: Container(
                      // height: 35.h,
                      decoration: BoxDecoration(
                        color: kColorwhite,
                        boxShadow: kElevationToShadow[2],
                        // Background color for the rounded container
                        borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                      ),
                      padding: EdgeInsets.all(5.w), // Adjust padding as needed
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4.w), // Adjust margin as needed
                      child: Column(
                        children: [
                          SizedBox(
                            width: width * 0.6,
                            child: Text(
                              "Please Wait its Loading" + ("." * dotsCount),
                              style: TextStyle(fontSize: textScaleFactor * 20, fontFamily: FontStyle.normal.name, color: kColorblack, decoration: TextDecoration.none),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          // LoadingAnimationWidget.threeRotatingDots(
                          //   color: Colors.lightBlue,
                          //   size: 10.w,
                          // ),
                          Lottie.asset(
                            didYouKnowLottie,
                            height: 15.h,
                            // width: 80.w,
                            alignment: Alignment.centerLeft,
                            addRepaintBoundary: false,
                          ),
                          // SizedBox(height: height*0.04,),
                          // Text(
                          //   "Did You Know...?",
                          //   style: TextStyle(fontSize: textScaleFactor * 20,  fontFamily: FontStyle.normal.name, color: kColorblack, decoration: TextDecoration.none),
                          // ),
                          //  SizedBox(height: height*0.01,),
                          Text(
                            currentFact,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontFamily: FontStyle.normal.name, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Text("data")
                  Spacer(),
                  isTakingLong
                      ? GestureDetector(
                          onTap: () {
                            widget.isPageLoading = false;
                          },
                          child: CircleAvatar(backgroundColor: kColorwhite, child: Icon(Icons.close)))
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
