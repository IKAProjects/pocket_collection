import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../domain/models/item_model.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../../infrastructure/routes/app_router.dart';
import '../../widgets/app_button.dart';
import '../../widgets/confirmation_dialog.dart';
import '../add_item/add_item_screen.dart';
import '../blocs/item_bloc/item_bloc.dart';

class ItemInfoScreen extends StatefulWidget {
  const ItemInfoScreen({super.key, required this.itemModel});

  final ItemModel itemModel;

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              widget.itemModel.imagePath!,
              fit: BoxFit.cover,
              height: 489.h,
              width: double.infinity,
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: Center(
                  child: AppButton(
                    onPressed: () {
                      context.goNamed(Routes.collectionItems);
                    },
                    child: SvgPicture.asset(
                      Assets.svg.arrowBack,
                      width: 17.w,
                      height: 22.h,
                    ),
                  ),
                ),
                centerTitle: false,
                title: Text(
                  'Back',
                  style: AppStyles.helper2.copyWith(
                    color: AppColors.green,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  widget.itemModel.name,
                  style: AppStyles.helper1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Container(
                      width: 120.w,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: AppColors.yellowFED555,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            widget.itemModel.type,
                            style:
                                AppStyles.helper2.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Row(
                      children: [
                        Container(
                          height: 30.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: AppColors.gray1D1D1F,
                          ),
                          child: Text(
                            widget.itemModel.number.toString(),
                            style: AppStyles.helper2,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 30.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: AppColors.gray1D1D1F,
                          ),
                          child: Text(
                            widget.itemModel.price.toString(),
                            style: AppStyles.helper2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 120.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      onPressed: () {
                        _showAddItemBottomSheet(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        height: 50.h,
                        width: 174.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.gray2A2A2A,
                        ),
                        child: Text(
                          'Edit',
                          style: AppStyles.helper2.copyWith(fontSize: 17.sp),
                        ),
                      ),
                    ),
                    AppButton(
                      onPressed: () {
                        _showDeleteDialog(context, widget.itemModel);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        height: 50.h,
                        width: 174.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.gray2A2A2A,
                        ),
                        child: Text(
                          'Delete',
                          style: AppStyles.helper2.copyWith(fontSize: 17.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context, ItemModel item) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              context.read<ItemBloc>().add(DeleteItem(item.id));
            });
            Navigator.pop(context);
          },
          name: 'Delete',
          description:
              'Are you sure you want to delete this item from the collection?',
          leftText: 'Yes',
          rightText: 'No',
          isRed: false,
        );
      },
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
        return AddItemScreen(
          itemModel: widget.itemModel,
        );
      },
    );
  }
}
