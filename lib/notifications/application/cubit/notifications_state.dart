part of 'notifications_cubit.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(false) bool notificationsEnabled,
    @Default(false) bool foregroundServiceEnabled,
  }) = _NotificationsState;
}
