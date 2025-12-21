import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

part 'settings_state.dart';

@Injectable()
class SettingsCubit extends Cubit<SettingsState> {
  final ILocalStorageRepository _localStorageRepository;

  SettingsCubit(this._localStorageRepository) : super(const SettingsInitial());

  void init() {
    emit(const SettingsLoading());

    final user = _localStorageRepository.getUser();
    if (user == null) {
      emit(const SettingsError('User not found'));
      return;
    }

    emit(SettingsData(
      username: user.username,
      avatarUrl: user.avatarUrl,
      notificationsEnabled: _localStorageRepository.areNotificationsEnabled(),
      foregroundServiceEnabled: _localStorageRepository.isForegroundServiceEnabled(),
    ));
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

    await _localStorageRepository.setNotificationsEnabled(enabled);
    emit(currentState.copyWith(notificationsEnabled: enabled));
  }

  Future<void> toggleForegroundService(bool enabled) async {
    final currentState = state;
    if (currentState is! SettingsData) return;

    await _localStorageRepository.setForegroundServiceEnabled(enabled);
    emit(currentState.copyWith(foregroundServiceEnabled: enabled));
  }
}

