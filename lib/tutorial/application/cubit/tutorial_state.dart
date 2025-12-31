part of 'tutorial_cubit.dart';

@immutable
sealed class TutorialState {}

final class TutorialInitial extends TutorialState {}

final class TutorialShowLocalAuthDialog extends TutorialState {
  final bool canShowDialog;

  TutorialShowLocalAuthDialog({required this.canShowDialog});
}

final class TutorialCompleted extends TutorialState {}

