import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../infrastructure/resources/app_colors.dart';
import '../../infrastructure/resources/app_styles.dart';
import 'app_button.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.onTap,
    required this.name,
    required this.description,
    this.isItem = false,
  });

  final VoidCallback? onTap;
  final String name;
  final String description;
  final bool isItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        children: [
          SizedBox(height: 180.h),
          Image.asset(
            Assets.png.noCollection.path,
            fit: BoxFit.contain,
            width: 95.w,
            height: 95.h,
          ),
          SizedBox(height: 16.h),
          Text(
            name,
            style: AppStyles.helper1.copyWith(fontSize: 28.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: 285.w,
            child: Text(
              description,
              style: AppStyles.helper2.copyWith(color: AppColors.gray8E8E93),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          AppButton(
            onPressed: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              alignment: Alignment.center,
              height: 50.h,
              width: 228.w,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.svg.plus,
                    fit: BoxFit.contain,
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    isItem ? 'Add new item':'Add new collection',
                    style: AppStyles.helper4.copyWith(
                      fontSize: 17.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
