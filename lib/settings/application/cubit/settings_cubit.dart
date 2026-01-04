import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_auth/domain/i_local_auth_repository.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';

part 'settings_state.dart';

@Injectable()
class SettingsCubit extends Cubit<SettingsState> {
  final ILocalStorageRepository _localStorageRepository;
  final ILocalAuthRepository _localAuthRepository;
  final INotificationService _notificationService;

  SettingsCubit(
    this._localStorageRepository,
    this._localAuthRepository,
    this._notificationService,
  ) : super(const SettingsInitial());

  Future<void> init() async {
    emit(const SettingsLoading());

    final user = _localStorageRepository.getUser();
    if (user == null) {
      emit(const SettingsError('User not found'));
      return;
    }

    final localAuthEnabled = _localStorageRepository.getLocalAuthEnabled();
    final requireAuthenticationOnPause = _localStorageRepository
        .getRequireAuthenticationOnPause();
    final isDeviceSupported = await _localAuthRepository.isDeviceSupported();

    emit(
      SettingsData(
        username: user.username,
        avatarUrl: user.avatarUrl,
        notificationsEnabled: _localStorageRepository.areNotificationsEnabled(),
        foregroundServiceEnabled: _localStorageRepository
            .isForegroundServiceEnabled(),
        localAuthEnabled: localAuthEnabled,
        requireAuthenticationOnPause: requireAuthenticationOnPause,
        isDeviceSupported: isDeviceSupported,
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

  Future<void> toggleLocalAuth(bool enabled) async {
    final currentState = state;
    if (currentState is! SettingsData) return;

    if (enabled) {
      return;
    } else {
      await _localStorageRepository.setLocalAuthEnabled(false);
      emit(currentState.copyWith(localAuthEnabled: false));
    }
  }

  Future<bool> disableLocalAuthWithPin(String pin) async {
    final isValid = await _localStorageRepository.verifyPin(pin);
    if (isValid) {
      await _localStorageRepository.setLocalAuthEnabled(false);
      final currentState = state;
      if (currentState is SettingsData) {
        emit(
          currentState.copyWith(
            localAuthEnabled: false,
            requireAuthenticationOnPause: false,
          ),
        );
      }
      return true;
    }
    return false;
  }

  Future<void> toggleRequireAuthenticationOnPause(bool enabled) async {
    final currentState = state;
    if (currentState is! SettingsData || !currentState.localAuthEnabled) return;
    await _localStorageRepository.setRequireAuthenticationOnPause(enabled);
    emit(currentState.copyWith(requireAuthenticationOnPause: enabled));
  }
}
