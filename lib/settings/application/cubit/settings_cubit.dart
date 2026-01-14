import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';

part 'settings_state.dart';

@Injectable()
class SettingsCubit extends Cubit<SettingsState> {
  final ILocalStorageRepository _localStorageRepository;
  final INotificationService _notificationService;

  SettingsCubit(this._localStorageRepository, this._notificationService)
    : super(const SettingsInitial());

  Future<void> init() async {
    emit(const SettingsLoading());

    final user = _localStorageRepository.getUser();
    if (user == null) {
      emit(const SettingsError('User not found'));
      return;
    }

    emit(
      SettingsData(
        username: user.username,
        avatarUrl: user.avatarUrl,
        notificationsEnabled: _localStorageRepository.areNotificationsEnabled(),
        foregroundServiceEnabled: _localStorageRepository
            .isForegroundServiceEnabled(),
      ),
    );
  }

  Future<void> updateUsername(String username) async {
    final currentState = state;
    if (currentState is! SettingsData) return;

    await _localStorageRepository.updateUserProfile(username: username);
    emit(currentState.copyWith(username: username));
  }

  Future<void> updateAvatar(String avatarUrl) async {
    final currentState = state;
    if (currentState is! SettingsData) return;

    await _localStorageRepository.updateUserProfile(avatarUrl: avatarUrl);
    emit(currentState.copyWith(avatarUrl: avatarUrl));
  }

  Future<void> toggleNotifications(bool enabled) async {
    final currentState = state;
    if (currentState is! SettingsData) return;

    if (enabled) {
      // Request permission and check if actually granted
      final granted = await _notificationService.requestPermissions();
      await _localStorageRepository.setNotificationsEnabled(granted);
      emit(currentState.copyWith(notificationsEnabled: granted));
    } else {
      // When disabling notifications, also disable foreground service
      await _localStorageRepository.setNotificationsEnabled(false);
      await _localStorageRepository.setForegroundServiceEnabled(false);
      emit(
        currentState.copyWith(
          notificationsEnabled: false,
          foregroundServiceEnabled: false,
        ),
      );
    }
  }

  Future<void> toggleForegroundService(bool enabled) async {
    final currentState = state;
    if (currentState is! SettingsData) return;

    await _localStorageRepository.setForegroundServiceEnabled(enabled);
    emit(currentState.copyWith(foregroundServiceEnabled: enabled));
  }
}
