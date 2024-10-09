import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_collection/src/ui/screens/achievements/achievements_screen.dart';
import 'package:pocket_collection/src/ui/screens/collections/collections_screen.dart';
import 'package:pocket_collection/src/ui/screens/expensive_items/expensive_items_screen.dart';

import '../../../gen/assets.gen.dart';
import '../../infrastructure/resources/app_colors.dart';
import '../screens/settings/settings_screen.dart';
import 'app_button.dart';

class AppBottomBarState extends State<AppBottomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ClipRRect(
        child: Container(
          color: AppColors.black,
          height: 120.h,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: buildNavItem(0, Assets.svg.collections, 'Collections'),
              ),
              Expanded(
                child: buildNavItem(1, Assets.svg.star, 'Achievements'),
              ),
              Expanded(
                child: buildNavItem(2, Assets.svg.dollar, 'Expensive items'),
              ),
              Expanded(
                child: buildNavItem(3, Assets.svg.gear, 'Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String iconPath, String name) {
    bool isActive = _currentIndex == index;

    return AppButton(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24.sp,
                height: 24.sp,
                color: isActive ? AppColors.green : AppColors.gray65706C,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.green : AppColors.gray65706C,
                ),
              )
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  final _pages = <Widget>[
    const CollectionsScreen(),
    const AchievementsScreen(),
    const ExpensiveItemsScreen(),
    const SettingsScreen(),
  ];
}

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key, this.indexScr = 0});

  final int indexScr;

  @override
  State<AppBottomBar> createState() => AppBottomBarState();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppBottomBar(),
    );
  }
}
