import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../infrastructure/resources/app_colors.dart';
import '../../../../infrastructure/resources/app_styles.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.itemCount,
    required this.name,
    required this.category,
    required this.image,
     required this.price,
  });

  final int itemCount;
  final String name;
  final String category;
  final String image;
  final int price;

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Rare':
        return AppColors.green;
      case 'Legendary':
        return AppColors.yellowFED555;
      case 'Epic':
        return AppColors.violet;
      default:
        return AppColors.grayD9D9D9;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 174.w,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child:Image.file(
                  File(image),
                  fit: BoxFit.cover,
                  width: 173.w,
                  height: 168.h,
                )
              ),
              Positioned(
                bottom: 10.h,
                left: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 8.h,
                        width: 8.w,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getCategoryColor(category),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        category,
                        style: AppStyles.helper2.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.gray1D1D1F,
                ),
                child: Text(
                  itemCount.toString(),
                  style: AppStyles.helper3,
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.gray1D1D1F,
                ),
                child: Text(
                  '$price USD',
                  style: AppStyles.helper3,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            name,
            style: AppStyles.helper4,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}