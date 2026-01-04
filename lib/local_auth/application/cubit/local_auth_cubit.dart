import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_auth/domain/i_local_auth_repository.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

part 'local_auth_state.dart';

@Injectable()
class LocalAuthCubit extends Cubit<LocalAuthState> {
  final ILocalStorageRepository _localStorageRepository;
  final ILocalAuthRepository _localAuthRepository;
  LocalAuthCubit(this._localStorageRepository, this._localAuthRepository)
    : super(LocalAuthInitial());

  void init() async {
    final isEnabled = _localStorageRepository.getLocalAuthEnabled();
    final hasPin = await _localStorageRepository.hasPin();

    if (!isEnabled) {
      emit(
        LocalAuthData(
          isEnabled: isEnabled,
          requireAuthenticationOnPause: false,
          isDeviceSupported: false,
          hasPin: hasPin,
        ),
      );
      return;
    }

    final requireAuthenticationOnPause = _localStorageRepository
        .getRequireAuthenticationOnPause();
    final isDeviceSupported = await _localAuthRepository.isDeviceSupported();
    emit(
      LocalAuthData(
        isEnabled: isEnabled,
        requireAuthenticationOnPause: requireAuthenticationOnPause,
        isDeviceSupported: isDeviceSupported,
        hasPin: hasPin,
      ),
    );
  }

  Future<void> authenticateWithPin(String pin) async {
    if (state is LocalAuthData) {
      final isValid = await _localStorageRepository.verifyPin(pin);
      if (isValid) {
        emit(LocalAuthAuthenticated());
      } else {
        emit(state);
      }
    }
  }

  Future<void> authenticateWithBiometric() async {
    if (state is LocalAuthData) {
      final authenticated = await _localAuthRepository.authenticate();
      if (authenticated) {
        emit(LocalAuthAuthenticated());
      } else {
        emit(state);
      }
    }
  }

  Future<bool> setPin(String pin) async {
    await _localStorageRepository.setPin(pin);
    return true;
  }

  Future<bool> enableLocalAuth(String pin) async {
    await _localStorageRepository.setPin(pin);

    final authenticated = await _localAuthRepository.authenticate();
    if (authenticated) {
      await _localStorageRepository.setLocalAuthEnabled(true);
      await _localStorageRepository.setRequireAuthenticationOnPause(true);

      final isDeviceSupported = await _localAuthRepository.isDeviceSupported();
      final hasPin = await _localStorageRepository.hasPin();
      emit(
        LocalAuthData(
          isEnabled: true,
          requireAuthenticationOnPause: true,
          isDeviceSupported: isDeviceSupported,
          hasPin: hasPin,
        ),
      );
      return true;
    }
    return false;
  }
}
