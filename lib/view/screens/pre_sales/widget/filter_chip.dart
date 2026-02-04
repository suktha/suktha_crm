import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/controllers/get_lead_controller.dart';

Widget buildFilterChip(VoidCallback onTap, String title, IconData icon,
    GetLeadController controller) {
  bool isSelected = controller.selectedFilters.value == title;
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xFF4facfe), Color(0xFF00f2fe)])
            : null,
        color: isSelected ? null : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? const Color(0xFF4facfe).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: isSelected ? 12 : 6,
            offset: Offset(0, isSelected ? 4 : 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
          SizedBox(width: 1.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    ),
  );
}
