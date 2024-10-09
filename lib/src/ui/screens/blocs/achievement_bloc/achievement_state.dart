part of 'achievement_bloc.dart';

sealed class AchievementState extends Equatable {
  const AchievementState();
}

final class AchievementInitial extends AchievementState {
  @override
  List<Object> get props => [];
}
