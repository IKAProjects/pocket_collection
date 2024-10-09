import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_collection/src/infrastructure/resources/app_colors.dart';
import 'package:pocket_collection/src/infrastructure/resources/app_styles.dart';
import 'package:pocket_collection/src/ui/screens/add_collection/add_collection_screen.dart';
import 'package:pocket_collection/src/ui/screens/collections/widgets/collection_widget.dart';
import 'package:pocket_collection/src/ui/screens/colletion_items/collection_items_screen.dart';
import 'package:pocket_collection/src/ui/widgets/empty_state_widget.dart';
import '../../../../gen/assets.gen.dart';
import '../../../domain/models/collection_model.dart';
import '../../../infrastructure/utils/category_data.dart';
import '../../widgets/app_button.dart';
import '../blocs/collection_bloc/collection_bloc.dart';
import '../blocs/item_bloc/item_bloc.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen(
      {super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionBloc>().add(LoadCollections());
    context.read<ItemBloc>().add(LoadItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              BlocBuilder<CollectionBloc, CollectionState>(
                builder: (context, state) {
                  if (state is CollectionLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CollectionLoaded) {
                    final collectionsByCategory =
                        <String, List<CollectionModel>>{};

                    for (var collection in state.collections) {
                      collectionsByCategory
                          .putIfAbsent(
                            collection.category,
                            () => [],
                          )
                          .add(collection);
                    }

                    if (collectionsByCategory.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Collections',
                            style: AppStyles.helper1,
                          ),
                          SizedBox(height: 22.h),
                        ],
                      );
                    } else {
                      return EmptyStateWidget(
                        onTap: () {
                          _showAddCollectionBottomSheet(context);
                        },
                        name: 'No collections',
                        description:
                            "You haven't created any collections yet. To create a collection, click the button below.",
                      );
                    }
                  }
                  return Container();
                },
              ),
              Expanded(
                child: BlocBuilder<CollectionBloc, CollectionState>(
                  builder: (context, state) {
                    if (state is CollectionLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CollectionLoaded) {
                      final collectionsByCategory =
                          <String, List<CollectionModel>>{};

                      for (var collection in state.collections) {
                        collectionsByCategory
                            .putIfAbsent(collection.category, () => [])
                            .add(collection);
                      }

                      return ListView.separated(
                        itemCount: collectionsByCategory.keys.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final category =
                              collectionsByCategory.keys.elementAt(index);
                          final collections = collectionsByCategory[category]!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    getCategoryIcon(category),
                                    fit: BoxFit.contain,
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    category,
                                    style: AppStyles.helper4.copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                height: 261.h,
                                child: BlocBuilder<ItemBloc, ItemState>(
                                  builder: (context, itemState) {
                                    if (itemState is ItemLoading) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (itemState is ItemsLoaded) {
                                      final items = itemState.items;

                                      return ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: collections.length,
                                        itemBuilder:
                                            (context, collectionIndex) {
                                          final collection =
                                              collections[collectionIndex];

                                          final collectionItems = items
                                              .where((item) =>
                                                  item.collectionId ==
                                                  collection.id)
                                              .toList();

                                          final firstItem =
                                              collectionItems.isNotEmpty
                                                  ? collectionItems.first
                                                  : null;

                                          return CollectionWidget(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>  CollectionItemsScreen(collectionModel: collection),
                                                ),
                                              );
                                            },
                                            itemCount:
                                                collection.itemCount ?? 1,
                                            name: collection.collectionName,
                                            category:
                                                firstItem?.type ?? 'Common',
                                            image: firstItem?.imagePath ??
                                                Assets.png.vintage.path,
                                            price:
                                                firstItem?.price?.toInt() ?? 0,
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                SizedBox(width: 8.w),
                                      );
                                    } else if (itemState is ItemError) {
                                      return Center(
                                        child: Text(
                                            'Failed to load items: ${itemState.message}'),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is CollectionError) {
                      return Center(
                        child: Text(
                            'Failed to load collections: ${state.message}'),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          if (state is CollectionLoaded) {
            final collectionsByCategory = <String, List<CollectionModel>>{};

            for (var collection in state.collections) {
              collectionsByCategory
                  .putIfAbsent(
                    collection.category,
                    () => [],
                  )
                  .add(collection);
            }

            if (collectionsByCategory.isNotEmpty) {
              return AppButton(
                onPressed: () {
                  _showAddCollectionBottomSheet(context);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 228.w,
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
                        'Add new collection',
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

  void _showAddCollectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.gray1D1D1F,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (BuildContext context) {
        return const AddCollectionScreen();
      },
    );
  }

  String getCategoryIcon(String category) {
    final categoryModel = categoryData.firstWhere(
      (cat) => cat.category == category,
    );

    return categoryModel.icon;
  }
}
