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

  @override
  Future<Either<Failure, Unit>> init() async {
    try {
      if (_initialized) return right(unit);

      await _torHiddenService.start();

      _onionAddress = await _torHiddenService.getOnionHostname();

      if (_onionAddress == null) {
        log('TorRepository Failed to get onion hostname');
        return left(TorHiddenServiceError());
      }

      _initialized = true;
      return right(unit);
    } catch (e) {
      log('TOR repository init error: $e');
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
      _onionAddress = await _torHiddenService.getOnionHostname();
      if (_onionAddress == null) {
        return left(TorHiddenServiceError());
      }
    }

    return right(_onionAddress!);
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
    } catch (e) {
      log('TOR POST error: $e');
      return left(TorConnectionError());
    }
  }

  @override
  Future<Either<Failure, Unit>> dispose() async {
    try {
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

  @override
  bool get isInitialized => _initialized;

  @override
  Stream<String> get torLogs => _torHiddenService.onLog;
}
