import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_auth/domain/i_local_auth_repository.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

part 'tutorial_state.dart';

@Injectable()
class TutorialCubit extends Cubit<TutorialState> {
  final ILocalStorageRepository _localStorageRepository;
  final ILocalAuthRepository _localAuthRepository;

  TutorialCubit(
    this._localStorageRepository,
    this._localAuthRepository,
  ) : super(TutorialInitial());

  Future<void> checkLocalAuthAvailability() async {
    final isDeviceSupported = await _localAuthRepository.isDeviceSupported();
    final isAlreadyEnabled = _localStorageRepository.getLocalAuthEnabled();

    emit(TutorialShowLocalAuthDialog(
      canShowDialog: isDeviceSupported && !isAlreadyEnabled,
    ));
  }

  Future<void> completeTutorial() async {
    await _localStorageRepository.setTutorialCompleted(true);
    emit(TutorialCompleted());
  }
}

