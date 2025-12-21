import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/chat/domain/i_chat_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IChatRepository)
class ChatRepository implements IChatRepository {
  final ITorRepository _torRepository;
  final ILocalStorageRepository _localStorageRepository;
  final ISignalService _signalService;

  ChatRepository(
    this._torRepository,
    this._localStorageRepository,
    this._signalService,
  );

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

      // Check if we have an established session
      final hasSession = await _signalService.hasSession(recipientOnionAddress);
      if (!hasSession) {
        log('No session established with $recipientOnionAddress');
        return left(SessionNotEstablishedError(recipientOnionAddress));
      }

      // Encrypt the message content
      final encryptResult = await _signalService.encryptMessage(
        recipientOnionAddress: recipientOnionAddress,
        plaintext: content,
      );

      return await encryptResult.fold(
        (failure) async {
          log('Failed to encrypt message: $failure');
          return left(failure);
        },
        (encryptedData) async {
          // Create message with encrypted content for transmission
          final message = Message(
            id: const Uuid().v4(),
            sender: currentUser.toContact(),
            content: '', // Don't send plaintext
            timestamp: DateTime.now(),
            type: MessageType.text,
            encryptedData: encryptedData,
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
                // Save the unencrypted message locally for display
                final localMessage = Message(
                  id: message.id,
                  sender: message.sender,
                  content: content, // Store plaintext locally
                  timestamp: message.timestamp,
                  type: MessageType.text,
                );
                await _localStorageRepository.saveMessage(
                  recipientOnionAddress,
                  localMessage,
                );
                return right(unit);
              } else {
                log('sendMessage failed with status: ${response.statusCode}');
                return left(MessageSendError());
              }
            },
          );
        },
      );
    } catch (e) {
      log('sendMessage unexpected error: $e');
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
    } catch (e) {
      log('getMessages error: $e');
      return left(UnexpectedError());
    }
  }

  @override
  Stream<List<Message>> watchMessages(String conversationId) {
    return _localStorageRepository.watchMessages(conversationId);
  }

  @override
  Future<Either<Failure, bool>> pingUser(String recipientOnionAddress) async {
    try {
      final result = await _torRepository.post(
        'http://$recipientOnionAddress/ping',
        headers: {'Content-Type': 'application/json'},
      );

      return result.fold(
        (failure) {
          log('pingUser error: $failure');
          return right(false); // User is offline
        },
        (response) {
          if (response.statusCode == 200) {
            return right(true); // User is online
          }
          return right(false);
        },
      );
    } catch (e) {
      log('pingUser unexpected error: $e');
      return right(false);
    }
  }
}
