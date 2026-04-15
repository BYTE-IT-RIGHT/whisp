import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

part 'user_settings_state.dart';
part 'user_settings_cubit.freezed.dart';

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
    final currentState = state.maybeMap(data: (s) => s, orElse: () => null);
    if (currentState == null) return;

    await _localStorageRepository.updateUserProfile(username: username);
    emit(currentState.copyWith(username: username));
  }

  Future<void> updateAvatar(String avatarUrl) async {
    final currentState = state.maybeMap(data: (s) => s, orElse: () => null);
    if (currentState == null) return;

    await _localStorageRepository.updateUserProfile(avatarUrl: avatarUrl);
    emit(currentState.copyWith(avatarUrl: avatarUrl));
  }
}
