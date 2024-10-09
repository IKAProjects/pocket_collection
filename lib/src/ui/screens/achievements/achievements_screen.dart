import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pocket_collection/src/infrastructure/utils/category_data.dart';

import '../../../domain/models/achevement_model.dart';
import '../../../domain/models/collection_model.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../../infrastructure/utils/achievemnt_data.dart';
import '../../widgets/app_button.dart';
import '../blocs/collection_bloc/collection_bloc.dart';
import '../blocs/item_bloc/item_bloc.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Achievement',
                style: AppStyles.helper1,
              ),
            ),
            SizedBox(height: 34.h),
            Expanded(
              child: BlocBuilder<CollectionBloc, CollectionState>(
                builder: (context, collectionState) {
                  return BlocBuilder<ItemBloc, ItemState>(
                    builder: (context, itemState) {
                      int collectionCount = 0;
                      int itemCount = 0;
                      DateTime? lastItemDate;

                      if (collectionState is CollectionLoaded) {
                        collectionCount = collectionState.collections.length;
                      }

                      if (itemState is ItemsLoaded) {
                        itemCount = itemState.items.length;
                        lastItemDate = itemState.items.isNotEmpty
                            ? itemState.items.last.createdDate
                            : null;
                      }

                      return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: 104 / 204,
                        ),
                        itemCount: achievementData.length,
                        itemBuilder: (context, index) {
                          final achievement = achievementData[index];

                          List<CollectionModel> collections = [];
                          if (collectionState is CollectionLoaded) {
                            collections = collectionState.collections;
                          }

                          bool isUnlocked = _isAchievementUnlocked(
                              index, collections, itemCount, lastItemDate);

                          return AppButton(
                            onPressed: isUnlocked
                                ? () {
                                    _showAchievementBottomSheet(
                                        context, achievement);
                                  }
                                : null,
                            child: Column(
                              children: [
                                Image.asset(
                                  achievement.image,
                                  fit: BoxFit.contain,
                                  width: 104.w,
                                  height: 104.h,
                                  color: isUnlocked
                                      ? null
                                      : const Color(0xFF131313),
                                ),
                                SizedBox(height: 6.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 3.h),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: AppColors.gray1D1D1F,
                                  ),
                                  child: Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(achievement.dateTime),
                                    style: AppStyles.helper3,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  achievement.name,
                                  style: AppStyles.helper4
                                      .copyWith(fontSize: 12.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isAchievementUnlocked(int index, List<CollectionModel> collections,
      int itemCount, DateTime? lastItemDate) {
    if (index == 0 && collections.length >= 1) {
      return true;
    } else if (index == 1 && collections.length >= 3) {
      return true;
    } else if (index == 2 && collections.length >= 5) {
      return true;
    } else if (index == 3 && collections.length >= 10) {
      return true;
    } else if (index == 4 && collections.length >= 25) {
      return true;
    } else if (index == 5 && itemCount >= 10) {
      return true;
    } else if (index == 6 && itemCount >= 30) {
      return true;
    } else if (index == 7 && itemCount >= 50) {
      return true;
    } else if (index == 8 && itemCount >= 75) {
      return true;
    } else if (index == 9 && itemCount >= 100) {
      return true;
    } else if (index == 10 && itemCount >= 250) {
      return true;
    } else if (index == 11 && itemCount >= 500) {
      return true;
    } else if (index == 12 && itemCount >= 1000) {
      return true;
    } else if (index == 13 && lastItemDate != null) {
      final currentDate = DateTime.now();
      return (currentDate.isAfter(lastItemDate.add(Duration(days: 7))));
    } else if (index == 14) {
      final uniqueCollectionIds =
          collections.map((collection) => collection.id).toSet();
      return uniqueCollectionIds.length >= 3;
    } else if (index == 15) {
      final uniqueCollectionIds =
          collections.map((collection) => collection.id).toSet();
      return uniqueCollectionIds.length >= 5;
    } else if (index == 16) {
      final uniqueCollectionIds =
          collections.map((collection) => collection.id).toSet();
      return uniqueCollectionIds.length >= 10;
    } else if (index == 17) {
      final uniqueCollectionIds =
          collections.map((collection) => collection.id).toSet();
      return uniqueCollectionIds.length >= 1;
    } else if (index == 18) {
      final uniqueCollectionIds =
          collections.map((collection) => collection.id).toSet();
      return uniqueCollectionIds.length >= 3;
    } else if (index == 19) {
      final createdCategoryIds =
          collections.map((collection) => collection.id).toSet();
      return categoryData
          .every((categoryId) => createdCategoryIds.contains(categoryId));
    } else if (index == 20) {
      int rareCollectionCount = collections
          .where((collection) => collection.category == 'Rare')
          .length;
      return rareCollectionCount >= 100;
    } else if (index == 21) {
      int epicCollectionCount = collections
          .where((collection) => collection.category == 'Epic')
          .length;
      return epicCollectionCount >= 50;
    } else if (index == 22) {
      int legendaryCollectionCount = collections
          .where((collection) => collection.category == 'Legendary')
          .length;
      return legendaryCollectionCount >= 10;
    } else if (index == 23) {
      int handbagCollectionCount = collections
          .where((collection) => collection.category == 'Handbag')
          .length;
      return handbagCollectionCount >= 1;
    } else if (index == 24) {
      int handbagCollectionCount = collections
          .where((collection) => collection.category == 'Handbag')
          .length;
      return handbagCollectionCount >= 5;
    } else if (index == 25) {
      int handbagCollectionCount = collections
          .where((collection) => collection.category == 'Handbag')
          .length;
      return handbagCollectionCount >= 20;
    } else if (index == 26) {
      int handbagCollectionCount = collections
          .where((collection) => collection.category == 'Handbag')
          .length;
      return handbagCollectionCount >= 40;
    } else if (index == 27) {
      int handbagCollectionCount = collections
          .where((collection) => collection.category == 'Handbag')
          .length;
      return handbagCollectionCount >= 80;
    } else if (index == 28) {
      bool hasCoinsCollection =
          collections.any((collection) => collection.category == 'Coins');
      bool hasCurrencyCollection =
          collections.any((collection) => collection.category == 'Currency');
      return hasCoinsCollection && hasCurrencyCollection;
    } else if (index == 29) {
      bool hasBooksCollection =
          collections.any((collection) => collection.category == 'Books');
      bool hasComicsCollection =
          collections.any((collection) => collection.category == 'Comics');
      return hasBooksCollection && hasComicsCollection;
    } else if (index == 30) {
      bool hasActionFiguresCollection = collections
          .any((collection) => collection.category == 'Action Figures');
      bool hasToyCarsCollection =
          collections.any((collection) => collection.category == 'Toy Cars');
      return hasActionFiguresCollection && hasToyCarsCollection;
    } else if (index == 31) {
      bool hasVinylRecordsCollection = collections
          .any((collection) => collection.category == 'Vinyl Records');
      bool hasMusicInstrumentsCollection = collections
          .any((collection) => collection.category == 'Music Instruments');
      return hasVinylRecordsCollection && hasMusicInstrumentsCollection;
    }

    return false;
  }

  Future<void> _showAchievementBottomSheet(
      BuildContext context, AchievementModel achievement) async {
    showModalBottomSheet(
      backgroundColor: AppColors.gray1D1D1F,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 542.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFEEEEEE),
                Color(0xFF9AA5BE),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Image.asset(
                achievement.image,
                fit: BoxFit.contain,
                width: 274.w,
                height: 274.h,
              ),
              SizedBox(height: 26.h),
              Text(
                achievement.name,
                style: AppStyles.helper1.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.black,
                ),
                child: Text(
                  'Close',
                  style: AppStyles.helper4.copyWith(fontSize: 17.sp),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
