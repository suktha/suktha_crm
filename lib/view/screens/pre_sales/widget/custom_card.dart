
  import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildKPICard({
    required double height,
    required String title,
    required List<Color> gradient,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              icon,
              size: 100,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 20.sp),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.95),
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }