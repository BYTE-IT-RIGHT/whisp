import 'dart:async';
import 'dart:developer';

import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/i_messages_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:whisp/invitation/domain/i_invitation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'invitation_state.dart';

@lazySingleton
class InvitationCubit extends Cubit<InvitationState> {
  final IMessagesRepository _messagesRepository;
  final IInvitationRepository _invitationRepository;
  final ILocalStorageRepository _localStorageRepository;

  StreamSubscription<Message>? _messageSubscription;

  InvitationCubit(
    this._messagesRepository,
    this._invitationRepository,
    this._localStorageRepository,
  ) : super(InvitationInitial());

  void init() {
    _messageSubscription = _messagesRepository.incomingMessages.listen((
      message,
    ) {
      if (message.type == MessageType.contactRequest) {
        log('Received contact request from ${message.sender.username}');
        emit(InvitationPending(invitation: message));
      }
    });
  }

  Future<void> acceptInvitation(Message invitation) async {
    emit(InvitationAccepting(invitation: invitation));

    final result = await _invitationRepository.sendInvitationResponse(
      invitation.sender.onionAddress,
      accepted: true,
    );

    result.fold(
      (failure) {
        log('Failed to send invitation response: $failure');
        emit(InvitationError(message: 'Failed to send response'));
      },
      (_) async {
        await _localStorageRepository.addContact(invitation.sender);
        emit(InvitationAccepted(invitation: invitation));

        emit(InvitationInitial());
      },
    );
  }

  Future<void> declineInvitation(Message invitation) async {
    final result = await _invitationRepository.sendInvitationResponse(
      invitation.sender.onionAddress,
      accepted: false,
    );

    result.fold(
      (failure) {
        log('Failed to send decline response: $failure');
        emit(InvitationError(message: 'Failed to send decline response'));
      },
      (_) {
        emit(InvitationDeclined(invitation: invitation));
        emit(InvitationInitial());
      },
    );
  }

  void dismissCurrentInvitation() {
    emit(InvitationInitial());
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
