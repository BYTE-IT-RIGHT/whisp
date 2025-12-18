import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';

abstract class IAddContactRepository {
  Future<Either<Failure, Unit>> addContact(String onionAddress);
}
