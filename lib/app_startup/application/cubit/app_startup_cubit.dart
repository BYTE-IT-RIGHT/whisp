import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'app_startup_state.dart';

@Injectable()
class AppStartupCubit extends Cubit<AppStartupState> {
  final ILocalStorageRepository _localStorageRepository;
  AppStartupCubit(this._localStorageRepository) : super(AppStartupInitial()){
    _init();
  }

  Future<void> _init()async {
    await Future.delayed(Duration.zero);
    final result = _localStorageRepository.getUser();
    if (result != null) {
      emit(AppStartupAuthenticated());
    }else{
      emit(AppStartupUnauthenticated());
    }
  }
}
