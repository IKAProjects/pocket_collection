import 'package:hive/hive.dart';

part 'achievement_model.g.dart';

@HiveType(typeId: 2)
class AchievementModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String image;

  @HiveField(2)
   DateTime? dateTime;

  @HiveField(3)
  final String name;

  @HiveField(4)
  bool isUnlocked;

  AchievementModel({
    required this.id,
    required this.image,
    required this.dateTime,
    required this.name,
    this.isUnlocked = false,
  });
}