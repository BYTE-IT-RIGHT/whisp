import 'package:dartz/dartz.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/messaging/domain/message.dart';

abstract class IChatRepository {
  /// Sends a text message to the specified onion address
  Future<Either<Failure, Unit>> sendMessage({
    required String recipientOnionAddress,
    required String content,
  });

  /// Gets paginated messages for a conversation
  Future<Either<Failure, MessagePage>> getMessages(
    String conversationId, {
    int limit = 20,
    DateTime? before,
  });

  /// Watch messages stream for real-time updates
  Stream<List<Message>> watchMessages(String conversationId);

  /// Pings a recipient to check if they are online
  Future<Either<Failure, bool>> pingUser(String recipientOnionAddress);
}

