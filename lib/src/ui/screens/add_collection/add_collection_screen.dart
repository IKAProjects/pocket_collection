import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_collection/src/infrastructure/utils/category_data.dart';

import '../../../../gen/assets.gen.dart';
import '../../../domain/models/collection_model.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../widgets/app_button.dart';
import '../blocs/collection_bloc/collection_bloc.dart';
import '../collections/widgets/custom_text_field.dart';

class AddCollectionScreen extends StatefulWidget {
  const AddCollectionScreen({super.key});

  @override
  _AddCollectionScreenState createState() => _AddCollectionScreenState();
}

class _AddCollectionScreenState extends State<AddCollectionScreen> {
  String? _selectedCategory;
  String? _selectedIcon;
  final _collectionNameController = TextEditingController();
  final _itemCountController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _collectionNameController.addListener(_validateForm);
    _itemCountController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _collectionNameController.text.isNotEmpty &&
          _itemCountController.text.isNotEmpty &&
          _selectedCategory != null &&
          _selectedIcon != null;
    });
  }

  @override
  void dispose() {
    _collectionNameController.dispose();
    _itemCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        height: 600.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppButton(
              onPressed: () => Navigator.pop(context),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.arrowBack,
                    width: 17.w,
                    height: 22.h,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Back',
                    style: AppStyles.helper2.copyWith(
                      color: AppColors.green,
                    ),
                  )
                ],
              ),
            ),
            // Title
            Text(
              'Add new collection',
              style: AppStyles.helper1,
            ),
            SizedBox(height: 24.h),

            AppButton(
              onPressed: () {
                _showCategoryBottomSheet(context);
              },
              child: SizedBox(
                height: 60.h,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.gray2A2A2A,
                      ),
                      child: (_selectedIcon != null)
                          ? SvgPicture.asset(
                        _selectedIcon!,
                        fit: BoxFit.contain,
                        width: 32.w,
                        height: 32.h,
                      )
                          : SvgPicture.asset(
                        Assets.svg.handbag,
                        fit: BoxFit.contain,
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style: AppStyles.helper2.copyWith(
                            color: AppColors.gray8E8E93,
                          ),
                        ),
                        Text(
                          _selectedCategory ?? 'Cards',
                          style: AppStyles.helper4.copyWith(fontSize: 17.sp),
                        ),
                      ],
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
              )
              ,
            ),
            SizedBox(height: 24.h),

            Text(
              'Collection name',
              style: AppStyles.helper2,
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _collectionNameController,
              hint: 'For example - Memoriable collection',
              onChanged: (val) {
                _validateForm();
              },
            ),
            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Number of items',
                  style: AppStyles.helper2,
                ),
                Text(
                  'Optional',
                  style: AppStyles.helper2.copyWith(color: AppColors.gray8E8E93),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _itemCountController,
              hint: 'For example - 34',
              onChanged: (val) {
                _validateForm();
              },
            ),

            const Spacer(),

            AppButton(
              onPressed: _isButtonEnabled
                  ? () {
                final collectionName = _collectionNameController.text;
                final itemCount = _itemCountController.text.isNotEmpty
                    ? int.tryParse(_itemCountController.text)
                    : 0;

                final colId = DateTime.now().toIso8601String();
                final newCollection = CollectionModel(
                  category: _selectedCategory ?? 'Default Category',
                  collectionName: collectionName,
                  itemCount: itemCount,
                  iconPath: _selectedIcon ?? Assets.svg.other,
                  id: colId,
                  items: [],
                );

                context
                    .read<CollectionBloc>()
                    .add(AddCollection(newCollection));

                Navigator.pop(context);
              }
                  : null,
              child: Opacity(
                opacity: _isButtonEnabled ? 1.0 : 0.2,
                child: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Create collection',
                    style: AppStyles.helper4.copyWith(
                      fontSize: 17.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  void _showCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.gray1D1D1F,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          height: 670.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton(
                onPressed: () => Navigator.pop(context),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.arrowBack,
                      width: 17.w,
                      height: 22.h,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Back',
                      style: AppStyles.helper2.copyWith(
                        color: AppColors.green,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Select Category',
                style: AppStyles.helper1,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final data = categoryData[index];
                    return AppButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = data.category;
                          _selectedIcon = data.icon;
                          _validateForm();
                        });
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 60.h,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.gray2A2A2A,
                              ),
                              child: SvgPicture.asset(
                                data.icon,
                                fit: BoxFit.contain,
                                width: 32.w,
                                height: 32.h,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              data.category,
                              style: AppStyles.helper4.copyWith(fontSize: 17.sp),
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
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: categoryData.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
