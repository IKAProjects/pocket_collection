import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_collection/src/ui/screens/add_item/add_item_screen.dart';
import 'package:pocket_collection/src/ui/screens/blocs/item_bloc/item_bloc.dart';
import 'package:pocket_collection/src/ui/screens/colletion_items/widgets/item_widget.dart';
import 'package:pocket_collection/src/ui/screens/colletion_items/widgets/sort_widget.dart';
import 'package:pocket_collection/src/ui/screens/item_info/item_info_screen.dart';

import '../../../../gen/assets.gen.dart';
import '../../../domain/models/collection_model.dart';
import '../../../domain/models/item_model.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/empty_state_widget.dart';

class CollectionItemsScreen extends StatefulWidget {
  const CollectionItemsScreen({super.key, required this.collectionModel});

  final CollectionModel collectionModel;

  @override
  State<CollectionItemsScreen> createState() => _CollectionItemsScreenState();
}

class _CollectionItemsScreenState extends State<CollectionItemsScreen> {
  bool common = false;
  bool rare = false;
  bool epic = false;
  bool legendary = false;
  bool all = true;

  List<ItemModel> filteredItems = [];

  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(LoadItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: Center(
          child: AppButton(
            onPressed: () {
              Navigator.pop(context);
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: AppButton(
              onPressed: () {
                _showMenuDialog(context);
              },
              child: Text(
                'Sort',
                style: AppStyles.helper2.copyWith(
                  color: AppColors.green,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemsLoaded) {
            final items = state.items;

            final uniqueItems = items.where((item) {
              return item.collectionId?.trim() ==
                  widget.collectionModel.id.trim();
            }).toList();

            if (uniqueItems.isEmpty) {
              return EmptyStateWidget(
                isItem: true,
                onTap: () {
                  _showAddItemBottomSheet(context);
                },
                name: "You don’t have items in this collection",
                description:
                    "You haven't added any item yet. To add a new item, click the button below.",
              );
            }

            filteredItems = [];
            final Set<String> uniqueIds = {};

            for (var item in uniqueItems) {
              if (all) {
                filteredItems.add(item);
              } else {
                if (common &&
                    item.type == 'Common' &&
                    !uniqueIds.contains(item.id)) {
                  uniqueIds.add(item.id);
                  filteredItems.add(item);
                } else if (rare &&
                    item.type == 'Rare' &&
                    !uniqueIds.contains(item.id)) {
                  uniqueIds.add(item.id);
                  filteredItems.add(item);
                } else if (epic &&
                    item.type == 'Epic' &&
                    !uniqueIds.contains(item.id)) {
                  uniqueIds.add(item.id);
                  filteredItems.add(item);
                } else if (legendary &&
                    item.type == 'Legendary' &&
                    !uniqueIds.contains(item.id)) {
                  uniqueIds.add(item.id);
                  filteredItems.add(item);
                }
              }
            }

            final totalPrice = filteredItems.fold<double>(
                0.0, (sum, item) => sum + (item.price ?? 0));

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.collectionModel.collectionName,
                          style: AppStyles.helper1,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: AppColors.gray1D1D1F,
                              ),
                              child: Text(
                                '1 of ${filteredItems.length}',
                                style: AppStyles.helper3,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: AppColors.gray1D1D1F,
                              ),
                              child: Text(
                                'Total price - ${totalPrice.toStringAsFixed(2)} USD',
                                style: AppStyles.helper3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 33.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategory('All', all, () {
                          setState(() {
                            all = true;
                            common = false;
                            rare = false;
                            epic = false;
                            legendary = false;
                          });
                        }),
                        _buildCategory('Common', common, () {
                          setState(() {
                            all = false;
                            common = !common;
                          });
                        }),
                        _buildCategory('Rare', rare, () {
                          setState(() {
                            all = false;
                            rare = !rare;
                          });
                        }),
                        _buildCategory('Epic', epic, () {
                          setState(() {
                            all = false;
                            epic = !epic;
                          });
                        }),
                        _buildCategory('Legendary', legendary, () {
                          setState(() {
                            all = false;
                            legendary = !legendary;
                          });
                        }),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 173 / 261,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = filteredItems[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemInfoScreen(
                                      itemModel: item,
                                      collectionModel: widget.collectionModel,
                                    ),
                                  ),
                                );
                              },
                              child: ItemWidget(
                                itemCount: item.number,
                                name: item.name,
                                category: item.type,
                                image: item.imagePath!,
                                price: item.price?.toInt() ?? 0,
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: filteredItems.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemsLoaded) {
            final uniqueItems = state.items.where((item) {
              return item.collectionId?.trim() ==
                  widget.collectionModel.id.trim();
            }).toList();

            if (uniqueItems.isNotEmpty) {
              return AppButton(
                onPressed: () {
                  _showAddItemBottomSheet(context);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 182.w,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.svg.plus,
                        fit: BoxFit.contain,
                        width: 16.w,
                        height: 16.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Add new item',
                        style: AppStyles.helper4.copyWith(
                          fontSize: 17.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return const SizedBox();
        },
      ),
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
          collectionModel: widget.collectionModel,
          onItemEdited: (bool isEdited) {},
        );
      },
    );
  }

  Widget _buildCategory(
    String text,
    bool selected,
    VoidCallback onTap,
  ) {
    return AppButton(
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.green : AppColors.gray1D1D1F,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _showMenuDialog(BuildContext context) async {

    return showModalBottomSheet<void>(
      context: context,
      barrierColor: AppColors.black.withOpacity(0.5),
      backgroundColor: Colors.transparent,
      builder: (BuildContext cont) {
        return SortWidget(
          onSortSelected: (sortType, context) {
            setState(() {
              context.read<ItemBloc>().add(SortItems(sortType));
            });

            Navigator.pop(context);
          },
        );
      },
    );
  }
}
