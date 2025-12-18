import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/authentication/domain/user.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  final ILocalStorageRepository _localStorageRepository;
  final ITorRepository _torRepository;
  OnboardingCubit(this._localStorageRepository, this._torRepository)
    : super(OnboardingInitial());

  void createUser({required String username, required String avatarUrl}) async {
    final result = await _torRepository.getOnionAddress();
    result.fold((l) => emit(OnboardingError(l)), (r) async {
      await _localStorageRepository.setUser(
        User(username: username, onionAddress: r, avatarUrl: avatarUrl),
      );
      emit(OnboardingSuccess());
    });
  }
}
