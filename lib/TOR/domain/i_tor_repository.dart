import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:tor_hidden_service/tor_hidden_service.dart';

abstract class ITorRepository {
  Future<Either<Failure, Unit>> init();

  Future<Either<Failure, String>> getOnionAddress();

  Future<Either<Failure, TorResponse>> post(
    String url, {
    Map<String, String>? headers,
    String? body,
  });

  /// Check Tor connectivity by reaching an external onion service
  Future<Either<Failure, Unit>> checkTorConnectivity();

  Future<Either<Failure, Unit>> dispose();

  bool get isInitialized;

  Stream<String> get torLogs;
}
