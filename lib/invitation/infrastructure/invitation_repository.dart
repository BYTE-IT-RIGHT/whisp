import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/invitation/domain/i_invitation_repository.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IInvitationRepository)
class InvitationRepository implements IInvitationRepository {
  final ITorRepository _torRepository;
  final ILocalStorageRepository _localStorageRepository;

  InvitationRepository(this._torRepository, this._localStorageRepository);

  @override
  Future<Either<Failure, Unit>> sendInvitationResponse(
    String onionAddress, {
    required bool accepted,
  }) async {
    try {
      final currentUser = _localStorageRepository.getUser()!;

      final message = Message(
        id: const Uuid().v4(),
        sender: currentUser.toContact(),
        content: accepted ? 'Invitation accepted' : 'Invitation declined',
        timestamp: DateTime.now(),
        type: accepted ? MessageType.contactAccepted : MessageType.contactDeclined,
      );

      final result = await _torRepository.post(
        'http://$onionAddress/message',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message.toJson()),
      );

      return result.fold(
        (failure) {
          log('sendInvitationResponse error: $failure');
          return left(failure);
        },
        (response) {
          if (response.statusCode == 200) {
            return right(unit);
          } else {
            log('sendInvitationResponse failed with status: ${response.statusCode}');
            return left(MessageSendError());
          }
        },
      );
    } catch (e) {
      log('sendInvitationResponse unexpected error: $e');
      return left(UnexpectedError());
    }
  }
}

