import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'app_startup_state.dart';

@Injectable()
class AppStartupCubit extends Cubit<AppStartupState> {
  final ILocalStorageRepository _localStorageRepository;
  final ITorRepository _torRepository;
  AppStartupCubit(this._localStorageRepository, this._torRepository) : super(AppStartupInitial()){
    _init();
  }

  Future<void> _init()async {
    final x = await _torRepository.init();
    print('tutaj! $x');
    final result = _localStorageRepository.getUser();
    if (result != null) {
      emit(AppStartupAuthenticated());
    }else{
      emit(AppStartupUnauthenticated());
    }
  }
}
