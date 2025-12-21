import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

part 'tutorial_state.dart';

@Injectable()
class TutorialCubit extends Cubit<TutorialState> {
  final ILocalStorageRepository _localStorageRepository;

  TutorialCubit(this._localStorageRepository) : super(TutorialInitial());

  Future<void> completeTutorial() async {
    await _localStorageRepository.setTutorialCompleted(true);
    emit(TutorialCompleted());
  }
}

