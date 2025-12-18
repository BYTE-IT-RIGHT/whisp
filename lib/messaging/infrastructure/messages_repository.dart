import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flick/common/constants/ports.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/messaging/domain/i_messages_repository.dart';
import 'package:flick/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMessagesRepository)
class MessagesRepository implements IMessagesRepository {
  final ILocalStorageRepository _localStorageRepository;
  MessagesRepository(this._localStorageRepository);

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
    } catch (e, st) {
      log('startListener error: $e\n$st');
      return left(MessageListenerError());
    }
  }

  Future<void> _handleRequest(HttpRequest request) async {
    request.response.headers.add('Access-Control-Allow-Origin', '*');
    request.response.headers.add('Content-Type', 'application/json');

    try {
      switch (request.uri.path) {
        case '/invite':
        case '/message':
          await _handleMessage(request);
          break;
        case '/ping':
          await _handlePing(request);
          break;
        default:
          await _handleNotFound(request);
      }
    } catch (e, st) {
      log('Error handling request: $e\n$st');
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

      // Save message to database - conversation ID is sender's onion address
      final conversationId = message.sender.onionAddress;
      await _localStorageRepository.saveMessage(conversationId, message);

      // Emit the message to the stream for real-time UI updates
      _messageController.add(message);

      request.response.statusCode = HttpStatus.ok;
      request.response.write(
        jsonEncode({
          'status': 'received',
          'messageId': message.id,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      );
      await request.response.close();
    } catch (e, st) {
      log('📨 Error parsing message: $e\n$st');
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
    } catch (e, st) {
      log('📨 Error stopping message listener: $e\n$st');
      return left(MessageListenerError());
    }
  }

  @override
  Stream<Message> get incomingMessages => _messageController.stream;

  @override
  bool get isRunning => _server != null;
}
