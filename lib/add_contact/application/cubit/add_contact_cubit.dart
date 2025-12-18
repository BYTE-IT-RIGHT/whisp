import 'dart:async';

import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/add_contact/domain/i_add_contact_repository.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/contacts_library/domain/contact.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/messaging/domain/i_messages_repository.dart';
import 'package:flick/messaging/domain/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_contact_state.dart';

@Injectable()
class AddContactCubit extends Cubit<AddContactState> {
  final ILocalStorageRepository _localStorageRepository;
  final IMessagesRepository _messagesRepository;
  final IAddContactRepository _addContactRepository;
  final ITorRepository _torRepository;
  AddContactCubit(
    this._torRepository,
    this._messagesRepository,
    this._localStorageRepository,
    this._addContactRepository,
  ) : super(AddContactLoading());

  StreamSubscription<Message>? _messagesStream;

  void init() async {
    emit(AddContactLoading());

    final onionAddressResult = await _torRepository.getOnionAddress();
    onionAddressResult.fold(
      (failure) => emit(AddContactError(failure)),
      (onionAddress) => emit(AddContactData(onionAddress: onionAddress)),
    );
  }

  void addContact(String onionAddress) async {
    final result = await _addContactRepository.addContact(onionAddress);

    result.fold((l) => emit(AddContactError(l)), (r) {
      emit(AddContactWaiting());
      _messagesStream = _messagesRepository.incomingMessages.listen((event) {
        if (event.sender.onionAddress == onionAddress &&
            event.type == MessageType.contactAccepted) {
          _localStorageRepository.addContact(
            Contact(
              onionAddress: event.sender.onionAddress,
              username: event.sender.username,
            ),
          );
        }
      });
    });
  }

  @override
  Future<void> close() {
    _messagesStream?.cancel();
    return super.close();
  }
}
