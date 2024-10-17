import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pocket_collection/src/infrastructure/utils/category_data.dart';

import '../../../../di.dart';
import '../../../data/achievement_repository.dart';
import '../../../domain/models/achievement_model.dart';
import '../../../domain/models/collection_model.dart';
import '../../../infrastructure/resources/app_colors.dart';
import '../../../infrastructure/resources/app_styles.dart';
import '../../../infrastructure/services/prefs.dart';
import '../../../infrastructure/utils/achievemnt_data.dart';
import '../../widgets/app_button.dart';
import '../blocs/collection_bloc/collection_bloc.dart';
import '../blocs/item_bloc/item_bloc.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late final AchievementRepository _achievementRepository;
  @override
  void initState() {
    super.initState();
    _achievementRepository = getIt<AchievementRepository>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowAchievements();
    });
  }


  void _checkAndShowAchievements() async {
    final collectionBlocState = context.read<CollectionBloc>().state;
    final itemBlocState = context.read<ItemBloc>().state;

    if (collectionBlocState is CollectionLoaded && itemBlocState is ItemsLoaded) {
      List<CollectionModel> collections = collectionBlocState.collections;
      int itemCount = itemBlocState.items.length;
      DateTime? lastItemDate;

      if (itemBlocState.items.isNotEmpty) {
        lastItemDate = itemBlocState.items.last.createdDate;
      }

      for (int index = 0; index < achievementData.length; index++) {
        if (achievementData[index].isUnlocked) continue;

        bool isUnlocked = await _isAchievementUnlocked(index, collections, itemCount, lastItemDate);
        if (isUnlocked) {
          achievementData[index].isUnlocked = true;
          achievementData[index].dateTime = DateTime.now();
          _showAchievementBottomSheet(context, achievementData[index]);
        }
      }
    }
  }
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
                      int itemCount = 0;
                      DateTime? lastItemDate;

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

                          return FutureBuilder<bool>(
                            future: _isAchievementUnlocked(index, collections, itemCount, lastItemDate),
                            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }

                              bool isUnlocked = snapshot.data ?? false;

                              return AppButton(
                                onPressed: isUnlocked
                                    ? () {
                                  _showAchievementBottomSheet(context, achievement);
                                }
                                    : null,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      achievement.image,
                                      fit: BoxFit.contain,
                                      width: 104.w,
                                      height: 104.h,
                                      color: isUnlocked ? null : const Color(0xFF131313),
                                    ),
                                    SizedBox(height: 6.h),
                                    if (isUnlocked)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6.r),
                                          color: AppColors.gray1D1D1F,
                                        ),
                                        child: Text(
                                          DateFormat('dd MMM yyyy').format(achievement.dateTime!),

                                          style: AppStyles.helper3,
                                        ),
                                      ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      achievement.name,
                                      style: AppStyles.helper4.copyWith(fontSize: 12.sp),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _isAchievementUnlocked(int index, List<CollectionModel> collections,
      int itemCount, DateTime? lastItemDate) async {
    bool unlocked = false;
    print("Checking achievement $index: collections length = ${collections.length}, itemCount = $itemCount");

    switch (index) {
      case 0:
        unlocked = collections.length >= 1;
        break;
      case 1:
        unlocked = collections.length >= 3;
        break;
      case 2:
        unlocked = collections.length >= 5;
        break;
      case 3:
        unlocked = collections.length >= 10;
        break;
      case 4:
        unlocked = collections.length >= 25;
        break;
      case 5:
        unlocked = itemCount >= 10;
        break;
      case 6:
        unlocked = itemCount >= 30;
        break;
      case 7:
        unlocked = itemCount >= 50;
        break;
      case 8:
        unlocked = itemCount >= 75;
        break;
      case 9:
        unlocked = itemCount >= 100;
        break;
      case 10:
        unlocked = itemCount >= 250;
        break;
      case 11:
        unlocked = itemCount >= 500;
        break;
      case 12:
        unlocked = itemCount >= 1000;
        break;
      case 13:
        final firstLaunchDate = await Prefs.getFirstLaunchDate();
        if (firstLaunchDate != null) {
          final achievementUnlockDate = firstLaunchDate.add(Duration(days: 7));
          unlocked = DateTime.now().isAfter(achievementUnlockDate);
        }
        break;
      case 14:
        unlocked = collections.map((collection) => collection.id).toSet().length >= 3;
        break;
      case 15:
        unlocked = collections.map((collection) => collection.id).toSet().length >= 5;
        break;
      case 16:
        unlocked = collections.map((collection) => collection.id).toSet().length >= 10;
        break;
      case 17:
        unlocked = collections.map((collection) => collection.id).toSet().length >= 1;
        break;
      case 18:
        unlocked = collections.map((collection) => collection.id).toSet().length >= 3;
        break;
      case 19:
        final createdCategoryIds = collections.map((collection) => collection.id).toSet();
        unlocked = categoryData.every((categoryId) => createdCategoryIds.contains(categoryId));
        break;
      case 20:
        unlocked = collections.where((collection) => collection.category == 'Rare').length >= 100;
        break;
      case 21:
        unlocked = collections.where((collection) => collection.category == 'Epic').length >= 50;
        break;
      case 22:
        unlocked = collections.where((collection) => collection.category == 'Legendary').length >= 10;
        break;
      case 23:
        unlocked = collections.where((collection) => collection.category == 'Handbag').length >= 1;
        break;
      case 24:
        unlocked = collections.where((collection) => collection.category == 'Handbag').length >= 5;
        break;
      case 25:
        unlocked = collections.where((collection) => collection.category == 'Handbag').length >= 20;
        break;
      case 26:
        unlocked = collections.where((collection) => collection.category == 'Handbag').length >= 40;
        break;
      case 27:
        unlocked = collections.where((collection) => collection.category == 'Handbag').length >= 80;
        break;
      case 28:
        unlocked = collections.any((collection) => collection.category == 'Coins') &&
            collections.any((collection) => collection.category == 'Currency');
        break;
      case 29:
        unlocked = collections.any((collection) => collection.category == 'Books') &&
            collections.any((collection) => collection.category == 'Comics');
        break;
      case 30:
        unlocked = collections.any((collection) => collection.category == 'Action Figures') &&
            collections.any((collection) => collection.category == 'Toy Cars');
        break;
      case 31:
        unlocked = collections.any((collection) => collection.category == 'Vinyl Records') &&
            collections.any((collection) => collection.category == 'Music Instruments');
        break;
    }

    if (unlocked && !achievementData[index].isUnlocked) {
      achievementData[index].isUnlocked = true;
      achievementData[index].dateTime = DateTime.now();


      _achievementRepository.saveAchievement(achievementData[index]);
    }

    return unlocked;
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
              AppButton(
                onPressed: ()=>  Navigator.of(context).pop(),
                child: Container(
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
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
