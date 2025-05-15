import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmer(height: 2.h, width: 40.w),
            shimmer(height: 20.h, width: 100.w),
            shimmer(height: 2.h, width: 40.w),
            shimmer(height: 20.h, width: 100.w),
            shimmer(height: 2.h, width: 40.w),
            shimmer(height: 20.h, width: 100.w),
          ],
        ),
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
            shimmer(height: 10.h, width: 100.w),
          ],
        ),
      ),
    );
  }
}

class shimmer extends StatelessWidget {
  final double height, width;
  const shimmer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: kColorgreyShade400,
      baseColor: kColorgreyShade300,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: kColorwhite,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
