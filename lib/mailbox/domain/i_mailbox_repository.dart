import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';

abstract class IMailboxRepository {
  Future<Either<Failure, Unit>> addMailbox({
    required String onionAddress,
    required String pin,
  });
  Future<Either<Failure, bool>> pingMailbox(String onionAddress);
  Future<void> pingAllMailboxes();
}
