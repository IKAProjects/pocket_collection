import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_collection/src/ui/widgets/app_button.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../infrastructure/resources/app_styles.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.icon, required this.name, this.onTap});

  final String icon;
  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return           AppButton(
      onPressed: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 60.h,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: const Color(0xFF141414),
              ),
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.contain,
                width: 32.w,
                height: 32.h,
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              name,
              style:
              AppStyles.helper4.copyWith(fontSize: 17.sp),
            ),
            const Spacer(),
            SvgPicture.asset(

              Assets.svg.arrowRight,
              fit: BoxFit.contain,
              width: 11.w,
              height: 17.h,
            ),
          ],
        ),
      ),
    );
  }
}
