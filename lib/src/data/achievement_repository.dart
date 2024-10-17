import 'package:hive/hive.dart';

import '../domain/models/achievement_model.dart';

class AchievementRepository {
  final Box<AchievementModel> achievementBox;

  AchievementRepository(this.achievementBox);

  Future<void> saveAchievement(AchievementModel achievement) async {
    await achievementBox.put(achievement.id, achievement);
  }

  List<AchievementModel> loadAchievements() {
    return achievementBox.values.toList();
  }
}