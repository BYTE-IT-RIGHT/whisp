import 'package:dartz/dartz.dart';
import 'package:flick/common/domain/failure.dart';

abstract class ITorRepository {
  Future<Either<Failure, Unit>> init();

  Future<Either<Failure, String>> getOnionAddress();

  Future<void> dispose();
}
