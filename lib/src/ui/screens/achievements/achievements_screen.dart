import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_collection/src/infrastructure/resources/app_styles.dart';
import 'package:pocket_collection/src/ui/widgets/app_button.dart';

import '../../../../gen/assets.gen.dart';
import '../../../infrastructure/resources/app_colors.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Achievement',
              style: AppStyles.helper1,
            ),
          ),
          SizedBox(height: 34.h),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 104 / 170),
              itemCount: 6,
              itemBuilder: (context, index) {
                return AppButton(
                  onPressed: () {
                    _showAddItemBottomSheet(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.png.achievement1.path,
                          fit: BoxFit.contain,
                          width: 104.w,
                          height: 104.h,
                          color: const Color(0xFF131313),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: AppColors.gray1D1D1F,
                          ),
                          child: Text(
                            '24 Jul 2024',
                            style: AppStyles.helper3,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Add your first collection',
                          style: AppStyles.helper4.copyWith(fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showAddItemBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: AppColors.gray1D1D1F,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 542.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFEEEEEE),
                Color(0xFF9AA5BE),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Image.asset(
                Assets.png.reward1.path,
                fit: BoxFit.contain,
                width: 274.w,
                height: 274.h,
              ),
              SizedBox(height: 26.h),
              Text(
                'New week - new collection item',
                style: AppStyles.helper1.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Container(
                alignment: Alignment.center,
width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.black,
                ),
                child: Text(
                  'Close',
                  style: AppStyles.helper4.copyWith(fontSize: 17.sp),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
