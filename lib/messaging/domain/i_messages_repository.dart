import 'package:dartz/dartz.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/messaging/domain/message.dart';

abstract class IMessagesRepository {
  Future<Either<Failure, Unit>> startListener();

  Future<Either<Failure, Unit>> stopListener();

  Stream<Message> get incomingMessages;

  bool get isRunning;
}
