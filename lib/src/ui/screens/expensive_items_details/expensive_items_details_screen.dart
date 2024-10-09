import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_collection/src/domain/models/expensive_item_model.dart';
import 'package:pocket_collection/src/ui/screens/expensive_items/expensive_items_screen.dart';

import '../../../../gen/assets.gen.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../widgets/app_button.dart';

class ExpensiveItemsDetailsScreen extends StatelessWidget {
  const ExpensiveItemsDetailsScreen({
    super.key,
    required this.expensiveItemModel,
  });

  final ExpensiveItemModel expensiveItemModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                Image.asset(
                  expensiveItemModel.image,
                  fit: BoxFit.cover,
                  height: 400.h,
                  width: double.infinity,
                ),
                Positioned(
                  left: 16.w,
                  top: 50.h,
                  child: AppButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.arrowBack,
                          width: 17.w,
                          height: 22.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Back',
                          style: AppStyles.helper2.copyWith(
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    expensiveItemModel.name,
                    style: AppStyles.helper1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    expensiveItemModel.text,
                    style: AppStyles.helper2.copyWith(
                      color: AppColors.gray8E8E93,
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}