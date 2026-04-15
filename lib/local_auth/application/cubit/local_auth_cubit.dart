import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/local_auth/domain/i_local_auth_repository.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

part 'local_auth_state.dart';
part 'local_auth_cubit.freezed.dart';

@Injectable()
class LocalAuthCubit extends Cubit<LocalAuthState> {
  final ILocalStorageRepository _localStorageRepository;
  final ILocalAuthRepository _localAuthRepository;
  LocalAuthCubit(this._localStorageRepository, this._localAuthRepository)
    : super(const LocalAuthState());

  void init() async {
    final localAuthEnabled = _localStorageRepository.getLocalAuthEnabled();
    final requireAuthenticationOnPause = _localStorageRepository
        .getRequireAuthenticationOnPause();
    final isDeviceSupported = await _localAuthRepository.isDeviceSupported();
    final hasPin = await _localStorageRepository.hasPin();
    emit(
      LocalAuthState(
        isEnabled: localAuthEnabled,
        requireAuthenticationOnPause: requireAuthenticationOnPause,
        isDeviceSupported: isDeviceSupported,
        hasPin: hasPin,
        status: LocalAuthStatus.data,
      ),
    );
  }

  Future<bool> authenticate({bool force = false}) async {
    if (!state.isEnabled && !force) return false;
    emit(state.copyWith(status: LocalAuthStatus.loading));
    final result = await _localAuthRepository.authenticate();
    if (result) {
      emit(state.copyWith(status: LocalAuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: LocalAuthStatus.unauthenticated));
    }
    await Future.delayed(
      Duration.zero,
      () => emit(state.copyWith(status: LocalAuthStatus.data)),
    );
    return result;
  }

  void setToUnauthenticated() {
    emit(state.copyWith(status: LocalAuthStatus.unauthenticated));
  }

  Future<bool> authenticateWithPin(String pin) async {
    if (!state.isEnabled || !state.hasPin) return false;
    emit(state.copyWith(status: LocalAuthStatus.loading));
    final result = await _localStorageRepository.verifyPin(pin);
    if (result) {
      emit(state.copyWith(status: LocalAuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: LocalAuthStatus.unauthenticated));
    }
    await Future.delayed(
      Duration.zero,
      () => emit(state.copyWith(status: LocalAuthStatus.data)),
    );
    return result;
  }

  void toggleLocalAuth(bool value) async {
    if (!state.isDeviceSupported) return;
    await _localStorageRepository.setLocalAuthEnabled(value);
    if (value == false) {
      await _localStorageRepository.setRequireAuthenticationOnPause(false);
      emit(state.copyWith(requireAuthenticationOnPause: false));
    }
    emit(state.copyWith(isEnabled: value));
  }

  void toggleRequireAuthenticationOnPause(bool value) async {
    if (!state.isEnabled) return;
    await _localStorageRepository.setRequireAuthenticationOnPause(value);
    emit(state.copyWith(requireAuthenticationOnPause: value));
  }

  void setPin(String pin) async {
    await _localStorageRepository.setPin(pin);
    emit(state.copyWith(hasPin: true));
  }
}
