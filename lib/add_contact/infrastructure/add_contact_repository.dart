import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/add_contact/domain/i_add_contact_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IAddContactRepository)
class AddContactRepository implements IAddContactRepository {
  final ITorRepository _torRepository;
  final ILocalStorageRepository _localStorageRepository;
  final ISignalService _signalService;

  AddContactRepository(
    this._torRepository,
    this._localStorageRepository,
    this._signalService,
  );

  @override
  Future<Either<Failure, Unit>> addContact(String onionAddress) async {
    try {
      final currentUser = _localStorageRepository.getUser();
      if (currentUser == null) {
        return left(UnexpectedError());
      }

      // Get our PreKeyBundle to send with the invitation
      final preKeyBundleResult = await _signalService.getPreKeyBundle();
      
      return await preKeyBundleResult.fold(
        (failure) async => left(failure),
        (preKeyBundle) async {
          // Create sender contact with identity key and pre key bundle
          final senderContact = Contact(
            onionAddress: currentUser.onionAddress,
            username: currentUser.username,
            avatarUrl: currentUser.avatarUrl,
            identityKeyBase64: currentUser.identityKeyBase64,
            preKeyBundleBase64: preKeyBundle.toBase64(),
          );

          final message = Message(
            id: const Uuid().v4(),
            sender: senderContact,
            content: 'Invitation sent',
            timestamp: DateTime.now(),
            type: MessageType.contactRequest,
          );

          final result = await _torRepository.post(
            'http://$onionAddress/invite',
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(message.toJson()),
          );

          return result.fold(
            (l) => left(l),
            (r) async {
              if (r.statusCode == 200) {
                await _localStorageRepository.saveMessage(onionAddress, message);
                return right(unit);
              } else {
                return left(TorConnectionError());
              }
            },
          );
        },
      );
    } catch (e) {
      log('addContact unexpected error: $e');
      return left(UnexpectedError());
    }
  }
}
