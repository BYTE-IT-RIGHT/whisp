import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/messaging/domain/message.dart';

abstract class IMessagesRepository {
  Future<Either<Failure, Unit>> startListener();

  Future<Either<Failure, Unit>> stopListener();

  Stream<Message> get incomingMessages;

  bool get isRunning;
}
