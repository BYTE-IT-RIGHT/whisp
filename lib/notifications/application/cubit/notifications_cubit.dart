import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';

part 'notifications_state.dart';
part 'notifications_cubit.freezed.dart';

@Injectable()
class NotificationsCubit extends Cubit<NotificationsState> {
  final INotificationService _notificationService;
  final ILocalStorageRepository _localStorageRepository;
  NotificationsCubit(this._notificationService, this._localStorageRepository)
    : super(const NotificationsState());

  Future<void> init() async {
    final notificationsEnabled = _localStorageRepository
        .areNotificationsEnabled();
    final foregroundServiceEnabled = _localStorageRepository
        .isForegroundServiceEnabled();
    emit(
      NotificationsState(
        notificationsEnabled: notificationsEnabled,
        foregroundServiceEnabled: foregroundServiceEnabled,
      ),
    );
  }

  Future<void> toggleNotifications(bool enabled) async {
    if (enabled) {
      final granted = await _notificationService.requestPermissions();
      await _localStorageRepository.setNotificationsEnabled(granted);
      emit(state.copyWith(notificationsEnabled: granted));
    } else {
      await _localStorageRepository.setNotificationsEnabled(false);
      await _localStorageRepository.setForegroundServiceEnabled(false);
      emit(
        state.copyWith(
          notificationsEnabled: false,
          foregroundServiceEnabled: false,
        ),
      );
    }
  }

  Future<void> toggleForegroundService(bool enabled) async {
    await _localStorageRepository.setForegroundServiceEnabled(enabled);
    emit(state.copyWith(foregroundServiceEnabled: enabled));
  }
}
