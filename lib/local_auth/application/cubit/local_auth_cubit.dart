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

  Future<bool> authenticateWithPin(String pin) async {
    emit(LocalAuthAuthenticating());
    
    final isValid = await _localStorageRepository.verifyPin(pin);
    if (isValid) {
      emit(LocalAuthAuthenticated());
      return true;
    } else {
      emit(LocalAuthError('Incorrect PIN. Please try again.'));
      return false;
    }
  }

  Future<bool> authenticateWithBiometric() async {
    emit(LocalAuthAuthenticating());
    
    final authenticated = await _localAuthRepository.authenticate();
    if (authenticated) {
      emit(LocalAuthAuthenticated());
      return true;
    } else {
      emit(LocalAuthError('Authentication failed. Please try again.'));
      return false;
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
