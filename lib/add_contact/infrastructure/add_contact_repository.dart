import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/add_contact/domain/i_add_contact_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IAddContactRepository)
class AddContactRepository implements IAddContactRepository {
  final ITorRepository _torRepository;
  final ILocalStorageRepository _localStorageRepository;
  AddContactRepository(this._torRepository, this._localStorageRepository);

  @override
  Future<Either<Failure, Unit>> addContact(String onionAddress) async {
    try {
      final currentUser = _localStorageRepository.getUser();
      final result = await _torRepository.post(
        'http://$onionAddress/invite',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          Message(
            id: Uuid().v4(),
            sender: Contact(
              onionAddress: currentUser!.onionAddress,
              username: currentUser.username,
              avatarUrl: currentUser.avatarUrl,
            ),
            content: '',
            timestamp: DateTime.now(),
            type: MessageType.contactRequest,
          ).toJson(),
        ),
      );
      return result.fold((l) => left(l), (r) {
        if (r.statusCode == 200) {
          return right(unit);
        } else {
          return left(TorConnectionError());
        }
      });
    } catch (e) {
      log('addContact unexpected error: $e');
      return left(UnexpectedError());
    }
  }
}
