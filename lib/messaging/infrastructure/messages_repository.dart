import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:whisp/common/constants/ports.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';
import 'package:whisp/encryption/domain/pre_key_bundle_dto.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/i_messages_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMessagesRepository)
class MessagesRepository implements IMessagesRepository {
  final ILocalStorageRepository _localStorageRepository;
  final ISignalService _signalService;
  final INotificationService _notificationService;

  MessagesRepository(
    this._localStorageRepository,
    this._signalService,
    this._notificationService,
  );

  HttpServer? _server;
  final StreamController<Message> _messageController =
      StreamController<Message>.broadcast();

  @override
  Future<Either<Failure, Unit>> startListener() async {
    try {
      if (_server != null) {
        log('Message listener already running on port ${Port.hiddenService}');
        return right(unit);
      }

      _server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        Port.hiddenService,
        shared: true,
      );

      log('Message listener started on port ${Port.hiddenService}');

      _server!.listen(
        _handleRequest,
        onError: (error) {
          log('Message listener error: $error');
        },
        onDone: () {
          log('Message listener stopped');
        },
      );

      return right(unit);
    } catch (e) {
      log('startListener error: $e');
      return left(MessageListenerError());
    }
  }

  Future<void> _handleRequest(HttpRequest request) async {
    request.response.headers.add('Access-Control-Allow-Origin', '*');
    request.response.headers.add('Content-Type', 'application/json');

    try {
      switch (request.uri.path) {
        case '/invite':
          await _handleInvite(request);
          break;
        case '/message':
          await _handleMessage(request);
          break;
        case '/ping':
          await _handlePing(request);
          break;
        default:
          await _handleNotFound(request);
      }
    } catch (e) {
      log('Error handling request: $e');
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.write(jsonEncode({'error': 'Internal server error'}));
      await request.response.close();
    }
  }

  Future<void> _handlePing(HttpRequest request) async {
    log('Received ping');
    final currentUser = _localStorageRepository.getUser()!;
    final pingMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: currentUser.toContact(),
      content: 'ping',
      timestamp: DateTime.now(),
      type: MessageType.ping,
    );
    _messageController.add(pingMessage);

    request.response.statusCode = HttpStatus.ok;
    request.response.write(
      jsonEncode({
        'status': 'pong',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      }),
    );
    await request.response.close();
  }

  /// Handle invitation requests (key exchange, no encryption yet)
  Future<void> _handleInvite(HttpRequest request) async {
    log('Received invitation');
    if (request.method != 'POST') {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.write(jsonEncode({'error': 'Method not allowed'}));
      await request.response.close();
      return;
    }

    try {
      final body = await utf8.decoder.bind(request).join();
      final json = jsonDecode(body) as Map<String, dynamic>;
      final message = Message.fromJson(json);

      // Invitations are not encrypted (key exchange happens here)
      final conversationId = message.sender.onionAddress;
      await _localStorageRepository.saveMessage(conversationId, message);

      // Emit the message to the stream for real-time UI updates
      _messageController.add(message);

      // Show notification for incoming invitation
      await _notificationService.showMessageNotification(message);

      request.response.statusCode = HttpStatus.ok;
      request.response.write(
        jsonEncode({
          'status': 'received',
          'messageId': message.id,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      );
      await request.response.close();
    } catch (e) {
      log('Error parsing invitation: $e');
      request.response.statusCode = HttpStatus.badRequest;
      request.response.write(jsonEncode({'error': 'Invalid message format'}));
      await request.response.close();
    }
  }

  /// Handle encrypted messages
  Future<void> _handleMessage(HttpRequest request) async {
    log('Received message');
    if (request.method != 'POST') {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.write(jsonEncode({'error': 'Method not allowed'}));
      await request.response.close();
      return;
    }

    try {
      final body = await utf8.decoder.bind(request).join();
      final json = jsonDecode(body) as Map<String, dynamic>;
      final message = Message.fromJson(json);

      final conversationId = message.sender.onionAddress;
      Message processedMessage = message;

      // Handle different message types
      if (message.type == MessageType.text && message.encryptedData != null) {
        // Decrypt encrypted text messages
        final decryptResult = await _signalService.decryptMessage(
          senderOnionAddress: message.sender.onionAddress,
          encryptedData: message.encryptedData!,
        );

        processedMessage = decryptResult.fold(
          (failure) {
            log('Failed to decrypt message: $failure');
            // Store with error indicator if decryption fails
            return message.copyWithDecryptedContent('[Decryption failed]');
          },
          (plaintext) {
            log('Message decrypted successfully');
            return message.copyWithDecryptedContent(plaintext);
          },
        );
      } else if (message.type == MessageType.contactAccepted) {
        // Handle contact accepted - establish session with their PreKeyBundle
        final senderPreKeyBundle = message.sender.preKeyBundleBase64;
        if (senderPreKeyBundle != null) {
          log('Establishing session with accepted contact');
          final preKeyBundle = PreKeyBundleDto.fromBase64(senderPreKeyBundle);
          await _signalService.establishSession(
            remoteOnionAddress: message.sender.onionAddress,
            remotePreKeyBundle: preKeyBundle,
          );

          // Add contact to our contact list
          await _localStorageRepository.addContact(message.sender);
        }
        processedMessage = message;
      }
      // contactRequest, contactDeclined, ping - pass through as-is
      await Future.wait([
        // Update contact profile (username, avatar) if they changed
        _localStorageRepository.addContact(message.sender),
        // Save processed message to database
        _localStorageRepository.saveMessage(conversationId, processedMessage),
        // Show notification for incoming message
        _notificationService.showMessageNotification(processedMessage),
      ]);
      // Emit the message to the stream for real-time UI updates
      _messageController.add(processedMessage);

      request.response.statusCode = HttpStatus.ok;
      request.response.write(
        jsonEncode({
          'status': 'received',
          'messageId': message.id,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      );
      await request.response.close();
    } catch (e) {
      log('Error parsing message: $e');
      request.response.statusCode = HttpStatus.badRequest;
      request.response.write(jsonEncode({'error': 'Invalid message format'}));
      await request.response.close();
    }
  }

  Future<void> _handleNotFound(HttpRequest request) async {
    request.response.statusCode = HttpStatus.notFound;
    request.response.write(jsonEncode({'error': 'Not found'}));
    await request.response.close();
  }

  @override
  Future<Either<Failure, Unit>> stopListener() async {
    try {
      if (_server == null) {
        return right(unit);
      }

      await _server!.close(force: true);
      _server = null;

      return right(unit);
    } catch (e) {
      log('Error stopping message listener: $e');
      return left(MessageListenerError());
    }
  }

  @override
  Stream<Message> get incomingMessages => _messageController.stream;

  @override
  bool get isRunning => _server != null;
}
