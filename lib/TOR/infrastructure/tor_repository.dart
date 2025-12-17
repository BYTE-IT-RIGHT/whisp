import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flick/TOR/domain/i_tor_repository.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITorRepository)
class TorRepository implements ITorRepository {
  static const int _socksPort = 9050;
  
  String? _onionAddress;
  bool _initialized = false;

  /// Inicjalizacja repozytorium
  /// Sprawdza czy Orbot SOCKS proxy jest dostępny
  @override
  Future<Either<Failure, Unit>> init() async {
    try {
      if (_initialized) return right(unit);

      // Sprawdzenie, czy Tor SOCKS proxy działa (Orbot)
      final isRunning = await _isTorRunning();
      if (!isRunning) {
        return left(TorNotRunningError());
      }

      // Orbot nie udostępnia Control Port (9051) domyślnie,
      // więc nie możemy tworzyć hidden services programowo.
      // Hidden service musiałby być skonfigurowany inaczej
      // (np. przez embedded Tor lub serwer zewnętrzny).
      
      _initialized = true;
      log('TOR repository initialized - SOCKS proxy available on port $_socksPort');
      return right(unit);
    } catch (e, st) {
      log('TOR repository init unexpected error: $e\n$st');
      return left(TorNotRunningError());
    }
  }

  /// Sprawdzenie, czy Tor SOCKS proxy działa
  Future<bool> _isTorRunning() async {
    try {
      final socket = await Socket.connect(
        '127.0.0.1',
        _socksPort,
        timeout: const Duration(seconds: 3),
      );
      socket.destroy();
      return true;
    } catch (e) {
      log('Tor SOCKS proxy not available: $e');
      return false;
    }
  }

  /// Zwraca `.onion` użytkownika
  /// UWAGA: Wymaga Control Port, który Orbot nie udostępnia domyślnie
  @override
  Future<Either<Failure, String>> getOnionAddress() async {
    if (!_initialized) {
      final initResult = await init();
      if (initResult.isLeft()) {
        return left(initResult.swap().getOrElse(() => TorNotRunningError()));
      }
    }

    if (_onionAddress == null) {
      // Orbot nie udostępnia Control Port - nie można utworzyć hidden service
      return left(TorControlPortNotAvailableError());
    }

    return right(_onionAddress!);
  }

  @override
  Future<Either<Failure, Unit>> dispose() async {
    try {
      _initialized = false;
      _onionAddress = null;
      return right(unit);
    } catch (e) {
      log('Error disposing TorRepository: $e');
      return left(UnexpectedError());
    }
  }
  
  /// Zwraca port SOCKS proxy do użycia z HttpClient
  int get socksPort => _socksPort;
  
  /// Czy repozytorium jest zainicjalizowane
  bool get isInitialized => _initialized;
}
