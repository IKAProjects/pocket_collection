import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../infrastructure/resources/app_colors.dart';
import '../../../../infrastructure/resources/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hint, this.controller, this.onChanged});

  final String hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 48.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.gray2A2A2A,
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        style: AppStyles.helper2,
        cursorColor: Colors.white,
        decoration: InputDecoration.collapsed(
          hintText: hint,
          hintStyle: AppStyles.helper2.copyWith(
            color: AppColors.gray8E8E93,
          ),
        ),
      ),
    );
  }
}
