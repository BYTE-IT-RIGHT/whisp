import 'dart:async';

import 'package:whisp/add_contact/domain/i_add_contact_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/i_messages_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_contact_state.dart';

@Injectable()
class AddContactCubit extends Cubit<AddContactState> {
  final ILocalStorageRepository _localStorageRepository;
  final IMessagesRepository _messagesRepository;
  final IAddContactRepository _addContactRepository;
  AddContactCubit(
    this._messagesRepository,
    this._localStorageRepository,
    this._addContactRepository,
  ) : super(AddContactLoading());

  StreamSubscription<Message>? _messagesStream;

  void init() async {
    emit(AddContactLoading());

    final user = _localStorageRepository.getUser()!;
    emit(AddContactData(onionAddress: user.onionAddress));
  }

  void addContact(String onionAddress) async {
    // Emit waiting immediately so the user sees "invitation pending" right away
    emit(AddContactWaiting(onionAddress: onionAddress));

    final result = await _addContactRepository.addContact(onionAddress);

    result.fold((l) => emit(AddContactError(l, onionAddress: onionAddress)), (r) {
      _messagesStream = _messagesRepository.incomingMessages.listen((event) {
        if (event.sender.onionAddress != onionAddress) return;

        switch (event.type) {
          case MessageType.contactAccepted:
            // Contact is already added by MessagesRepository when receiving the message
            emit(AddContactSuccess(username: event.sender.username));
            _messagesStream?.cancel();
            break;
          case MessageType.contactDeclined:
            emit(AddContactDeclined(onionAddress: onionAddress));
            _messagesStream?.cancel();
            break;
          default:
            break;
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
