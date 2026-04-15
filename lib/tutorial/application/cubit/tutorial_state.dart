part of 'tutorial_cubit.dart';

@freezed
sealed class TutorialState with _$TutorialState {
  const factory TutorialState.initial() = TutorialInitial;
  const factory TutorialState.completed() = TutorialCompleted;
}
