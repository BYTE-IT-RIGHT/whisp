import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/authentication/domain/user.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  final ILocalStorageRepository _localStorageRepository;
  final ITorRepository _torRepository;
  final ISignalService _signalService;

  OnboardingCubit(
    this._localStorageRepository,
    this._torRepository,
    this._signalService,
  ) : super(OnboardingInitial());

  void createUser({required String username, required String avatarUrl}) async {
    emit(OnboardingLoading());
    
    final onionResult = await _torRepository.getOnionAddress();
    
    await onionResult.fold(
      (failure) async => emit(OnboardingError(failure)),
      (onionAddress) async {
        final signalResult = await _signalService.generateKeys();
        
        await signalResult.fold(
          (failure) async => emit(OnboardingError(failure)),
          (signalKeyData) async {
            final user = User(
              username: username,
              onionAddress: onionAddress,
              avatarUrl: avatarUrl,
              registrationId: signalKeyData.registrationId,
              identityKeyPairBase64: signalKeyData.identityKeyPairBase64,
              identityKeyBase64: signalKeyData.identityKeyBase64,
            );
            
            await _localStorageRepository.setUser(user);
            emit(OnboardingSuccess());
          },
        );
      },
    );
  }
}
