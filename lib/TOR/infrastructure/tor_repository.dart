import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:tor_hidden_service/tor_hidden_service.dart';

@LazySingleton(as: ITorRepository)
class TorRepository implements ITorRepository {
  final TorHiddenService _torHiddenService = TorHiddenService();

  String? _onionAddress;
  bool _initialized = false;
  StreamSubscription<String>? _logSubscription;

  @override
  Future<Either<Failure, Unit>> init() async {
    try {
      if (_initialized) return right(unit);

      log('Starting Tor with hidden service...');

      // Nasłuchuj logów Tora
      _logSubscription = _torHiddenService.onLog.listen((logMessage) {
        log('TOR: $logMessage');
      });

      // Uruchom Tor z hidden service
      final result = await _torHiddenService.start();
      log('Tor start result: $result');

      // Poczekaj chwilę na bootstrap
      await Future.delayed(const Duration(seconds: 2));

      // Pobierz adres .onion
      _onionAddress = await _torHiddenService.getOnionHostname();

      if (_onionAddress == null) {
        log('Failed to get onion hostname');
        return left(TorHiddenServiceError());
      }

      log('🧅 Hidden service created: $_onionAddress');

      _initialized = true;
      return right(unit);
    } catch (e, st) {
      log('TOR repository init error: $e\n$st');
      return left(TorInitializationError());
    }
  }

  @override
  Future<Either<Failure, String>> getOnionAddress() async {
    if (!_initialized) {
      final initResult = await init();
      if (initResult.isLeft()) {
        return left(initResult.swap().getOrElse(() => TorNotRunningError()));
      }
    }

    if (_onionAddress == null) {
      // Spróbuj pobrać ponownie
      _onionAddress = await _torHiddenService.getOnionHostname();
      if (_onionAddress == null) {
        return left(TorHiddenServiceError());
      }
    }

    return right(_onionAddress!);
  }

  /// Wykonaj request HTTP GET przez Tor do adresu .onion
  @override
  Future<Either<Failure, TorResponse>> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      if (!_initialized) {
        final initResult = await init();
        if (initResult.isLeft()) {
          return left(TorNotRunningError());
        }
      }

      final client = _torHiddenService.getUnsecureTorClient();
      final response = await client.get(url, headers: headers);
      return right(response);
    } catch (e, st) {
      log('TOR GET error: $e\n$st');
      return left(TorConnectionError());
    }
  }

  @override
  Future<Either<Failure, TorResponse>> post(
    String url, {
    Map<String, String>? headers,
    String? body,
  }) async {
    try {
      if (!_initialized) {
        final initResult = await init();
        if (initResult.isLeft()) {
          return left(TorNotRunningError());
        }
      }

      final client = _torHiddenService.getUnsecureTorClient();
      final response = await client.post(url, headers: headers, body: body);
      return right(response);
    } catch (e, st) {
      log('TOR POST error: $e\n$st');
      return left(TorConnectionError());
    }
  }

  @override
  Future<Either<Failure, Unit>> dispose() async {
    try {
      await _logSubscription?.cancel();
      await _torHiddenService.stop();
      _initialized = false;
      _onionAddress = null;
      log('TOR repository disposed');
      return right(unit);
    } catch (e) {
      log('Error disposing TorRepository: $e');
      return left(UnexpectedError());
    }
  }

  /// Port HTTP proxy Tora (domyślnie 9080)
  @override
  int get socksPort => 9080;

  @override
  bool get isInitialized => _initialized;

  /// Strumień logów z Tora
  Stream<String> get torLogs => _torHiddenService.onLog;
}
