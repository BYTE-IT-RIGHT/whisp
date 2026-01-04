import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_auth/domain/i_local_auth_repository.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';

part 'tutorial_state.dart';

@Injectable()
class TutorialCubit extends Cubit<TutorialState> {
  final ILocalStorageRepository _localStorageRepository;
  final ILocalAuthRepository _localAuthRepository;
  final INotificationService _notificationService;

  TutorialCubit(
    this._localStorageRepository,
    this._localAuthRepository,
    this._notificationService,
  ) : super(TutorialInitial());

  Future<void> requestNotificationPermission() async {
    final granted = await _notificationService.requestPermissions();
    await _localStorageRepository.setNotificationsEnabled(granted);
  }

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

