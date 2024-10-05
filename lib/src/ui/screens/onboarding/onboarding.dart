import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../../infrastructure/routes/app_router.dart';
import '../../../infrastructure/utils/box_assets.dart';
import '../../widgets/app_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              itemCount: boxAssets.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.r),
                        bottomRight: Radius.circular(32.r),
                      ),
                      child: Image.asset(
                        boxAssets[i].asset,
                        fit: BoxFit.cover,
                        height: 561.h,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            boxAssets[i].text1,
                            style: AppStyles.helper1,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            boxAssets[i].text2,
                            style: AppStyles.helper2,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 12.h),
                          AppButton(
                            onPressed: _nextPage,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.green,
                              ),
                              child: Text(
                                'Continue',
                                style: AppStyles.helper2.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    if (currentIndex < boxAssets.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      context.goNamed(Routes.collections);
    }
  }

}
