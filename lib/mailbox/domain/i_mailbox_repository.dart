import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';

abstract class IMailboxRepository {
  Future<Either<Failure, Unit>> addMailbox({
    required String onionAddress,
    required String pin,
  });

  /// Fetches queued messages from the user's mailbox (`POST /download`).
  /// Each map is a JSON payload compatible with [Message.fromJson].
  Future<Either<Failure, List<Map<String, dynamic>>>> downloadQueuedMessages({
    required String onionAddress,
    required String pin,
  });

  Future<Either<Failure, bool>> pingMailbox(String onionAddress);
  Future<void> pingAllMailboxes();
}
