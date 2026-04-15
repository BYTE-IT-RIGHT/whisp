part of 'app_startup_cubit.dart';

@freezed
sealed class AppStartupState with _$AppStartupState {
  const factory AppStartupState.loading({
    required double progress,
    required String statusMessage,
  }) = AppStartupLoading;

  const factory AppStartupState.authenticated({required String onionAddress}) =
      AppStartupAuthenticated;
  const factory AppStartupState.tutorialPending(String onionAddress) =
      AppStartupTutorialPending;
  const factory AppStartupState.localAuthRequired(String onionAddress) =
      AppLocalAuthRequired;
  const factory AppStartupState.unauthenticated(String onionAddress) =
      AppStartupUnauthenticated;
  const factory AppStartupState.error(
    Failure failure, [
    @Default('') String message,
  ]) = AppStartupError;
}
