part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsData extends SettingsState {
  final String username;
  final String avatarUrl;
  final bool notificationsEnabled;
  final bool foregroundServiceEnabled;

  const SettingsData({
    required this.username,
    required this.avatarUrl,
    required this.notificationsEnabled,
    required this.foregroundServiceEnabled,
  });

  SettingsData copyWith({
    String? username,
    String? avatarUrl,
    bool? notificationsEnabled,
    bool? foregroundServiceEnabled,
  }) {
    return SettingsData(
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      foregroundServiceEnabled: foregroundServiceEnabled ?? this.foregroundServiceEnabled,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);
}

