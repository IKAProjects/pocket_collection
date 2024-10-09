import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_collection/src/infrastructure/resources/app_colors.dart';
import 'package:pocket_collection/src/infrastructure/resources/app_styles.dart';
import 'package:pocket_collection/src/ui/screens/expensive_items_details/expensive_items_details_screen.dart';
import 'package:pocket_collection/src/ui/widgets/app_button.dart';

import '../../../infrastructure/utils/expensive_item_data.dart';
import '../../../infrastructure/utils/extraordinary_collections.dart';

class ExpensiveItemsScreen extends StatefulWidget {
  const ExpensiveItemsScreen({super.key});

  @override
  _ExpensiveItemsScreenState createState() => _ExpensiveItemsScreenState();
}

class _ExpensiveItemsScreenState extends State<ExpensiveItemsScreen> {
  bool showCollectiblesSold = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Expensive items',
                  style: AppStyles.helper1,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showCollectiblesSold = true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          height: 43.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: showCollectiblesSold
                                ? AppColors.green
                                : AppColors.gray1D1D1F,
                          ),
                          child: Text(
                            'Expensive collectibles sold',
                            style: AppStyles.helper4.copyWith(
                              color: !showCollectiblesSold
                                  ? Colors.white
                                  : AppColors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showCollectiblesSold = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          height: 43.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: !showCollectiblesSold
                                ? AppColors.green
                                : AppColors.gray2A2A2A,
                          ),
                          child: Text(
                            'Extraordinary collections',
                            style: AppStyles.helper4.copyWith(
                              color: showCollectiblesSold
                                  ? Colors.white
                                  : AppColors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList.separated(
                itemCount: showCollectiblesSold
                    ? expensiveCollectiblesSold.length
                    : extraordinaryCollections.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = showCollectiblesSold
                      ? expensiveCollectiblesSold[index]
                      : extraordinaryCollections[index];
                  return AppButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ExpensiveItemsDetailsScreen(expensiveItemModel: item),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.cover,
                              height: 200.h,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            item.name,
                            style: AppStyles.helper2.copyWith(fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 24.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
