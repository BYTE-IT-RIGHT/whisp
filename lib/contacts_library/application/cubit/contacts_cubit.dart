import 'dart:async';

import 'package:flick/contacts_library/domain/contact.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'contacts_state.dart';

@Injectable()
class ContactsCubit extends Cubit<ContactsState> {
  final ILocalStorageRepository _localStorageRepository;
  StreamSubscription<List<Contact>>? _subscription;

  ContactsCubit(this._localStorageRepository)
    : super(ContactsData(contacts: []));

  void init() {
    _subscription = _localStorageRepository.watchContacts().listen((contacts) {
      emit(ContactsData(contacts: contacts));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
