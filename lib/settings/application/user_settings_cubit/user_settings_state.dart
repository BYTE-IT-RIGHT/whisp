part of 'user_settings_cubit.dart';

@immutable
sealed class UserSettingsState {
  const UserSettingsState();
}

class UserSettingsInitial extends UserSettingsState {
  const UserSettingsInitial();
}

class UserSettingsData extends UserSettingsState {
  final String username;
  final String avatarUrl;

  const UserSettingsData({required this.username, required this.avatarUrl});

  UserSettingsData copyWith({
    String? username,
    String? avatarUrl,
    bool? notificationsEnabled,
    bool? foregroundServiceEnabled,
  }) {
    return UserSettingsData(
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
