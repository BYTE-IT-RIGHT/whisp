import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

part 'user_settings_state.dart';

@Injectable()
class UserSettingsCubit extends Cubit<UserSettingsState> {
  final ILocalStorageRepository _localStorageRepository;

  UserSettingsCubit(this._localStorageRepository)
    : super(const UserSettingsInitial());

  Future<void> init() async {
    final user = _localStorageRepository.getUser();

    emit(UserSettingsData(username: user!.username, avatarUrl: user.avatarUrl));
  }

  Future<void> updateUsername(String username) async {
    if (state is UserSettingsData) {
      final s = state as UserSettingsData;
      await _localStorageRepository.updateUserProfile(username: username);
      emit(s.copyWith(username: username));
    }
  }

  Future<void> updateAvatar(String avatarUrl) async {
    if (state is UserSettingsData) {
      final s = state as UserSettingsData;
      await _localStorageRepository.updateUserProfile(avatarUrl: avatarUrl);
      emit(s.copyWith(avatarUrl: avatarUrl));
    }
  }
}
