import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_collection/src/infrastructure/resources/app_colors.dart';
import 'package:pocket_collection/src/infrastructure/resources/app_styles.dart';
import 'package:pocket_collection/src/ui/screens/settings/widgets/row_widget.dart';

import '../../../../gen/assets.gen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 95.h),
          Image.asset(
            Assets.png.settingsImage.path,
            fit: BoxFit.contain,
            width: 130.w,
            height: 130.h,
          ),
          SizedBox(height: 24.h),
          Text(
            'Pocket collection',
            style: AppStyles.helper1.copyWith(fontSize: 22.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'Version 1.3.5',
            style: AppStyles.helper2.copyWith(color: AppColors.gray8E8E93),
          ),
          SizedBox(height: 60.h),
          RowWidget(
            icon: Assets.svg.privacy,
            name: 'Privacy Policy',
            onTap: (){},
          ),
          SizedBox(height: 16.h),
          RowWidget(
            icon: Assets.svg.privacy,
            name: 'Terms of Use',
            onTap: (){},
          ),
          SizedBox(height: 16.h),
          RowWidget(
            icon: Assets.svg.support,
            name: 'Support',
            onTap: (){},
          ),
          SizedBox(height: 16.h),
          RowWidget(
            icon: Assets.svg.share,
            name: 'Share',  onTap: (){},
          ),
        ],
      ),
    );
  }
}
