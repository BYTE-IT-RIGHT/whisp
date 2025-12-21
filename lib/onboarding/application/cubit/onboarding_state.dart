part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingSuccess extends OnboardingState {}

final class OnboardingError extends OnboardingState {
  final Failure failure;
  OnboardingError(this.failure);
}
