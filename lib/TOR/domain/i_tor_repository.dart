import 'package:dartz/dartz.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:tor_hidden_service/tor_hidden_service.dart';

abstract class ITorRepository {
  Future<Either<Failure, Unit>> init();

  Future<Either<Failure, String>> getOnionAddress();

  Future<Either<Failure, TorResponse>> get(
    String url, {
    Map<String, String>? headers,
  });

  Future<Either<Failure, TorResponse>> post(
    String url, {
    Map<String, String>? headers,
    String? body,
  });

  Future<Either<Failure, Unit>> dispose();

  int get socksPort;

  bool get isInitialized;

  Stream<String> get torLogs;
}
