import 'package:flick/authentication/domain/user.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  final ILocalStorageRepository _localStorageRepository;
  OnboardingCubit(this._localStorageRepository) : super(OnboardingInitial());

  void createUser(String username) async {
    await _localStorageRepository.setUser(User(username: username));
    emit(OnboardingSuccess());
  }
}
