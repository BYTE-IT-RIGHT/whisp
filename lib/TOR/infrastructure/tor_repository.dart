import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/common/domain/failure.dart';

class TorRepository implements ITorRepository {
  String? _onionAddress;
  bool _initialized = false;
  Socket? _controlSocket;

  /// Inicjalizacja repozytorium
  @override
  Future<Either<Failure, Unit>> init() async {
    try {
      if (_initialized) return right(unit);

      // 1️⃣ Sprawdzenie, czy Tor działa
      final isRunning = await _isTorRunning();
      if (!isRunning) {
        return left(TorNotRunningError());
      }

      // 2️⃣ Połączenie do ControlPort (opcjonalnie)
      // TODO: implementacja ControlPort
      // _controlSocket = await Socket.connect('127.0.0.1', 9051);

      // 3️⃣ Pobranie lub utworzenie hidden service
      _onionAddress = await _fetchOrCreateOnion();

      _initialized = true;
      return right(unit);
    } catch (e, st) {
      log('TOR repository init unexpected error: $e\n$st');
      return left(TorNotRunningError());
    }
  }

  /// Sprawdzenie, czy Tor działa
  Future<bool> _isTorRunning() async {
    try {
      final socket = await Socket.connect(
        '127.0.0.1',
        9050,
        timeout: Duration(seconds: 2),
      );
      socket.destroy();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Zwraca `.onion` użytkownika
  @override
  Future<Either<Failure, String>> getOnionAddress() async {
    if (!_initialized) {
      final initResult = await init();
      if (initResult.isLeft()) {
        return left(initResult.swap().getOrElse(() => TorNotRunningError()));
      }
    }

    if (_onionAddress == null) {
      return left(TorNotRunningError());
    }

    return right(_onionAddress!);
  }

  @override
  Future<Either<Failure, Unit>> dispose() async {
    try {
      await _controlSocket?.close();
      _controlSocket = null;
      _initialized = false;
      return right(unit);
    } catch (e) {
      log('Error disposing TorRepository: $e');
      return left(UnexpectedError());
    }
  }

  Future<String> _fetchOrCreateOnion() async {
    final socket = await Socket.connect('127.0.0.1', 9051);

    socket.write('AUTHENTICATE\r\n');
    final authResponse = await _readLine(socket);
    if (!authResponse.startsWith('250')) {
      throw Exception('Tor ControlPort authentication failed: $authResponse');
    }

    socket.write('ADD_ONION NEW:ED25519-V3 Port=8080,127.0.0.1:8080\r\n');
    final onionResponse = await _readLine(socket);
    if (!onionResponse.startsWith('250-ServiceID=')) {
      throw Exception('Failed to create hidden service: $onionResponse');
    }

    final serviceIdLine = onionResponse
        .split('\r\n')
        .firstWhere((line) => line.startsWith('250-ServiceID='));
    final onion = '${serviceIdLine.replaceFirst('250-ServiceID=', '')}.onion';

    socket.write('QUIT\r\n');
    await socket.flush();
    await socket.close();

    return onion;
  }

  Future<String> _readLine(Socket socket) async {
    final completer = Completer<String>();
    final buffer = <int>[];

    void listener(List<int> data) {
      for (final byte in data) {
        if (byte == 10) {
          final line = utf8.decode(buffer).trim();
          buffer.clear();
          completer.complete(line);
          socket.listen(null).cancel();
          return;
        } else {
          buffer.add(byte);
        }
      }
    }

    socket.listen(listener);
    return completer.future;
  }
}
