import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';
import 'package:whisp/encryption/domain/pre_key_bundle_dto.dart';
import 'package:whisp/invitation/domain/i_invitation_repository.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IInvitationRepository)
class InvitationRepository implements IInvitationRepository {
  final ITorRepository _torRepository;
  final ILocalStorageRepository _localStorageRepository;
  final ISignalService _signalService;

  InvitationRepository(
    this._torRepository,
    this._localStorageRepository,
    this._signalService,
  );

  @override
  Future<Either<Failure, Unit>> sendInvitationResponse(
    String onionAddress, {
    required bool accepted,
    String? remotePreKeyBundleBase64,
  }) async {
    try {
      final currentUser = _localStorageRepository.getUser()!;

      // If accepting, establish session with the inviter's PreKeyBundle
      if (accepted && remotePreKeyBundleBase64 != null) {
        final remoteBundle = PreKeyBundleDto.fromBase64(remotePreKeyBundleBase64);
        final sessionResult = await _signalService.establishSession(
          remoteOnionAddress: onionAddress,
          remotePreKeyBundle: remoteBundle,
        );
        
        if (sessionResult.isLeft()) {
          log('Failed to establish session with inviter');
          return sessionResult;
        }
      }

      // Get our PreKeyBundle to send back
      final preKeyBundleResult = await _signalService.getPreKeyBundle();
      
      return await preKeyBundleResult.fold(
        (failure) async => left(failure),
        (preKeyBundle) async {
          // Create sender contact with our PreKeyBundle
          final senderContact = Contact(
            onionAddress: currentUser.onionAddress,
            username: currentUser.username,
            avatarUrl: currentUser.avatarUrl,
            identityKeyBase64: currentUser.identityKeyBase64,
            preKeyBundleBase64: accepted ? preKeyBundle.toBase64() : null,
          );

          final message = Message(
            id: const Uuid().v4(),
            sender: senderContact,
            content: accepted ? 'Invitation accepted' : 'Invitation declined',
            timestamp: DateTime.now(),
            type: accepted
                ? MessageType.contactAccepted
                : MessageType.contactDeclined,
          );

          final result = await _torRepository.post(
            'http://$onionAddress/message',
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(message.toJson()),
          );

          await _localStorageRepository.saveMessage(onionAddress, message);

          return result.fold(
            (failure) {
              log('sendInvitationResponse error: $failure');
              return left(failure);
            },
            (response) {
              if (response.statusCode == 200) {
                return right(unit);
              } else {
                log(
                  'sendInvitationResponse failed with status: ${response.statusCode}',
                );
                return left(MessageSendError());
              }
            },
          );
        },
      );
    } catch (e) {
      log('sendInvitationResponse unexpected error: $e');
      return left(UnexpectedError());
    }
  }
}
