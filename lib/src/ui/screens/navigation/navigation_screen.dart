import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_collection/src/ui/widgets/app_button.dart';

import '../../../domain/models/image_item.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/utils/image_items.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: widget.child),
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 24.h, right: 20.w, left: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  imageItems.length,
                  (index) {
                    final item = imageItems[index];
                    return _buildNavigationBarItem(
                      imageItem: item,
                      selected: index == _selected,
                      onTap: () {
                        _selected = index;
                        context.go(item.path);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBarItem({
    required ImageItem imageItem,
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return AppButton(
      onPressed: onTap,
      child: SizedBox(
        height: 42.h,
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                imageItem.asset,
                fit: BoxFit.cover,
                color: selected ? AppColors.green : AppColors.gray65706C,
                width: 24.w,
                height: 24.w,
              ),
              Text(
                imageItem.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: selected ? AppColors.green : AppColors.gray65706C,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
