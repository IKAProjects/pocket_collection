import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../infrastructure/resources/app_colors.dart';
import '../../../../infrastructure/resources/app_styles.dart';
import '../../../widgets/app_button.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key, required this.onSortSelected});

  final Function(String) onSortSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            height: 400.h,
            width: 359.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF252525).withOpacity(0.9),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.h),
                Text(
                  'Select sort type',
                  style: AppStyles.helper4.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFF7F7F7F),
                  ),
                ),
                SizedBox(height: 14.h),
                Divider(
                  color: const Color(0xFF3C3C43).withOpacity(0.9),
                  height: 0.5,
                ),
                SizedBox(height: 12.h),
                AppButton(
                  onPressed: () {
                    onSortSelected('newToOld');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "From new to old",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 17.h),
                Divider(
                  color: const Color(0xFF3C3C43).withOpacity(0.9),
                  height: 0.5,
                ),
                SizedBox(height: 17.h),
                AppButton(
                  onPressed: () {
                    onSortSelected('oldToNew');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "From old to new",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 17.h),
                Divider(
                  color: const Color(0xFF3C3C43).withOpacity(0.9),
                  height: 0.5,
                ),
                SizedBox(height: 17.h),
                AppButton(
                  onPressed: () {
                    onSortSelected('A-Z');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "By alphabet A-Z",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 17.h),
                Divider(
                  color: const Color(0xFF3C3C43).withOpacity(0.9),
                  height: 0.5,
                ),
                SizedBox(height: 17.h),
                AppButton(
                  onPressed: () {
                    onSortSelected('Z-A');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "By alphabet Z-A",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 17.h),
                Divider(
                  color: const Color(0xFF3C3C43).withOpacity(0.9),
                  height: 0.5,
                ),
                SizedBox(height: 17.h),
                AppButton(
                  onPressed: () {
                    onSortSelected('HighToLow');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "From high to low price",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 17.h),
                Divider(
                  color: const Color(0xFF3C3C43).withOpacity(0.9),
                  height: 0.5,
                ),
                SizedBox(height: 17.h),
                AppButton(
                  onPressed: () {
                    onSortSelected('LowToHigh');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "From low to high price",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 13.h),
              ],
            ),
          ),
        ),
        SizedBox(height: 6.h),
        AppButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.center,
            height: 56.h,
            decoration: BoxDecoration(
              color: const Color(0xFF252525).withOpacity(0.9),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}
