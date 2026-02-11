part of 'notifications_cubit.dart';

@immutable
final class NotificationsState {
  final bool notificationsEnabled;
  final bool foregroundServiceEnabled;

  const NotificationsState({
    this.notificationsEnabled = false,
    this.foregroundServiceEnabled = false,
  });

  NotificationsState copyWith({
    bool? notificationsEnabled,
    bool? foregroundServiceEnabled,
  }) {
    return NotificationsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      foregroundServiceEnabled:
          foregroundServiceEnabled ?? this.foregroundServiceEnabled,
    );
  }
}
