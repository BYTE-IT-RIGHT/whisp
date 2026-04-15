part of 'user_settings_cubit.dart';

@freezed
sealed class UserSettingsState with _$UserSettingsState {
  const factory UserSettingsState.initial() = UserSettingsInitial;
  const factory UserSettingsState.data({
    required String username,
    required String avatarUrl,
  }) = UserSettingsData;
}
