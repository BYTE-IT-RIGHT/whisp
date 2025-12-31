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
  final bool localAuthEnabled;
  final bool requireAuthenticationOnPause;
  final bool isDeviceSupported;

  const SettingsData({
    required this.username,
    required this.avatarUrl,
    required this.notificationsEnabled,
    required this.foregroundServiceEnabled,
    required this.localAuthEnabled,
    required this.requireAuthenticationOnPause,
    required this.isDeviceSupported,
  });

  SettingsData copyWith({
    String? username,
    String? avatarUrl,
    bool? notificationsEnabled,
    bool? foregroundServiceEnabled,
    bool? localAuthEnabled,
    bool? requireAuthenticationOnPause,
    bool? isDeviceSupported,
  }) {
    return SettingsData(
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      foregroundServiceEnabled: foregroundServiceEnabled ?? this.foregroundServiceEnabled,
      localAuthEnabled: localAuthEnabled ?? this.localAuthEnabled,
      requireAuthenticationOnPause: requireAuthenticationOnPause ?? this.requireAuthenticationOnPause,
      isDeviceSupported: isDeviceSupported ?? this.isDeviceSupported,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);
}

