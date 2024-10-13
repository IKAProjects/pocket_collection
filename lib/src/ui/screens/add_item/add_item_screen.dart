import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../gen/assets.gen.dart';
import '../../../domain/models/collection_model.dart';
import '../../../domain/models/item_model.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../widgets/app_button.dart';
import '../blocs/item_bloc/item_bloc.dart';
import '../collections/widgets/custom_text_field.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen(
      {super.key,  this.collectionModel, this.itemModel,   required this.onItemEdited,});

  final CollectionModel? collectionModel;
  final ItemModel? itemModel;
  final Function(bool isEdited) onItemEdited;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  late TextEditingController itemNameController;
  late TextEditingController itemNumberController;
  late TextEditingController itemPriceController;
  String selectedCategory = '';
  bool isFieldsValid = false;


  @override
  void initState() {
    super.initState();

    itemNameController = TextEditingController(
      text: widget.itemModel?.name ?? '',
    );
    itemNumberController = TextEditingController(
      text: widget.itemModel?.number?.toString() ?? '',
    );
    itemPriceController = TextEditingController(
      text: widget.itemModel?.price?.toString() ?? '',
    );
    selectedCategory = widget.itemModel?.type ?? '';

    if (widget.itemModel?.imagePath != null) {
      _imageFile = XFile(widget.itemModel!.imagePath!);
    }
    _validateFields();
  }

  void _validateFields() {
    final itemName = itemNameController.text;
    final itemNumber = itemNumberController.text;
    final categorySelected = selectedCategory;

    isFieldsValid = itemName.isNotEmpty &&
        itemNumber.isNotEmpty &&
        int.tryParse(itemNumber) != null &&
        categorySelected.isNotEmpty;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
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
          SizedBox(height: 12.h),
          Text(
            widget.itemModel != null ? 'Edit item' : 'Add new item',
            style: AppStyles.helper1,
          ),
          SizedBox(height: 12.h),
          Text(
            'Item photo',
            style: AppStyles.helper2,
          ),
          SizedBox(height: 8.h),
          _imageFile != null
              ? AppButton(
            onPressed: () async {
              _imageFile =
              await _picker.pickImage(source: ImageSource.gallery);
              setState(() {});
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.file(
                File(_imageFile!.path),
                fit: BoxFit.cover,
                height: 130.h,
                width: 200.w,
              ),
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                onPressed: () async {
                  _imageFile =
                  await _picker.pickImage(source: ImageSource.camera);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 176.w,
                  height: 102.h,
                  decoration: BoxDecoration(
                    color: AppColors.gray2A2A2A,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.svg.camera,
                        fit: BoxFit.contain,
                        width: 24.w,
                        height: 24.h,
                      ),
                      Text(
                        'Take photo',
                        style: AppStyles.helper2,
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(
                onPressed: () async {
                  _imageFile = await _picker.pickImage(
                      source: ImageSource.gallery);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: Alignment.center,
                  height: 102.h,
                  decoration: BoxDecoration(
                    color: AppColors.gray2A2A2A,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.svg.gallery,
                        fit: BoxFit.contain,
                        width: 24.w,
                        height: 24.h,
                      ),
                      Text(
                        'Select from gallery',
                        style: AppStyles.helper2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Item name',
            style: AppStyles.helper2,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: itemNameController,
            hint: 'For example - Memoriable collection',
            onChanged: (val) {
              _validateFields();
            },
          ),
          SizedBox(height: 16.h),
          Text(
            'Item number',
            style: AppStyles.helper2,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: itemNumberController,
            hint: 'For example - 34',
            onChanged: (val) {
              _validateFields();
            },
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: AppStyles.helper2,
              ),
              Text(
                'Optional',
                style: AppStyles.helper3.copyWith(fontSize: 15.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: itemPriceController,
            hint: 'For example - 34',

          ),
          SizedBox(height: 16.h),
          _buildCategorySelection(context),
          SizedBox(height: 12.h),
          AppButton(
            onPressed: () {
              final itemName = itemNameController.text;
              final itemNumber = itemNumberController.text;
              final itemPrice = itemPriceController.text;

              if (itemName.isNotEmpty && selectedCategory.isNotEmpty) {
                if (itemNumber.isNotEmpty &&
                    int.tryParse(itemNumber) != null) {
                  final itemId = widget.itemModel?.id ??
                      DateTime.now().toIso8601String();

                  final newItem = ItemModel(
                    name: itemName,
                    number: int.tryParse(itemNumber)!,
                    price: double.tryParse(itemPrice) ?? 0.0,
                    type: selectedCategory,
                    imagePath: _imageFile?.path,
                    id: itemId,
                    collectionId: widget.collectionModel?.id,
                    createdDate: widget.itemModel?.createdDate ??
                        DateTime.now(),
                  );

                  if (widget.itemModel != null) {
                    context.read<ItemBloc>().add(UpdateItem(newItem));
                  } else {
                    context.read<ItemBloc>().add(AddItem(newItem));
                    Navigator.pop(context);
                  }
                  widget.onItemEdited(true);
                }
              }
            },
            child: Opacity(
              opacity: isFieldsValid ? 1.0 : 0.2,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  widget.itemModel != null ? 'Update item' : 'Add item',
                  style: AppStyles.helper4.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildCategorySelection(BuildContext context) {
    final categories = ['Common', 'Legendary', 'Rare', 'Epic'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return AppButton(
            onPressed: () {
              setState(() {
                selectedCategory = category;
                _validateFields();
              });
            },

            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: isSelected ? Colors.white : AppColors.gray2A2A2A,
              ),
              child: Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    category,
                    style: AppStyles.helper2.copyWith(
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Legendary':
        return AppColors.yellowFED555;
      case 'Rare':
        return AppColors.green;
      case 'Epic':
        return AppColors.violet;
      default:
        return AppColors.grayD9D9D9;
    }
  }
}
