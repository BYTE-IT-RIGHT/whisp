import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_contact_state.dart';

@Injectable()
class AddContactCubit extends Cubit<AddContactState> {
  final ITorRepository _torRepository;
  AddContactCubit(this._torRepository) : super(AddContactLoading());

  void init() async {
    emit(AddContactLoading());

    final onionAddressResult = await _torRepository.getOnionAddress();
    onionAddressResult.fold(
      (failure) => emit(AddContactError(failure)),
      (onionAddress) => emit(AddContactData(onionAddress: onionAddress)),
    );
  }
}
