import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/chat/domain/i_chat_repository.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IChatRepository)
class ChatRepository implements IChatRepository {
  final ITorRepository _torRepository;
  final ILocalStorageRepository _localStorageRepository;

  ChatRepository(this._torRepository, this._localStorageRepository);

  @override
  Future<Either<Failure, Unit>> sendMessage({
    required String recipientOnionAddress,
    required String content,
  }) async {
    try {
      final currentUser = _localStorageRepository.getUser();
      if (currentUser == null) {
        return left(UnexpectedError());
      }

      final message = Message(
        id: const Uuid().v4(),
        sender: currentUser.toContact(),
        content: content,
        timestamp: DateTime.now(),
        type: MessageType.text,
      );

      final result = await _torRepository.post(
        'http://$recipientOnionAddress/message',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message.toJson()),
      );

      return result.fold(
        (failure) {
          log('sendMessage error: $failure');
          return left(failure);
        },
        (response) async {
          if (response.statusCode == 200) {
            // Save sent message locally
            await _localStorageRepository.saveMessage(
              recipientOnionAddress,
              message,
            );
            return right(unit);
          } else {
            log('sendMessage failed with status: ${response.statusCode}');
            return left(MessageSendError());
          }
        },
      );
    } catch (e, st) {
      log('sendMessage unexpected error: $e\n$st');
      return left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, MessagePage>> getMessages(
    String conversationId, {
    int limit = 20,
    DateTime? before,
  }) async {
    try {
      final page = await _localStorageRepository.getMessages(
        conversationId,
        limit: limit,
        before: before,
      );
      return right(page);
    } catch (e, st) {
      log('getMessages error: $e\n$st');
      return left(UnexpectedError());
    }
  }

  @override
  Stream<List<Message>> watchMessages(String conversationId) {
    return _localStorageRepository.watchMessages(conversationId);
  }
}

