import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/messaging/domain/message.dart';

abstract class IMessagesRepository {
  Future<Either<Failure, Unit>> startListener();

  Future<Either<Failure, Unit>> stopListener();

  /// When the user has a mailbox configured, downloads queued messages and
  /// persists them to the correct conversations (non-blocking on failure).
  Future<Either<Failure, Unit>> syncMailboxInboxIfConfigured();

  Stream<Message> get incomingMessages;

  bool get isRunning;
}
